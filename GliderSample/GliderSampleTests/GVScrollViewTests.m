//
//  GlideViewTests.m
//  GlideViewTests
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GVScrollView.h"

@interface GVScrollView()

@property (nonatomic) NSUInteger offsetIndex;

@end

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

- (void)testExpandOffset {
    XCTestExpectation *ex0 = [self expectationWithDescription:@"Success0"];
    
    [self.gvScrollView expandWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex0 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 0);
        }
    }];
    
    [self.gvScrollView setOffsets:@[@0,@.5,@1]];

    XCTAssertTrue([[self.gvScrollView offsets] count] == 3);
    XCTAssertTrue([self.gvScrollView offsetIndex] == 0);
    
    XCTestExpectation *ex1 = [self expectationWithDescription:@"Success1"];
    
    [self.gvScrollView expandWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex1 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 1);
        }
    }];
    
    [self waitForExpectations:@[ex0, ex1] timeout:2];
    
    XCTAssertTrue([self.gvScrollView offsetIndex] == 1);
    
    XCTestExpectation *ex2 = [self expectationWithDescription:@"Success2"];
    
    [self.gvScrollView expandWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex2 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 2);
        }
    }];
    
    [self waitForExpectations:@[ex2] timeout:2];
    
    XCTAssertTrue([self.gvScrollView offsetIndex] == 2);
    
    XCTestExpectation *ex3 = [self expectationWithDescription:@"Success3"];
    
    [self.gvScrollView expandWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex3 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 2);
        }
    }];
    
    [self waitForExpectations:@[ex3] timeout:2];
}

- (void)testCollapseOffset {
    [self.gvScrollView setOffsets:@[@0,@.5,@1]];
    [self.gvScrollView setOffsetIndex:[[self.gvScrollView offsets] count] - 1];
    
    XCTAssertTrue([[self.gvScrollView offsets] count] == 3);
    XCTAssertTrue([self.gvScrollView offsetIndex] == 2);
    
    XCTestExpectation *ex1 = [self expectationWithDescription:@"Success1"];
    
    [self.gvScrollView collapseWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex1 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 1);
        }
    }];
    
    [self waitForExpectations:@[ex1] timeout:2];
    
    XCTestExpectation *ex2 = [self expectationWithDescription:@"Success2"];
 
    [self.gvScrollView collapseWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex2 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 0);
        }
    }];
    
    [self waitForExpectations:@[ex2] timeout:2];
    XCTestExpectation *ex3 = [self expectationWithDescription:@"Success3"];
    
    [self.gvScrollView collapseWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex3 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 0);
        }
    }];
    
    [self waitForExpectations:@[ex3] timeout:2];
}

- (void)testCloseOffset {
    XCTestExpectation *ex0 = [self expectationWithDescription:@"Success0"];
    
    [self.gvScrollView closeWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex0 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 0);
        }
    }];
    
    [self.gvScrollView setOffsets:@[@0,@.5,@1]];
    
    XCTAssertTrue([[self.gvScrollView offsets] count] == 3);
    XCTAssertTrue([self.gvScrollView offsetIndex] == 0);
    
    XCTestExpectation *ex1 = [self expectationWithDescription:@"Success1"];
    
    [self.gvScrollView closeWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex1 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 0);
        }
    }];
    
    [self waitForExpectations:@[ex0, ex1] timeout:2];
    
    [self.gvScrollView setOffsetIndex:[[self.gvScrollView offsets] count] - 1];
    
    XCTAssertTrue([[self.gvScrollView offsets] count] == 3);
    XCTAssertTrue([self.gvScrollView offsetIndex] == 2);
    
    XCTestExpectation *ex2 = [self expectationWithDescription:@"Success2"];
    
    [self.gvScrollView closeWithCompletion:^(BOOL finished) {
        if (finished) {
            [ex2 fulfill];
            XCTAssertTrue([self.gvScrollView offsetIndex] == 0);
        }
    }];
    
    [self waitForExpectations:@[ex2] timeout:2];
}

- (void)testOffsets {
    NSArray *ar = @[@0, @3, @0.123];
    XCTAssertThrows([self.gvScrollView setOffsets:ar]);
    
    XCTAssertTrue(self.gvScrollView.orientationType == GVScrollViewOrientationRightToLeft);
    
    ar = @[@1, @0.6, @0.3, @0];
    [self.gvScrollView setOffsets:ar];
    
    XCTAssertTrue([[self.gvScrollView offsets] isEqualToArray:
                   [ar sortedArrayUsingSelector:@selector(compare:)]]);
    
    [self.gvScrollView setOrientationType:GVScrollViewOrientationBottomToTop];
    XCTAssertTrue(self.gvScrollView.orientationType == GVScrollViewOrientationBottomToTop);
    
    ar = @[@1, @0.4, @0.3, @0.4];
    [self.gvScrollView setOffsets:ar];
    
    NSArray<NSNumber *> *aux = @[@0.3, @0.4, @1];
    XCTAssertTrue([[self.gvScrollView offsets] isEqualToArray:aux]);
    
    [self.gvScrollView setOrientationType:GVScrollViewOrientationLeftToRight];
    XCTAssertTrue(self.gvScrollView.orientationType == GVScrollViewOrientationLeftToRight);
    
    [self.gvScrollView setOffsets:ar];
    
    aux = @[@0.7, @0.6, @0];

    for (int i = 0 ; i < [self.gvScrollView.offsets count] - 1 ; i++) {
        XCTAssertTrue(self.gvScrollView.offsets[i].floatValue == aux[i].floatValue);
    }
    
    [self.gvScrollView setOrientationType:GVScrollViewOrientationTopToBottom];
    XCTAssertTrue(self.gvScrollView.orientationType == GVScrollViewOrientationTopToBottom);
    
    ar = @[@0, @0.5, @1];
    [self.gvScrollView setOffsets:ar];
    
    aux = @[@1, @0.5, @0];
    XCTAssertTrue([[self.gvScrollView offsets] isEqualToArray:aux]);
}

@end
