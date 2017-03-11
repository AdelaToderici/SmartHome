//
//  TIASmartHomeService_NSURLConnection.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIASmartHomeService_NSURLConnection.h"
#import "TIASmartHomeService_NSURLConnectionRequest.h"
#import "TIASmartHomeService_SubclassMethods.h"
#import "NSArray+Enumerator.h"

@interface TIASmartHomeService_NSURLConnection() <TIASmartHome_NSURLConnectionRequestDelegate>

@property (nonatomic, strong) NSMutableArray *requestPadingAuthentification;

@end

@implementation TIASmartHomeService_NSURLConnection

- (NSString *)submitRequestWithURL:(NSURL *)url
                            method:(NSString *)httpMethod
                              body:(NSDictionary *)bodyDict
                    expectedStatus:(NSInteger)expectedStatus
                           success:(TIASmartHomeServiceSuccess)success
                           failure:(TIASmartHomeServiceFailure)failure {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:httpMethod];
    
    // HTTP body content is encoded
    if (bodyDict) {
        
        [request setHTTPBody:[self formEncodedParameters:bodyDict]];
        [request addValue:@"application/x-www-form-urlencoded"
       forHTTPHeaderField:@"Content-Type"];
    }
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    TIASmartHomeService_NSURLConnectionRequest *connectionRequest;
    connectionRequest = [[TIASmartHomeService_NSURLConnectionRequest alloc] initWithRequest:request
                                                                         expectedCodeStatus:expectedStatus
                                                                                    success:success
                                                                                    failure:false
                                                                                   delegate:self];
    
    NSString *connectionID = [connectionRequest uniqueIdentifier];
    [self.requests setObject:connectionRequest forKey:connectionID];
    
    return connectionID;
}

- (void)cancelRequestWithIdentifier:(NSString *)identifier {
    
    TIASmartHomeService_NSURLConnectionRequest *request = [self.requests objectForKey:identifier];
    
    if (request) {
        
        [request cancel];
        [self.requests removeObjectForKey:identifier];
    }
}

#pragma mark - Private helpers

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

#pragma mark - TIASmartHome_NSURLConnectionRequestDelegate

- (void)requestDidComplete:(TIASmartHomeService_NSURLConnectionRequest *)request {
    
    [self.requests removeObjectForKey:[request uniqueIdentifier]];
}

@end
