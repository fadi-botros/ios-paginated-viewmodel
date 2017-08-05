//
//  PaginatedViewModel.m
//  PaginatedMVVM
//
//  Created by mac on 8/5/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "PaginatedViewModel.h"

@interface PaginatedViewModel ()

@property (readonly) EntityList *entitiesModel;

@end

@implementation PaginatedViewModel

-(instancetype)initWithPaginatedInteractor: (PaginatedInteractor *)interactor;
{
    self = [super initWithEntityList:interactor.list];
    if (self) {
        _interactor = interactor;
    }
    return self;
}

-(NSObject *)objectByIndex:(NSUInteger)index {
    if (index == 0) {
        [self.interactor previousPage];
    }
    if (index == self.localObjects.count - 1) {
        [self.interactor nextPage];
    }
    return [self.localObjects objectAtIndex:index];
}

-(NSUInteger)count {
    // Special case: If count = 0, this means you must try to load a page
    if (self.localObjects.count == 0) { [self.interactor nextPage]; }
    return self.localObjects.count;
}

@end
