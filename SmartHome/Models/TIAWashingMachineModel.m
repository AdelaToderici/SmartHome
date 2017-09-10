//
//  TIAWashingMachineModel.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIAWashingMachineModel.h"

NSString *const kWashingMachinePublicID    = @"_id";
NSString *const kWashingMachineTemperature = @"temp";
NSString *const kWashingMachineRPM         = @"rpm";
NSString *const kWashingMachineTime        = @"time";

@implementation TIAWashingMachineModel

- (instancetype)initWithPublicID:(NSString *)publicID
                     temperature:(NSString *)temperature
                             RPM:(NSString *)RPM
                            time:(NSString *)time {
    
    if ((self = [super init])) {
        
        self.pulicID = publicID;
        self.temperature = temperature;
        self.RPM = RPM;
        self.time = time;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    return [self initWithPublicID:dictionary[kWashingMachinePublicID]
                      temperature:dictionary[kWashingMachineTemperature]
                              RPM:dictionary[kWashingMachineRPM]
                             time:dictionary[kWashingMachineTime]];
}

- (NSDictionary *)dictionaryRepresentation {
    
    return @{ kWashingMachinePublicID    : self.pulicID,
              kWashingMachineTemperature : self.temperature,
              kWashingMachineRPM         : self.RPM,
              kWashingMachineTime        : self.time};
}

@end
