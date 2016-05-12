//
//  SessionManager.h
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"

@interface SessionManager : AFHTTPSessionManager

+ (id)sharedManager;

@end
