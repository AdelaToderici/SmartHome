//
//  TIAUserModel.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIAUserModel.h"

NSString *const kUserPulicIDkey;
NSString *const kUserNameKey;

@implementation TIAUserModel

- (instancetype)initWithPublicID:(NSString *)publicID andName:(NSString *)name {
    
    if ((self = [super init])) {
        
        self.pulicID = publicID;
        self.name    = name;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    return [self initWithPublicID:dictionary[kUserPulicIDkey]
                          andName:dictionary[kUserNameKey]];
}

- (NSDictionary *)dictionaryRepresentation {
    
    return @{ kUserPulicIDkey : self.pulicID,
              kUserNameKey    : self.name };
}

@end
