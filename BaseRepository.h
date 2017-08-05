//
//  BaseRepository.h
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRepository<T : NSObject *> : NSObject

- (instancetype)initWithPageSize:(NSUInteger)pageSize;

@property (readonly) NSUInteger pageSize;

/**
 Is the repository loading more data?
 */
@property (readonly) BOOL loading;

/**
 Fetches the data from the datasource, whatever it is.
 Calls a block when finish fetching, it should do its work in background thread.
 To be overridden, this method just throws an exception.

 @param page Page number to fetch
 @param block The block to be called when fetching ends
 */
-(void)fetchDataByPage:(NSUInteger) page thenCall:(void(^)(NSMutableArray<T> *))block;

@end
