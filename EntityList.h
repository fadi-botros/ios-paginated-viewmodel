//
//  EntityList.h
//  PaginatedMVVM
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntityList<T: NSObject *> : NSObject

@property (strong, nonatomic, nonnull) NSMutableArray<T> *allData;

@end
