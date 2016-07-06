//
//  SensorRequestModel.m
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "SensorRequestModel.h"

@implementation SensorRequestModel

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return dateFormatter;
}

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"query": @"q",
             @"articlesFromDate": @"begin_date",
             @"articlesToDate": @"end_date"
             };
}

#pragma mark - JSON Transformers

+ (NSValueTransformer *)articlesToDateJSONTransformer {
    return [MTLValueTransformer
            transformerUsingForwardBlock:^id(NSString *dateString,
                                             BOOL *success,
                                             NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date,
                       BOOL *success,
                       NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)articlesFromDateJSONTransformer {
    return [MTLValueTransformer
            transformerUsingForwardBlock:^id(NSString *dateString,
                                             BOOL *success,
                                             NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date,
                       BOOL *success,
                       NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}

@end
