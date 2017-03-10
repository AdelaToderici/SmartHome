//
//  TIATemperaturePerDayModel.h
//  SmartHome
//
//  Created by Adela Toderici on 3/10/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kTemperaturePerDayKey;
extern NSString *const kTemperaturePDPublicIDKey;

@interface TIATemperaturePerDayModel : NSObject

@property (nonatomic, strong) NSString *pulicID;
@property (nonatomic, assign) NSInteger tempPerDay;

- (instancetype)initWithPublicID:(NSString *)publicID andName:(NSInteger)tempPerDay;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
