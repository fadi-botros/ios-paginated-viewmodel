//
//  PaginatedMVVMTests.m
//  PaginatedMVVMTests
//
//  Created by mac on 8/4/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "PaginatedInteractor.h"
#import "SimulationRepository.h"

@interface PaginatedMVVMTests : XCTestCase

@property (strong, nonnull) PaginatedInteractor *interactor;

@end

@implementation PaginatedMVVMTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testNextPage {
    self.interactor = [[PaginatedInteractor alloc] initWithRepository:SimulationRepository.shared andList:[[EntityList alloc] init]];
    XCTAssertEqual(self.interactor.maximumPage, 0);
    [self.interactor nextPage];
    [NSThread sleepForTimeInterval:10];
    XCTAssertEqual(self.interactor.maximumPage, 1);
    XCTAssertEqual(self.interactor.list.allData.count, self.interactor.repository.pageSize);
}

@end
