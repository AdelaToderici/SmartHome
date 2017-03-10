//
//  NSArray+Enumerator.m
//  SmartHome
//
//  Created by Adela Toderici on 3/10/17.
//  Copyright © 2017 Adela Toderici. All rights reserved.
//

#import "NSArray+Enumerator.h"

@implementation NSArray (Enumerator)

- (NSArray *)mappedArrayWithBlock:(id (^)(id))block {
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id obj in self) {
        [mutableArray addObject:block(obj)];
    }
    
    return mutableArray;
}

@end
