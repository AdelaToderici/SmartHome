//
//  TIAThermostatModel.h
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIASerializable.h"

extern NSString *const kTemperaturePulicIDkey;
extern NSString *const kTemperatureKey;
extern NSString *const kTemperatureDaysKey;
extern NSString *const kTemperatureTypeKey;
extern NSString *const kThermostatStatusKey;

@interface TIAThermostatModel : NSObject <TIASerializable>

@property (nonatomic, strong) NSString *publicID;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, assign) NSInteger temperatureType;
@property (nonatomic, assign) NSInteger thermostatStatus;
@property (nonatomic, strong) NSArray *tempDaysArray;

- (instancetype)initWithPublicID:(NSString *)publicID
                     temperature:(NSString *)temperature
                 temperatureType:(BOOL)tempType
                          status:(BOOL)status
                 temperatureDays:(NSArray *)tempDaysArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
