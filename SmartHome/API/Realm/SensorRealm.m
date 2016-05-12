//
//  SensorRealm.m
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "SensorRealm.h"

@implementation SensorRealm

//- (id)initWithMantleModel:(SensorModel *)sensorModel{
//    self = [super init];
//    if(!self) return nil;
//    
//    self.sensorName = sensorModel.sensorName;
//    self.sensorDictionary = sensorModel.sensorDictionary;
//    
//    return self;
//}

- (id)initWithMantleModel:(SensorModel *)articleModel{
    self = [super init];
    if(!self) return nil;
    
    self.leadParagraph = articleModel.leadParagraph;
    self.url = articleModel.url;
    
    return self;
}

@end
