//
//  TIAWashingMachineModel.h
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kWashingMachinePublicID;
extern NSString *const kWashingMachineTemperature;
extern NSString *const kWashingMachineRPM;
extern NSString *const kWashingMachineTime;

@interface TIAWashingMachineModel : NSObject

@property (nonatomic, strong) NSString *pulicID;
@property (nonatomic, assign) NSInteger temperature;
@property (nonatomic, assign) NSInteger RPM;
@property (nonatomic, assign) NSInteger time;

- (instancetype)initWithPublicID:(NSString *)publicID
                     temperature:(NSInteger)temperature
                             RPM:(NSInteger)RPM
                            time:(NSInteger)time;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
