//
//  TIASmartHomeService_NSURLSession.m
//  SmartHome
//
//  Created by Adela Toderici on 3/11/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIASmartHomeService_NSURLSession.h"
#import "TIASmartHomeService_NSURLSessionRequest.h"
#import "NSArray+Enumerator.h"

@interface TIASmartHomeService_NSURLSession() <TIASmartHomeService_NSURLSessionRequestDelegate>

@property (nonatomic, strong) NSMutableDictionary *requests;
@property (nonatomic, strong) NSMutableArray *requestsPending;

@end

@implementation TIASmartHomeService_NSURLSession

- (id)init {
    
    if ((self = [super init])) {
        
        self.requests = [NSMutableDictionary dictionary];
        self.requestsPending = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Subclass methods

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

- (NSString *)submitRequestWithURL:(NSURL *)URL
                            method:(NSString *)httpMethod
                              body:(NSDictionary *)bodyDict
                    expectedStatus:(NSInteger)expectedStatus
                           success:(TIASmartHomeServiceSuccess)success
                           failure:(TIASmartHomeServiceFailure)failure {

    NSMutableURLRequest *request = [self requestForURL:URL method:httpMethod bodyDict:bodyDict];
    
    TIASmartHomeService_NSURLSessionRequest *sessionRequest = [[TIASmartHomeService_NSURLSessionRequest alloc]
                                                               initWithRequest:request
                                                               usingSession:[NSURLSession sharedSession]
                                                               expectedStatus:expectedStatus
                                                               success:success
                                                               failure:failure
                                                               delegate:self];
    
    self.requests[sessionRequest.requestIdentifier] = sessionRequest;
    
    return sessionRequest.requestIdentifier;
}

- (void)cancelRequestWithIdentifier:(NSString *)identifier {
    
    TIASmartHomeService_NSURLSessionRequest *request = self.requests[identifier];
    
    if (request) {
        
        [request cancel];
        [self.requests removeObjectForKey:identifier];
    }
}

- (void)resendRequestsPending {
    
    for (TIASmartHomeService_NSURLSessionRequest *request in self.requestsPending) {
        [request restart];
    }
    
    [self.requestsPending removeAllObjects];
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

#pragma mark - TIASmartHomeService_NSURLSessionRequestDelegate

- (void)sessionRequestDidComplete:(TIASmartHomeService_NSURLSessionRequest *)request {
    
    [self.requests removeObjectForKey:request.requestIdentifier];
    [self.requestsPending removeObject:request];
}

- (void)sessionRequestFailed:(TIASmartHomeService_NSURLSessionRequest *)request {
    
    [self.requests removeObjectForKey:request.requestIdentifier];
    [self.requestsPending removeObject:request];
}

- (void)sessionRequestRequiresAuthentication:(TIASmartHomeService_NSURLSessionRequest *)request {
    
    [self.requestsPending addObject:request];
    [[NSNotificationCenter defaultCenter] postNotificationName:TIAServicePendingNotification object:nil];
}

@end
