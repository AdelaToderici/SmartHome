//
//  TIASmartHomeService_NSURLConnectionRequest.m
//  SmartHome
//
//  Created by Adela Toderici on 3/11/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIASmartHomeService.h"
#import "TIASmartHomeService_NSURLConnectionRequest.h"

@interface TIASmartHomeService_NSURLConnectionRequest()

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSString *uniqueIdentifier;
@property (nonatomic, strong) TIASmartHomeServiceSuccess successCallback;
@property (nonatomic, strong) TIASmartHomeServiceFailure failureCallback;
@property (nonatomic, assign) NSInteger expectedStatusCode;
@property (nonatomic, assign) NSInteger actualStatusCode;
@property (nonatomic, weak) id<TIASmartHome_NSURLConnectionRequestDelegate> delegate;

@end

@implementation TIASmartHomeService_NSURLConnectionRequest

- (instancetype)initWithRequest:(NSURLRequest *)request
             expectedCodeStatus:(NSInteger)statusCode
                        success:(TIASmartHomeServiceSuccess)success
                        failure:(TIASmartHomeServiceFailure)failure
                       delegate:(id<TIASmartHome_NSURLConnectionRequestDelegate>)delegate {
    
    if ((self = [super init])) {
        
        self.request = request;
        self.expectedStatusCode = statusCode;
        self.successCallback = success;
        self.failureCallback = failure;
        self.uniqueIdentifier = [[NSUUID UUID] UUIDString];
        self.delegate = delegate;
        
        [self initiateRequest];
    }
    
    return self;
}

- (void)initiateRequest {
    
    self.response = nil;
    self.data = [NSMutableData data];
    self.actualStatusCode = NSNotFound;
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self.delegate];
}

- (void)cancel {
    
    [self.connection cancel];
}

- (void)restart {
    
    [self cancel];
    [self initiateRequest];
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSURLRequest *request = [connection originalRequest];
    
    [connection cancel];
    
    NSLog(@"%@ %@ %li FAIL %@", [request HTTPMethod], [request URL], (long)self.expectedStatusCode, error);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.failureCallback(error);
    });
    
    [self.delegate requestDidComplete:self];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(nonnull NSURLResponse *)response {
    
    self.response = response;
    NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
    self.actualStatusCode = responseCode;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSURLRequest *request = [connection originalRequest];
    
    if ([self hasExpectedStatusCode]) {
        
        NSLog(@"%@ %@ %li SUCCESS", [request HTTPMethod], [request URL], (long)self.expectedStatusCode);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.successCallback(self.data);
        });
        
    } else {
        
        NSLog(@"%@ %@ %li INVALID STATUS CODE", [request HTTPMethod], [request URL], (long)self.actualStatusCode);
        
        NSString *message = [NSString stringWithFormat:@"Unexpected response code: %li", (long)self.actualStatusCode];
        
        if (self.data) {
            NSError *jsonError = nil;
            id json = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&jsonError];
            
            if (json && [json isKindOfClass:[NSDictionary class]]) {
                NSString *errorMessage = [(NSDictionary *)json valueForKey:@"error"];
                if (errorMessage) {
                    message = errorMessage;
                }
            }
        }
        
        NSError *error = [NSError errorWithDomain:@"SmartHomeService"
                                             code:self.actualStatusCode
                                         userInfo:@{ NSLocalizedDescriptionKey : message }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.failureCallback(error);
        });
    }
    
    [self.delegate requestDidComplete:self];
}

#pragma mark - Private helpers

- (void)appendData:(NSData *)data {
    
    [self.data appendData:data];
}

- (BOOL)hasExpectedStatusCode {
    
    if (self.actualStatusCode != NSNotFound) {
        return self.expectedStatusCode == self.actualStatusCode;
    }
    
    return NO;
}

@end
