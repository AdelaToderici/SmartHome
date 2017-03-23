//
//  TIAThermostatModel.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIAThermostatModel.h"
#import "NSArray+Enumerator.h"

NSString *const kTemperaturePublicIDKey = @"id";
NSString *const kTemperatureKey = @"tempValue";
NSString *const kTemperatureDaysKey = @"tempDays";
NSString *const kTemperatureTypeKey = @"tempType";
NSString *const kThermostatStatusKey = @"thermoStatus";

@implementation TIAThermostatModel

- (instancetype)initWithPublicID:(NSString *)publicID
                     temperature:(NSString *)temperature
                 temperatureType:(BOOL)tempType
                          status:(BOOL)status
                 temperatureDays:(NSArray *)tempDaysArray {
    
    
    if ((self = [super init])) {
        
        self.publicID         = publicID;
        self.temperature      = temperature;
        self.temperatureType  = tempType;
        self.thermostatStatus = status;
        self.tempDaysArray    = tempDaysArray;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSArray *daysFromDictionary = [dictionary[kTemperatureDaysKey] mappedArrayWithBlock:^id(id obj) {
        return obj;
    }];
    
    return [self initWithPublicID:dictionary[kTemperaturePublicIDKey]
                      temperature:dictionary[kTemperatureKey]
                  temperatureType:[self intFromString:dictionary[kTemperatureTypeKey]]
                           status:[self intFromString:dictionary[kThermostatStatusKey]]
                  temperatureDays:daysFromDictionary];
}

- (NSDictionary *)dictionaryRepresentation {
    
    NSArray *daysFromDictionary = [self.tempDaysArray mappedArrayWithBlock:^id(id obj) {
        return obj;
    }];
    
    return @{ kTemperaturePublicIDKey : self.publicID,
              kTemperatureKey         : self.temperature,
              kTemperatureTypeKey     : [NSNumber numberWithInteger:self.temperatureType],
              kThermostatStatusKey    : [NSNumber numberWithInteger:self.thermostatStatus],
              kTemperatureDaysKey     : daysFromDictionary };
}

#pragma mark - Helper Methods

- (NSInteger)intFromString:(NSString *)string {
        
    return [string integerValue];
}

@end
