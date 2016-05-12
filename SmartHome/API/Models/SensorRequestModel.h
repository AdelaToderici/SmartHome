//
//  SensorRequestModel.h
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "Mantle.h"

@interface SensorRequestModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *query;
@property (nonatomic, copy) NSDate *articlesFromDate;
@property (nonatomic, copy) NSDate *articlesToDate;

+ (NSDateFormatter *)dateFormatter;

@end
