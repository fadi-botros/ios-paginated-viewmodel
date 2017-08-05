//
//  SimulationRepository.h
//  PaginatedMVVM
//
//  Created by mac on 8/5/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "BaseRepository.h"

@interface SimulationRepository : BaseRepository<NSString *>

-(void)fetchDataByPage:(NSUInteger)page thenCall:(void (^)(NSMutableArray *))block;

+(instancetype) shared;

@end
