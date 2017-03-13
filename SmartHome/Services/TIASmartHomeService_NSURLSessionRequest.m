//
//  TIASmartHomeService_NSURLSessionRequest.m
//  SmartHome
//
//  Created by Adela Toderici on 3/11/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIASmartHomeService_NSURLSessionRequest.h"
#import "NSHTTPURLResponse+SmartHomeExtensions.h"

@interface TIASmartHomeService_NSURLSessionRequest()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSString *requestIdentifier;

@end

@implementation TIASmartHomeService_NSURLSessionRequest

- (instancetype)initWithRequest:(NSURLRequest *)request
                   usingSession:(NSURLSession *)session
                 expectedStatus:(NSUInteger)status
                        success:(TIASmartHomeServiceSuccess)success
                        failure:(TIASmartHomeServiceFailure)failure
                       delegate:(id<TIASmartHomeService_NSURLSessionRequestDelegate>)delegate {
    
    if ((self = [super init])) {
        self.URLRequest = request;
        self.session = session;
        self.successBlock = success;
        self.failureBlock = failure;
        self.delegate = delegate;
        
        self.requestIdentifier = [[NSUUID UUID] UUIDString];
        
        self.task = [self createDataTask];
        [self.task resume];
    }
    
    return self;
}

- (NSURLSessionDataTask *)createDataTask {
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [self.session
                                  dataTaskWithRequest:self.URLRequest
                                  completionHandler:^(NSData * _Nullable data,
                                                      NSURLResponse * _Nullable response,
                                                      NSError * _Nullable error) {
                                      
                                      NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                                      NSMutableURLRequest *mutableRequest = (NSMutableURLRequest *)weakSelf.URLRequest;
                                      
                                      if (HTTPResponse.statusCode == weakSelf.expectedStatus) {
                                          
                                          NSLog(@"%@ %@ %li SUCCESS",
                                                [mutableRequest HTTPMethod],
                                                [mutableRequest URL],
                                                (long)HTTPResponse.statusCode);
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              weakSelf.successBlock(data);
                                              [weakSelf.delegate sessionRequestDidComplete:weakSelf];
                                          });
                                          
                                      } else if (HTTPResponse.statusCode == 401) {
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [weakSelf.delegate sessionRequestRequiresAuthentication:weakSelf];
                                          });
                                          
                                      } else {
                                          
                                          NSLog(@"%@ %@ %li INVALID STATUS CODE",
                                                [mutableRequest HTTPMethod],
                                                [mutableRequest URL],
                                                (long)HTTPResponse.statusCode);
                                          
                                          NSString *message = [HTTPResponse errorMessageWithData:data];
                                          
                                          NSError *error = [NSError errorWithDomain:@"SmartHomeService"
                                                                               code:HTTPResponse.statusCode
                                                                           userInfo:@{ NSLocalizedDescriptionKey : message }];
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              weakSelf.failureBlock(error);
                                              [weakSelf.delegate sessionRequestFailed:weakSelf];
                                          });
                                      }
                                  }];
    return task;
}

- (void)cancel {
    
    [self.task cancel];
    self.task = nil;
}

- (void)restart {
    
    [self cancel];
    self.task = [self createDataTask];
    [self.task resume];
}

@end
