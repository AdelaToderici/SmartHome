//
//  NSHTTPURLResponse+SmartHomeExtensions.h
//  SmartHome
//
//  Created by Adela Toderici on 3/11/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHTTPURLResponse (SmartHomeExtensions)

- (NSString *)errorMessageWithData:(NSData *)data;

@end
