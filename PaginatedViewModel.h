//
//  PaginatedViewModel.h
//  PaginatedMVVM
//
//  Created by mac on 8/5/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "BaseListViewModel.h"
#import "PaginatedInteractor.h"

@interface PaginatedViewModel : BaseListViewModel<EntityList *>

@property (readonly) PaginatedInteractor *interactor;

-(instancetype)initWithPaginatedInteractor: (PaginatedInteractor *)interactor;

-(NSObject *)objectByIndex:(NSUInteger) index;

-(NSUInteger)count;

@end
