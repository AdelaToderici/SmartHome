//
//  SensorRealm.h
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "SensorModel.h"

@interface SensorRealm : RLMObject

//@property NSInteger sensorId;
//@property NSString *sensorName;
//@property NSDictionary *sensorDictionary;
//
//- (id)initWithMantleModel:(SensorModel *)articleModel;

@property NSString *leadParagraph;
@property NSString *url;

- (id)initWithMantleModel:(SensorModel *)articleModel;

@end
