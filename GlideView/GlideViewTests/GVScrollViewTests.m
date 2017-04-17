//
//  GlideViewTests.m
//  GlideViewTests
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVScrollView.h"

@interface GVScrollViewTests : XCTestCase

@property (nonatomic) GVScrollView *gvScrollView;

@end

@implementation GVScrollViewTests

- (void)setUp {
    [super setUp];
    self.gvScrollView = [[GVScrollView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
}

- (void)tearDown {
    self.gvScrollView = nil;
    [super tearDown];
}

- (void)testInit {
    XCTAssertTrue(self.gvScrollView.margin == 20);
    XCTAssertTrue(self.gvScrollView.orientationType == GVScrollViewOrientationRightToLeft);
    XCTAssertFalse(self.gvScrollView.showsVerticalScrollIndicator);
    XCTAssertFalse(self.gvScrollView.showsHorizontalScrollIndicator);
    XCTAssertFalse(self.gvScrollView.bounces);
    XCTAssertTrue(self.gvScrollView.directionalLockEnabled);
    XCTAssertFalse(self.gvScrollView.pagingEnabled);
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.gvScrollView.contentInset, UIEdgeInsetsZero));
    XCTAssertTrue(self.gvScrollView.decelerationRate == UIScrollViewDecelerationRateFast);
}



@end
