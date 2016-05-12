//
//  SensorResponseModel.h
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import "SensorModel.h"

@interface SensorResponseModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSArray *articles;
@property (nonatomic, copy) NSString *status;

@end
