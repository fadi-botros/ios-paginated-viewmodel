//
//  PaginatedInteractor.m
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "PaginatedInteractor.h"

@implementation PaginatedInteractor

-(instancetype)initWithRepository:(BaseRepository *)repository andList:(EntityList *)list {
    self = [super initWithRepository:repository andList:list];
    if (self) {
        _currentPage = 0;
        _minimumPage = 0;
        _maximumPage = 0;
    }
    return self;
}

-(void)previousPage {
    if (_minimumPage <= 1) return;
    [self.repository fetchDataByPage:(_minimumPage - 1) thenCall:^(NSMutableArray *result) {
        NSIndexSet *indices = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [result count])];
        NSMutableArray *dataArray = [self.list mutableArrayValueForKey:@"allData"];
        [dataArray insertObjects:result atIndexes:indices];
        if (self.list.allData.count > (self.repository.pageSize * 3)) {
            // We are returning to the previous page, so if overflow remove the LAST entries
            NSIndexSet *indices = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.repository.pageSize * 3, (self.list.allData.count - self.repository.pageSize * 3))];
            [dataArray removeObjectsAtIndexes:indices];
            _maximumPage = _minimumPage + 2;
        }
        _minimumPage--;
    }];
    
}

-(void)nextPage {
    [self.repository fetchDataByPage:(_maximumPage + 1) thenCall:^(NSMutableArray *result) {
        NSMutableArray *dataArray = [self.list mutableArrayValueForKey:@"allData"];
        [dataArray addObjectsFromArray:result];
        if (self.list.allData.count > (self.repository.pageSize * 3)) {
            // We are returning to the next page, so if overflow remove the FIRST entries
            NSIndexSet *indices = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, (self.list.allData.count - self.repository.pageSize * 3))];
            [dataArray removeObjectsAtIndexes:indices];
            _minimumPage = _maximumPage - 1;
        }
        _maximumPage++;
    }];
}

@end
