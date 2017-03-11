//
//  TIASmartHomeService_NSURLConnectionRequest.h
//  SmartHome
//
//  Created by Adela Toderici on 3/11/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TIASmartHome_NSURLConnectionRequestDelegate;

@interface TIASmartHomeService_NSURLConnectionRequest : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

- (instancetype)initWithRequest:(NSURLRequest *)request
             expectedCodeStatus:(NSInteger)statusCode
                        success:(TIASmartHomeServiceSuccess)success
                        failure:(TIASmartHomeServiceFailure)failure
                       delegate:(id<TIASmartHome_NSURLConnectionRequestDelegate>)delegate;

- (void)cancel;

- (void)restart;

- (NSString *)uniqueIdentifier;

@end

@protocol TIASmartHome_NSURLConnectionRequestDelegate <NSObject>

- (void)requestDidComplete:(TIASmartHomeService_NSURLConnectionRequest *)request;

@end
