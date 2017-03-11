//
//  TIARoomModel.m
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "TIARoomModel.h"

NSString *const kRoomModelPublicID = @"id";
NSString *const kRoomModelColor = @"color";

@implementation TIARoomModel

- (instancetype)initWithPublicID:(NSString *)publicID andColor:(NSString *)color {
    
    if ((self = [super init])) {
        
        self.pulicID = publicID;
        self.color = color;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    return [self initWithPublicID:dictionary[kRoomModelPublicID]
                         andColor:dictionary[kRoomModelColor]];
}

- (NSDictionary *)dictionaryRepresentation {
    
    return @{ kRoomModelPublicID : self.pulicID,
              kRoomModelColor    : self.color };
}

@end
