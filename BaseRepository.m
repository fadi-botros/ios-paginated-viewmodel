//
//  BaseRepository.m
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "BaseRepository.h"

@implementation BaseRepository

- (instancetype)initWithPageSize:(NSUInteger)pageSize
{
    self = [super init];
    if (self) {
        _pageSize = pageSize;
    }
    return self;
}

-(void)fetchDataByPage:(NSUInteger)page thenCall:(void(^)(NSMutableArray<NSObject *> *))block {
    [NSException raise:NSInvocationOperationCancelledException format:@"Not supported, please override"];
}

@end
