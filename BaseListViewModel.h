//
//  BaseListViewModel.h
//  PaginatedMVVM
//
//  Created by mac on 8/5/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityList.h"

/**
 This is a base list ViewModel.
 Just contain an EntityList, and observe on it.
 To be overridden to extend its functionality.
 */
@interface BaseListViewModel<T: EntityList *> : NSObject

@property (readonly) dispatch_queue_t queue;

@property (readonly) NSMutableArray *localObjects;

- (instancetype)initWithEntityList:(EntityList *)entityList;

@end
