//
//  PaginatedInteractor.h
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "RepositoryToListInteractor.h"
#import "BaseRepository.h"
#import "EntityList.h"

/**
 The interactor that reads pages from the repository and populate the list.
 Inserts new items according to if we wanted the previous or next page.
 No more than 3 pages are on memory simultaneously.
 */
@interface PaginatedInteractor<T: NSObject *, U: BaseRepository *, V: EntityList *> : RepositoryToListInteractor<T, U, V>

- (instancetype _Nullable)initWithRepository:(U _Nonnull)repository andList:(V _Nonnull)list;

@property (readonly) NSUInteger currentPage;
@property (readonly) NSUInteger minimumPage;
@property (readonly) NSUInteger maximumPage;

-(void)previousPage;
-(void)nextPage;

@end
