//
//  EntityList.m
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "EntityList.h"

@implementation EntityList

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setAllData:[NSMutableArray arrayWithCapacity:16]];
    }
    return self;
}

@end
