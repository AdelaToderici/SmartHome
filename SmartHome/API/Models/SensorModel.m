//
//  Sensor.m
//  HomeControl
//
//  Created by Adela Toderici on 4/30/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "SensorModel.h"

@implementation SensorModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"leadParagraph": @"lead_paragraph",
             @"url": @"web_url"
             };
}

@end
