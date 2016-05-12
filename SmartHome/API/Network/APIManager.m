//
//  APIManager.m
//  HomeControl
//
//  Created by Adela Toderici on 5/2/16.
//  Copyright © 2016 Adela Toderici. All rights reserved.
//

#import "APIManager.h"

static NSString *const kArticlesListPath = @"/svc/search/v2/articlesearch.json";
//#error - API key is missing
static NSString *const kApiKey = @"cf3050e02347b43d623ec877f12cd743:1:74286882";

@implementation APIManager

- (NSURLSessionDataTask *)getArticlesWithRequestModel:(SensorRequestModel *)requestModel
                                              success:(void (^)(SensorResponseModel *responseModel))success
                                              failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [parametersWithKey setObject:kApiKey forKey:@"api-key"];
    
    return [self GET:kArticlesListPath parameters:parametersWithKey
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 
                 NSError *error;
                 SensorResponseModel *list = [MTLJSONAdapter modelOfClass:SensorResponseModel.class
                                                            fromJSONDictionary:responseDictionary error:&error];
                 success(list);
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 
                 failure(error);
                 
             }];
}

@end
