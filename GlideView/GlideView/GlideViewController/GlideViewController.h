//
//  GlideViewController.h
//  GlideView
//
//  Created by GuillermoD on 8/4/16.
//  Copyright © 2017. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVScrollView.h"
#import "GlideContentViewControllerProtocol.h"

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

@property (nonatomic, weak) id<GlideViewControllerDelegate> delegate;

// Margin of elastic animation default is 20px;
@property (nonatomic) CGFloat margin;

// Offsets have to be incremental for example: #1) 0px #2) 100px #3)d 400px
@property (nonatomic) NSArray<NSNumber *> *offsets;

// Orientation type of the glide view
@property (nonatomic, readonly) GVScrollViewOrientationType orientationType;

// Current offset of the glide view
@property (nonatomic, readonly) int currentOffsetIndex;

// Returns a bool for determining if the glide view is moving
@property (nonatomic, readonly) BOOL isMoving;

// Returns a bool for determining if the glide view isn't closed.
@property (nonatomic, readonly) BOOL isOpen;

// Bool meant for enabling the posibility to close the glide view dragging, Default value is True;
@property (nonatomic) BOOL canCloseDragging;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

// Initializator of the object, it requires the parent view controller to build its components
- (instancetype)initOnViewController:(UIViewController *)viewController;

- (void)setContentViewController:(UIViewController<GlideContentViewControllerProtocol> *)contentViewController
                            type:(GVScrollViewOrientationType)type
                         offsets:(NSArray<NSNumber *> *)offsets;

// This method gives a shake to the glive view, is meant to grap users atention.
- (void)shake;

// Increase the position of the glive view by one in the list of offsets
- (void)expand;

// Decrease the position of the glive view by one in the list of offsets
- (void)collapse;

// Goes directly to the first offset which is the default position.
- (void)close;

@end
