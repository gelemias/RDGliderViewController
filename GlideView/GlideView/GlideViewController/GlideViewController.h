//
//  GlideViewController.h
//  GlideView
//
//  Created by GuillermoD on 8/4/16.
//  Copyright © 2017. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVScrollView.h"

@class GlideViewController;

@protocol GlideViewControllerDelegate <NSObject>

@optional

/**
 Delegate method to notify invoke object when offset has changed
 */
- (void)glideViewController:(GlideViewController *)glideViewController hasChangedOffsetOfContent:(CGPoint)offset;

/**
 Delegate method to notify invoke object when glideView will increase offset by one
 */
- (void)glideViewControllerWillExpand:(GlideViewController *)glideViewController;

/**
 Delegate method to notify invoke object when glideView will decrease offset by one
 */
- (void)glideViewControllerWillCollapse:(GlideViewController *)glideViewController;

/**
 Delegate method to notify invoke object when glideView did increase offset by one
 */
- (void)glideViewControllerDidExpand:(GlideViewController *)glideViewController;

/**
 Delegate method to notify invoke object when glideView did decrease offset by one
 */
- (void)glideViewControllerDidCollapse:(GlideViewController *)glideViewController;

@end

@interface GlideViewController : UIViewController

@property (nonatomic, weak) id<GlideViewControllerDelegate> delegate;

@property (nonatomic) UIViewController *contentViewController;

/**
 Margin of elastic animation default is 20px;
 */
@property (nonatomic) CGFloat marginOffset;

/**
 Sorted list of offsets in % of contentVC view. from 0 to 1
 */
@property (nonatomic) NSArray<NSNumber *> *offsets;

/**
 Orientation type of the glide view
 */
@property (nonatomic, readonly) GVScrollViewOrientationType orientationType;

/**
 Current offset of the glide view
 */
@property (nonatomic, readonly) NSUInteger currentOffsetIndex;

/**
 Returns a bool for determining if the glide view isn't closed.
 */
@property (nonatomic, readonly) BOOL isOpen;

/**
 Bool meant for enabling the posibility to close the glide view dragging, Default value is NO;
 */
@property (nonatomic) BOOL disableDraggingToClose;

/**
 This method gives a shake to the glive view, is meant to grap users atention.
 */
- (void)shake;

/**
 Increase the position of the glive view by one in the list of offsets
 */
- (void)expand;

/**
 Decrease the position of the glive view by one in the list of offsets
 */
- (void)collapse;

/**
 Change offset of view.
 */
- (void)changeOffsetTo:(NSUInteger)offsetIndex;

/**
 This method moves the View directly to the first offset which is the default position.
 */
- (void)close;

/**
 Initializator of the object, it requires the parent view controller to build its components
 */
- (instancetype)initOn:(UIViewController *)parent
           WithContent:(UIViewController *)content
              type:(GVScrollViewOrientationType)type
            AndOffsets:(NSArray<NSNumber *> *)offsets;

#pragma mark - Unavailable methods

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
