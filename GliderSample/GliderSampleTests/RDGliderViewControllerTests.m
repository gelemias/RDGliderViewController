//
//  RDGliderViewController.m
//  GliderSample
//
//  Created by Guillermo Delgado on 14/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RDGliderViewController.h"

@interface RDGliderViewController ()

@property (nonatomic) RDScrollView *scrollView;

@end

@interface RDGliderViewControllerTests : XCTestCase

@property (nonatomic) RDGliderViewController *gliderVC;

@end

@implementation RDGliderViewControllerTests

- (void)setUp {
    [super setUp];

    self.gliderVC = [[RDGliderViewController alloc] initOn:[UIViewController new]
                                               WithContent:[UIViewController new]
                                                      type:RDScrollViewOrientationRightToLeft
                                                AndOffsets:@[@1]];
    
    XCTAssertNotNil(self.gliderVC);
}

- (void)tearDown {
    self.gliderVC = nil;
    [super tearDown];
}

- (void)testOffsets {
    XCTAssertTrue([[self.gliderVC offsets] isEqualToArray:@[@1]]);
    XCTAssertThrows([self.gliderVC setOffsets:@[]]);
    
    [self.gliderVC setOffsets:@[@0, @0.5, @1]];
    
    self.gliderVC.scrollView = nil;
    XCTAssertThrows([self.gliderVC setOffsets:@[@0]]);
 
}

- (void)testOrientationType {
    XCTAssertTrue([self.gliderVC orientationType] == RDScrollViewOrientationRightToLeft);
    
    self.gliderVC.scrollView = nil;
    XCTAssertTrue([self.gliderVC orientationType] == RDScrollViewOrientationUnknown);
}

@end
