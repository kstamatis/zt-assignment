//
//  testTests.m
//  testTests
//
//  Created by Kostas Stamatis on 06/12/2016.
//  Copyright © 2016 ZT. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Utils.h"

@interface testTests : XCTestCase

@end

@implementation testTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFormattedValue {
    NSDictionary *testData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"test_data" ofType:@"plist"]];
    
    for (NSDictionary *testValue in testData[@"test-data"]) {
        [Utils formatValueForNumber:testValue[@"value"] pipMultiplier:testValue[@"multiplier"] onCompletion:^(NSString *part1, NSString *part2, NSString *part3) {
            XCTAssertEqualObjects(part1, testValue[@"part1"], @"Error formatting part1 for value: %@", testValue[@"value"]);
            XCTAssertEqualObjects(part2, testValue[@"part2"], @"Error formatting part2 for value: %@", testValue[@"value"]);
            XCTAssertEqualObjects(part3, testValue[@"part3"], @"Error formatting part3 for value: %@", testValue[@"value"]);
        }];
    }
}

@end
