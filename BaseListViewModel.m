//
//  BaseListViewModel.m
//  PaginatedMVVM
//
//  Created by mac on 8/5/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "BaseListViewModel.h"

@interface BaseListViewModel<T: EntityList *> ()

@property (readonly) T entitiesModel;

@end

@implementation BaseListViewModel

static void *observeModelDataContext = &observeModelDataContext;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _localObjects = [NSMutableArray arrayWithCapacity:16];
        _queue = dispatch_queue_create(nil, dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_BACKGROUND, 0));
    }
    return self;
}

- (instancetype)initWithEntityList:(EntityList *)entityList
{
    self = [self init];
    if (self) {
        _entitiesModel = entityList;
        [_entitiesModel addObserver:self forKeyPath:@"allData" options:0 context:observeModelDataContext];
    }
    return self;
}

- (void)dealloc
{
    // If it is nil, it means it may not be initialized, so this method will get a CRASH
    if (_entitiesModel != nil) {
        [_entitiesModel removeObserver:self forKeyPath:@"allData"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == observeModelDataContext) {
        NSIndexSet *indices = [change objectForKey:NSKeyValueChangeIndexesKey];
        NSValue *kind = [change objectForKey:NSKeyValueChangeKindKey];
        NSMutableArray *localObjects = [self mutableArrayValueForKey:@"localObjects"];
        if ([kind isEqualToValue:@(NSKeyValueChangeInsertion)]) {
            // Get the inserted value before going into the dispatch queue, to reflect the current
            //    changes
            NSArray *addedOnes = [_entitiesModel.allData objectsAtIndexes:indices];
            dispatch_async(_queue, ^(void) {
                [localObjects insertObjects:addedOnes atIndexes:indices];
            });
        } else if ([kind isEqualToValue:@(NSKeyValueChangeRemoval)]) {
            dispatch_async(_queue, ^(void) {
                [localObjects removeObjectsAtIndexes:indices];
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
