//
//  TIARoomModel.h
//  SmartHome
//
//  Created by Adela Toderici on 3/9/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIASerializable.h"

extern NSString *const kRoomModelPublicID;
extern NSString *const kRoomModelColor;

@interface TIARoomModel : NSObject <TIASerializable>

@property (nonatomic, strong) NSString *pulicID;
@property (nonatomic, assign) NSString *color;

- (instancetype)initWithPublicID:(NSString *)publicID andColor:(NSString *)color;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
