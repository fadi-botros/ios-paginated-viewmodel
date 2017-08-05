//
//  SimulationRepository.m
//  PaginatedMVVM
//
//  Created by mac on 8/5/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "SimulationRepository.h"

@implementation SimulationRepository

@synthesize loading;

+(instancetype)shared {
    static SimulationRepository * _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SimulationRepository alloc] initWithPageSize:10];
    });
    return _sharedInstance;
}

-(void)fetchDataByPage:(NSUInteger)page thenCall:(void (^)(NSMutableArray *))block {
    if (self.loading) return;
    loading = true;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        NSMutableArray<NSString *>*strings = [NSMutableArray arrayWithCapacity:self.pageSize];
        for(int i=0;i<self.pageSize;i++) {
            [strings addObject: [NSString stringWithFormat:@"Number %i in page %lu",
                                 i,
                                 (unsigned long)page]];
        }
        block(strings);
        loading = false;
    });
}

@end
