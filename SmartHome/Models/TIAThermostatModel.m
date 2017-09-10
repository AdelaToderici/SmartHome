//
//  TIAThermostatModel.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIAThermostatModel.h"
#import "NSArray+Enumerator.h"

NSString *const kTemperaturePublicIDKey = @"_id";
NSString *const kTemperatureTypeKey     = @"tempType";
NSString *const kThermostatStatusKey    = @"thermoStatus";

@implementation TIAThermostatModel

- (instancetype)initWithPublicID:(NSString *)publicID
                 temperatureType:(NSString *)tempType
                          status:(NSString *)status {
    
    
    if ((self = [super init])) {
        
        self.publicID         = publicID;
        self.temperatureType  = tempType;
        self.thermostatStatus = status;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    return [self initWithPublicID:dictionary[kTemperaturePublicIDKey]
                  temperatureType:dictionary[kTemperatureTypeKey]
                           status:dictionary[kThermostatStatusKey]];
}

- (NSDictionary *)dictionaryRepresentation {
    
    return @{kTemperaturePublicIDKey : self.publicID,
             kTemperatureTypeKey     : self.temperatureType,
             kThermostatStatusKey    : self.thermostatStatus};
}

@end
