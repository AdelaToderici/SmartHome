//
//  NSHTTPURLResponse+SmartHomeExtensions.m
//  SmartHome
//
//  Created by Adela Toderici on 3/11/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "NSHTTPURLResponse+SmartHomeExtensions.h"

@implementation NSHTTPURLResponse (SmartHomeExtensions)

- (NSString *)errorMessageWithData:(NSData *)data {
    
    NSString *message = [NSString stringWithFormat:@"Unexpected response code: %li",
                         (long)self.statusCode];
    if (data) {
        NSError *jsonError = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data
                                                  options:0
                                                    error:&jsonError];
        
        if (json && [json isKindOfClass:[NSDictionary class]]) {
            
            NSString *errorMessage = [(NSDictionary *)json valueForKey:@"error"];
            
            if (errorMessage) {
                message = errorMessage;
            }
        }
    }
    
    return message;
}

@end
