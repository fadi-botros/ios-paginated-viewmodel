//
//  PaginatedMVVMTests.m
//  PaginatedMVVMTests
//
//  Created by mac on 8/5/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PaginatedInteractor.h"
#import "SimulationRepository.h"

@interface PaginatedMVVMTests : XCTestCase

@property (nonnull) PaginatedInteractor *interactor;
@property (nonnull) XCTestExpectation *testExpectation;

@end

@implementation PaginatedMVVMTests

static void *pContext = &pContext;

- (void)setUp {
    [super setUp];
    self.interactor = [[PaginatedInteractor alloc] initWithRepository:[[SimulationRepository alloc] initWithPageSize:10] andList:[[EntityList alloc] init]];
    self.testExpectation = [[XCTestExpectation alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPagination {
    XCTAssertEqual([self.interactor maximumPage], 0);
    NSLog(@"%@", self.interactor);
    [self.interactor.list addObserver:self forKeyPath:@"allData" options:0 context:pContext];
    [self.interactor nextPage];
    NSLog(@"%@", self.interactor);
    [self waitForExpectations:@[self.testExpectation] timeout:8];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == pContext) {
        // This code is to be executed just once, no use of dispatching new task for EVERY addition
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            // Wait another second to make a chance for the background thread to complete its action
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                XCTAssertEqual(self.interactor.list.allData.count, self.interactor.repository.pageSize);
                [[self testExpectation] fulfill];
            });
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
