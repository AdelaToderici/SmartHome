//
//  TIASerializable.h
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TIASerializable <NSObject>

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
