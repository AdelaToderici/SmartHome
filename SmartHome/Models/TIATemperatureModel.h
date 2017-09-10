//
//  TIATemperatureModel.h
//  SmartHome
//
//  Created by Adela Toderici on 4/21/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIASerializable.h"

@interface TIATemperatureModel : NSObject <TIASerializable>

@property (nonatomic, strong) NSString *publicID;
@property (nonatomic, assign) NSInteger temperatureValue;

@end
