//
//  TIAWashingMachineModel.h
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIASerializable.h"

extern NSString *const kWashingMachinePublicID;
extern NSString *const kWashingMachineTemperature;
extern NSString *const kWashingMachineRPM;
extern NSString *const kWashingMachineTime;

@interface TIAWashingMachineModel : NSObject <TIASerializable>

@property (nonatomic, strong) NSString *pulicID;
@property (nonatomic, assign) NSString *temperature;
@property (nonatomic, assign) NSString *RPM;
@property (nonatomic, assign) NSString *time;

- (instancetype)initWithPublicID:(NSString *)publicID
                     temperature:(NSString *)temperature
                             RPM:(NSString *)RPM
                            time:(NSString *)time;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
