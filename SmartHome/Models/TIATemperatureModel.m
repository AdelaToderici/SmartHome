//
//  TIATemperatureModel.m
//  SmartHome
//
//  Created by Adela Toderici on 4/21/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIATemperatureModel.h"

NSString *const kTemperatureModelPublicID = @"_id";
NSString *const kTemperatureModelValue = @"value";

@implementation TIATemperatureModel

- (instancetype)initWithPublicID:(NSString *)publicID
                           value:(NSInteger)temperatureValue {
    
    if ((self = [super init])) {
        
        self.publicID = publicID;
        self.temperatureValue = temperatureValue;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    return [self initWithPublicID:dictionary[kTemperatureModelPublicID]
                            value:[dictionary[kTemperatureModelValue] integerValue]];
    
}

- (NSDictionary *)dictionaryRepresentation {
    
    return @{kTemperatureModelPublicID : self.publicID,
             kTemperatureModelValue    : [NSNumber numberWithInteger:self.temperatureValue]};
}

@end
