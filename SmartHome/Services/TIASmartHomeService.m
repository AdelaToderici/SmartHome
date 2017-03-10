//
//  TIASmartHomeService.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIASmartHomeService.h"
#import "TIASmartHome_NSURLConnection.h"

static TIASmartHomeService *SharedInstance;

@implementation TIASmartHomeService

+ (TIASmartHomeService *)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [[TIASmartHome_NSURLConnection alloc] init];
    });
    
    return SharedInstance;
}

@end
