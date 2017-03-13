//
//  TIASmartHomeService_NSURLSessionRequest.h
//  SmartHome
//
//  Created by Adela Toderici on 3/11/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TIASmartHomeService.h"

@protocol TIASmartHomeService_NSURLSessionRequestDelegate;

@interface TIASmartHomeService_NSURLSessionRequest : NSObject

@property (nonatomic, strong) NSURLRequest *URLRequest;
@property (nonatomic, assign) NSInteger expectedStatus;
@property (nonatomic, copy) TIASmartHomeServiceSuccess successBlock;
@property (nonatomic, copy) TIASmartHomeServiceFailure failureBlock;
@property (nonatomic, weak) id<TIASmartHomeService_NSURLSessionRequestDelegate> delegate;

- (instancetype)initWithRequest:(NSURLRequest *)request
                   usingSession:(NSURLSession *)session
                 expectedStatus:(NSUInteger)status
                        success:(TIASmartHomeServiceSuccess)success
                        failure:(TIASmartHomeServiceFailure)failure
                       delegate:(id<TIASmartHomeService_NSURLSessionRequestDelegate>)delegate;

- (void)cancel;

- (void)restart;

- (NSString *)requestIdentifier;

@end

@protocol TIASmartHomeService_NSURLSessionRequestDelegate <NSObject>

- (void)sessionRequestDidComplete:(TIASmartHomeService_NSURLSessionRequest *)request;

- (void)sessionRequestFailed:(TIASmartHomeService_NSURLSessionRequest *)request;

- (void)sessionRequestRequiresAuthentication:(TIASmartHomeService_NSURLSessionRequest *)request;

@end
