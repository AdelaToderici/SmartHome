//
//  TIAWashingMachineModel.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIAWashingMachineModel.h"

NSString *const kWashingMachinePublicID = @"id";
NSString *const kWashingMachineTemperature = @"temp";
NSString *const kWashingMachineRPM = @"rpm";
NSString *const kWashingMachineTime = @"time";

@implementation TIAWashingMachineModel

- (instancetype)initWithPublicID:(NSString *)publicID
                     temperature:(NSInteger)temperature
                             RPM:(NSInteger)RPM
                            time:(NSInteger)time {
    
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
                      temperature:[self intFromString:dictionary[kWashingMachineTemperature]]
                              RPM:[self intFromString:dictionary[kWashingMachineRPM]]
                             time:[self intFromString:dictionary[kWashingMachineTime]]];
}

- (NSDictionary *)dictionaryRepresentation {
    
    return @{ kWashingMachinePublicID    : self.pulicID,
              kWashingMachineTemperature : [NSNumber numberWithInteger:self.temperature],
              kWashingMachineRPM         : [NSNumber numberWithInteger:self.RPM],
              kWashingMachineTime        : [NSNumber numberWithInteger:self.time] };
}

#pragma mark - Helper Methods

- (NSInteger)intFromString:(NSString *)string {
    
    return [string integerValue];
}

@end
