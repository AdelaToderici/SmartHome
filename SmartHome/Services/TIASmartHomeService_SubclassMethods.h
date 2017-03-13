//
//  TIASmartHomeService_SubclassMethods.h
//  SmartHome
//
//  Created by Adela Toderici on 3/11/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIASmartHomeService.h"

/**
 * A way for subclasses to "see" into the parent TIASmartHomeService class
 * without exposing all of the properties to the world.
 */

@interface TIASmartHomeService (SubclassMethods)

@property (nonatomic, strong) NSURL *tempServerRoot;
@property (nonatomic, strong, readonly) NSMutableDictionary *requests;

- (NSMutableURLRequest *)requestForURL:(NSURL *)URL
                                method:(NSString *)httpMethod
                              bodyDict:(NSDictionary *)bodyDict;

@end
