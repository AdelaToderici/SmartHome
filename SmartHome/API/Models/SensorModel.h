//
//  Sensor.h
//  HomeControl
//
//  Created by Adela Toderici on 4/30/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface SensorModel : MTLModel <MTLJSONSerializing>

//@property (nonatomic, assign) NSInteger sensorId;
//@property(nonatomic, strong) NSString *sensorName;
//@property(nonatomic, strong) NSDictionary *sensorDictionary;

@property (nonatomic, copy) NSString *leadParagraph;
@property (nonatomic, copy) NSString *url;

@end
