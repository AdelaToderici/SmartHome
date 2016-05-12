//
//  APIManager.h
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionManager.h"
#import "SensorRequestModel.h"
#import "SensorResponseModel.h"

@interface APIManager : SessionManager

- (NSURLSessionDataTask *)getArticlesWithRequestModel:(SensorRequestModel *)requestModel
                                              success:(void (^)(SensorResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure;

@end
