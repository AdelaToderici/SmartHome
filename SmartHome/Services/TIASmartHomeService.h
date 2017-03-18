//
//  TIASmartHomeService.h
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TIAThermostatModel;
@class TIAUserModel;

extern NSString *const TIAServicePendingNotification;

typedef void (^TIASmartHomeServiceSuccess)(NSData *data);
typedef void (^TIASmartHomeServiceFailure)(NSError *error);

@interface TIASmartHomeService : NSObject

#pragma mark - Singleton access

+ (TIASmartHomeService *)sharedInstance;

- (NSURL *)serverRoot;

#pragma mark - Thermostat methods

- (NSString *)fetchThermostatDataSuccess:(void(^)(TIAThermostatModel *thermostatModel))success
                             failure:(TIASmartHomeServiceFailure)failure;

- (NSString *)postThermostatDataWithTemperature:(NSString *)temperature
                                temperatureType:(NSString *)tempType
                               thermostatStatus:(NSString *)thermostatStatus
                                        success:(void(^)())success
                                        failure:(TIASmartHomeServiceFailure)failure;

#pragma mark - Room methods

- (NSString *)postRoomDataWithColor:(NSString *)color
                            success:(void(^)())success
                            failure:(TIASmartHomeServiceFailure)failure;

#pragma mark - Washing MAchine methods

- (NSString *)postWashingMachineDataWithTemperature:(NSString *)temperature
                                                RPM:(NSString *)rpm
                                               time:(NSString *)time
                                            success:(void(^)())success
                                            failure:(TIASmartHomeServiceFailure)failure;

@end

@interface TIASmartHomeService (SubclassRequirements)

- (NSString *)submitRequestWithURL:(NSURL *)URL
                            method:(NSString *)httpMethod
                              body:(NSDictionary *)bodyDict
                    expectedStatus:(NSInteger)expectedStatus
                           success:(TIASmartHomeServiceSuccess)success
                           failure:(TIASmartHomeServiceFailure)failure;

- (void)cancelRequestWithIdentifier:(NSString *)identifier;

- (void)resendRequestsPending;

@end
