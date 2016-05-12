//
//  SensorResponseModel.m
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "SensorResponseModel.h"

@class SensorModel;

@implementation SensorResponseModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"articles" : @"response.docs",
             @"status" : @"status"
             };
}

#pragma mark - JSON Transformer

+ (NSValueTransformer *)articlesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:SensorModel.class];
}

@end
