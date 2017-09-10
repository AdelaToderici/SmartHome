//
//  TIAThermostatModel.h
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIASerializable.h"

extern NSString *const kTemperaturePublicIDKey;
extern NSString *const kTemperatureDaysKey;
extern NSString *const kTemperatureTypeKey;

@interface TIAThermostatModel : NSObject <TIASerializable>

@property (nonatomic, strong) NSString *publicID;
@property (nonatomic, assign) NSString *temperatureType;
@property (nonatomic, assign) NSString *thermostatStatus;

- (instancetype)initWithPublicID:(NSString *)publicID
                 temperatureType:(NSString *)tempType
                          status:(NSString *)status;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
