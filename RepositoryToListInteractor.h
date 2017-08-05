//
//  RepositoryToListInteractor.h
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRepository.h"
#import "EntityList.h"

/**
 An object to read from repository and put into the list.
 This is an abstract class
 */
@interface RepositoryToListInteractor<T: NSObject *, U: BaseRepository *, V: EntityList *> : NSObject

- (instancetype _Nullable)initWithRepository:(U _Nonnull)repository andList:(V _Nonnull)list;

@property (strong, nonnull, readonly) U repository;
@property (strong, nonnull, readonly) V list;

@end
