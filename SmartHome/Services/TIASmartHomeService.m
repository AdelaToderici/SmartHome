//
//  TIASmartHomeService.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIASmartHomeService.h"
#import "TIAUserModel.h"
#import "TIAThermostatModel.h"
#import "NSArray+Enumerator.h"
#import "TIASmartHomeService_NSURLSession.h"

NSString *const TIAServicePendingNotification = @"TIAServicePendingNotification";

static NSString *const kServerRootKey = @"ServerURLRoot";
static NSString *const kServerURLKey = @"http://localhost:3000";
static NSString *const kUserModelKey = @"CurrentUser";
static NSString *const kUserIdentifierKey = @"UserIdentifier";

static TIASmartHomeService *SharedInstance;

@interface TIASmartHomeService ()

@property (nonatomic, strong) TIAUserModel *userModel;
@property (nonatomic, strong) NSURL *temporarServerRoot;
@property (nonatomic, strong) NSURL *serverRoot;
@property (nonatomic, strong) NSMutableDictionary *requests;

@end

@implementation TIASmartHomeService

#pragma mark - Singleton Access

+ (TIASmartHomeService *)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [[TIASmartHomeService_NSURLSession alloc] init];
    });
    
    return SharedInstance;
}

- (instancetype)init {
    
    if ((self = [super init])) {
        
        self.requests = [NSMutableDictionary dictionary];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *serverURLString = [defaults stringForKey:kServerRootKey];
        if (serverURLString != nil) {
            self.serverRoot = [NSURL URLWithString:serverURLString];
        } else {
            [self persistServerRoot];
        }
        
        // not used for the moment
        NSDictionary *userDictionary = [defaults objectForKey:kUserModelKey];
        if (userDictionary != nil) {
            self.userModel = [[TIAUserModel alloc] initWithDictionary:userDictionary];
        }
    }
    
    return self;
}

- (void)persistServerRoot
{
    self.serverRoot = [NSURL URLWithString:kServerURLKey];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.serverRoot.absoluteString forKey:kServerRootKey];
    [defaults synchronize];
}

- (BOOL)isServerNonNil {
    
    return self.serverRoot != nil;
}

#pragma mark - Thermostat methods

- (NSString *)fetchThermostatDataSuccess:(void(^)(TIAThermostatModel *thermostatModel))success
                             failure:(TIASmartHomeServiceFailure)failure {
    
    return [self submitGETPath:@"/thermostat"
                       success:^(NSData *data) {
                           if (data == nil) {
                               return;
                           }
                           NSError *error = nil;
                           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                           
                           if (dict && [dict isKindOfClass:[NSDictionary class]]) {
                               TIAThermostatModel *model = [[TIAThermostatModel alloc] initWithDictionary:dict];
                               
                               if (success != NULL) {
                                   success(model);
                               } else {
                                   if (failure != NULL) {
                                       failure(error);
                                   }
                               }
                           }
                       } failure:failure];
}

- (NSString *)postThermostatDataWithTemperature:(NSString *)temperature
                                temperatureType:(NSString *)tempType
                               thermostatStatus:(NSString *)thermostatStatus
                                        success:(void(^)())success
                                        failure:(TIASmartHomeServiceFailure)failure {
    
    NSDictionary *params = @{ @"thermostat[temperature]"      : temperature,
                              @"thermostat[tempeType]"        : tempType,
                              @"thermostat[thermostatStatus]" : thermostatStatus };
    
    return [self submitPOSTPath:@"/thermostat"
                           body:params
                 expectedStatus:200
                        success:^(NSData *data) {
                            
                            if (success != NULL) {
                                success();
                            }
                        }
                        failure:failure];
}

#pragma mark - Room methods

- (NSString *)postRoomDataWithColor:(NSString *)color
                            success:(void(^)())success
                            failure:(TIASmartHomeServiceFailure)failure {
    
    NSDictionary *params = @{ @"room[color]" : color };
    
    return [self submitPOSTPath:@"/room"
                           body:params
                 expectedStatus:200
                        success:^(NSData *data) {
                            
                            if (success != NULL) {
                                success();
                            }
                        }
                        failure:failure];
}

#pragma mark - Washing MAchine methods

- (NSString *)postWashingMachineDataWithTemperature:(NSString *)temperature
                                                RPM:(NSString *)rpm
                                               time:(NSString *)time
                                            success:(void(^)())success
                                            failure:(TIASmartHomeServiceFailure)failure {
    
    NSDictionary *params = @{@"machine[temperaure]" : temperature,
                             @"machine[RPM]"        : rpm,
                             @"machine[time]"       : time };
    
    return [self submitPOSTPath:@"/cat"  // @"/washingMachine"
                           body:params
                 expectedStatus:200
                        success:^(NSData *data) {
                            
                            if (success != NULL) {
                                success();
                            }
                        }
                        failure:failure];
}

#pragma mark - Abstract methods

- (NSString *)submitRequestWithURL:(NSURL *)url
                            method:(NSString *)httpMethod
                              body:(NSDictionary *)body
                    expectedStatus:(NSInteger)expectedStatus
                           success:(TIASmartHomeServiceSuccess)success
                           failure:(TIASmartHomeServiceFailure)failure {
    
    NSAssert(NO, @"%s must be implemented in a sub-class", __PRETTY_FUNCTION__);
    return nil;
}

- (void)cancelRequestWithIdentifier:(NSString *)identifier {
    
    NSAssert(NO, @"%s must be implemented in a sub-class", __PRETTY_FUNCTION__);
}

#pragma mark - Request Helpers

- (NSURL *)URLWithPath:(NSString *)path {
    
    NSURL *root = self.serverRoot ?: self.temporarServerRoot;
    NSAssert(root != nil, @"Request can't be make if serverRoot or temporarServerRoot are nil");
    
    return [NSURL URLWithString:path relativeToURL:root];
}

- (NSString *)submitGETPath:(NSString *)path
                    success:(TIASmartHomeServiceSuccess)success
                    failure:(TIASmartHomeServiceFailure)failure {
    
    NSURL *url = [self URLWithPath:path];
    
    return [self submitRequestWithURL:url
                               method:@"GET"
                                 body:nil
                       expectedStatus:200
                              success:success
                              failure:failure];
}

- (NSString *)submitDELETEPath:(NSString *)path
                       success:(TIASmartHomeServiceSuccess)success
                       failure:(TIASmartHomeServiceFailure)failure {
    
    NSURL *url = [self URLWithPath:path];
    
    return [self submitRequestWithURL:url
                               method:@"DELETE"
                                 body:nil
                       expectedStatus:200
                              success:success
                              failure:failure];
}

- (NSString *)submitPOSTPath:(NSString *)path
                        body:(NSDictionary *)bodyDict
              expectedStatus:(NSInteger)expectedStatus
                    success:(TIASmartHomeServiceSuccess)success
                    failure:(TIASmartHomeServiceFailure)failure {
    
    NSURL *url = [self URLWithPath:path];
    
    return [self submitRequestWithURL:url
                               method:@"POST"
                                 body:bodyDict
                       expectedStatus:expectedStatus
                              success:success
                              failure:failure];
}

- (NSString *)submitPUTPath:(NSString *)path
                        body:(NSDictionary *)bodyDict
              expectedStatus:(NSInteger)expectedStatus
                     success:(TIASmartHomeServiceSuccess)success
                     failure:(TIASmartHomeServiceFailure)failure {
    
    NSURL *url = [self URLWithPath:path];
    
    return [self submitRequestWithURL:url
                               method:@"PUT"
                                 body:bodyDict
                       expectedStatus:expectedStatus
                              success:success
                              failure:failure];
}

#pragma mark - Private helpers

- (NSMutableURLRequest *)requestForURL:(NSURL *)URL
                                method:(NSString *)httpMethod
                              bodyDict:(NSDictionary *)bodyDict {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:httpMethod];
    
    // HTTP body content is encoded
    if (bodyDict) {
        
        [request setHTTPBody:[self formEncodedParameters:bodyDict]];
        [request addValue:@"application/x-www-form-urlencoded"
       forHTTPHeaderField:@"Content-Type"];
    }
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    return request;
}

- (NSData *)formEncodedParameters:(NSDictionary *)parameters {
    
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSArray *pairs = [parameters.allKeys mappedArrayWithBlock:^id(id obj) {
        
        return [NSString stringWithFormat:@"%@=%@",
                [obj stringByAddingPercentEncodingWithAllowedCharacters:set],
                [parameters[obj] stringByAddingPercentEncodingWithAllowedCharacters:set]];
    }];
    
    NSString *formBody = [pairs componentsJoinedByString:@"&"];
    
    return [formBody dataUsingEncoding:NSUTF8StringEncoding];
}

@end
