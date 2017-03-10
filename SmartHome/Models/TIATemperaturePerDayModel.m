//
//  TIATemperaturePerDayModel.m
//  SmartHome
//
//  Created by Adela Toderici on 3/10/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIATemperaturePerDayModel.h"

NSString *const kTemperaturePDPublicIDKey = @"id";
NSString *const kTemperaturePerDayKey = @"tempPerDay";

@implementation TIATemperaturePerDayModel

- (instancetype)initWithPublicID:(NSString *)publicID andName:(NSInteger)tempPerDay {
    
    if (self = [super init]) {
        
        self.pulicID = publicID;
        self.tempPerDay = tempPerDay;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    return [self initWithPublicID:dictionary[kTemperaturePDPublicIDKey]
                          andName:[self intFromString:dictionary[kTemperaturePerDayKey]]];
}

- (NSDictionary *)dictionaryRepresentation {
    
    return @{ kTemperaturePDPublicIDKey : self.pulicID,
              kTemperaturePerDayKey : [NSNumber numberWithInteger:self.tempPerDay] };
}

#pragma mark - Helper Methods

- (NSInteger)intFromString:(NSString *)string {
    
    return [string integerValue];
}

@end
