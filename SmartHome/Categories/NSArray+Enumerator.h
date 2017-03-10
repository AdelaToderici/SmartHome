//
//  NSArray+Enumerator.h
//  SmartHome
//
//  Created by Adela Toderici on 3/10/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Enumerator)

- (NSArray *)mappedArrayWithBlock:(id(^)(id obj))block;

@end
