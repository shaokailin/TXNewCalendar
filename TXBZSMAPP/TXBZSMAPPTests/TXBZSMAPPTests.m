//
//  TXBZSMAPPTests.m
//  TXBZSMAPPTests
//
//  Created by shaokai lin on 2018/4/25.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TXBZSMHappyManager.h"
@interface TXBZSMAPPTests : XCTestCase

@end

@implementation TXBZSMAPPTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [[TXBZSMHappyManager sharedInstance]getGossipMessage:[NSDate date] isBoy:NO];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
