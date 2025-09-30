//
//  CheckBoxUITests.m
//  CheckBoxUITests
//
//  Created by Boris Emorine on 9/2/16.
//  Copyright © 2016 Boris Emorine. All rights reserved.
//

#import <XCTest/XCTest.h>
@import BEMCheckBox;

@interface CheckBoxUITests : XCTestCase

@end

@implementation CheckBoxUITests

- (void)setUp {
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testOn {
    XCUIApplication *app = [[XCUIApplication alloc] init];

    // Find checkbox by accessibility label with a more reliable query
    XCUIElement *checkbox = [app.buttons matchingIdentifier:@"Checkbox"].firstMatch;

    // Wait for the element to be hittable
    XCTAssertTrue([checkbox waitForExistenceWithTimeout:5]);
    XCTAssertTrue(checkbox.isHittable, @"Checkbox should be hittable");

    // Test tapping on checkbox
    [checkbox tap];
    XCTAssertTrue(checkbox.isHittable, @"Checkbox should remain hittable after first tap");

    // Test tapping again
    [checkbox tap];
    XCTAssertTrue(checkbox.isHittable, @"Checkbox should remain hittable after second tap");
}

@end
