//
//  RepositoryToListInteractor.m
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "RepositoryToListInteractor.h"

@implementation RepositoryToListInteractor

- (instancetype)initWithRepository:(BaseRepository *)repository andList:(EntityList *)list
{
    self = [super init];
    if (self) {
        _repository = repository;
        _list = list;
    }
    return self;
}

@end
