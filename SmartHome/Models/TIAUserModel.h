//
//  TIAUserModel.h
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIASerializable.h"

extern NSString *const kUserPulicIDkey;
extern NSString *const kUserNameKey;

@interface TIAUserModel : NSObject <TIASerializable>

@property (nonatomic, strong) NSString *pulicID;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithPublicID:(NSString *)publicID andName:(NSString *)name;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
