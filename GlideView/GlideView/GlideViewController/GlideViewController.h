//
//  GlideViewController.h
//  GlideView
//
//  Created by GuillermoD on 8/4/16.
//  Copyright © 2017. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVScrollView.h"
#import "GlideContentViewController.h"

@class GlideViewController;

@protocol GlideViewControllerDelegate <NSObject>

@optional

- (void)glideViewController:(GlideViewController *)glideViewController hasChangedOffsetOfContent:(CGPoint)offset;

- (void)glideViewControllerWillExpand:(GlideViewController *)glideViewController;
- (void)glideViewControllerWillCollapse:(GlideViewController *)glideViewController;

- (void)glideViewControllerDidExpand:(GlideViewController *)glideViewController;
- (void)glideViewControllerDidCollapse:(GlideViewController *)glideViewController;

@end

@interface GlideViewController : UIViewController

@property (nonatomic) GVScrollView *scrollView;
@property (nonatomic) CGFloat margin; // Default 20px;

// offsets have to be increased for example: #1) 0px #2) 100px #3)d 400px
@property (nonatomic) NSArray<NSNumber *> *offsets;

@property (nonatomic, readonly) GVScrollViewOrientationType orientationType;
@property (nonatomic, readonly) int currentOffsetIndex;
@property (nonatomic, readonly) BOOL isMoving;
@property (nonatomic, readonly) BOOL isOpen;
@property (nonatomic) BOOL shadow; // Default: True
@property (nonatomic) BOOL canCloseDragging; // Default: True

@property (nonatomic, readonly) NSString *glideDidScrollNotificationName;

@property (nonatomic, weak) id<GlideViewControllerDelegate> delegate;

- (instancetype)initWithScrollView:(GVScrollView *)scrollView;

- (void)setContentViewController:(GlideContentViewController *)contentViewController
                            type:(GVScrollViewOrientationType)type
                         offsets:(NSArray<NSNumber *> *)offsets;
- (void)removeContent;

- (void)shake;

- (void)expand;

- (void)collapse;

- (void)close;

@end
