//
//  RDGliderViewController.h
//  GliderSample
//
//  Created by GuillermoD on 8/4/16.
//  Copyright © 2017. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDScrollView.h"
#import "RDGliderContentViewController.h"

@class RDGliderViewController;

@protocol RDGliderViewControllerDelegate <NSObject>

@optional

/**
 Delegate method to notify invoke object when offset has changed
 */
- (void)glideViewController:(nonnull RDGliderViewController *)glideViewController hasChangedOffsetOfContent:(CGPoint)offset;

/**
 Delegate method to notify invoke object when glideView will increase offset by one
 */
- (void)glideViewControllerWillExpand:(nonnull RDGliderViewController *)glideViewController;

/**
 Delegate method to notify invoke object when glideView will decrease offset by one
 */
- (void)glideViewControllerWillCollapse:(nonnull RDGliderViewController *)glideViewController;

/**
 Delegate method to notify invoke object when glideView did increase offset by one
 */
- (void)glideViewControllerDidExpand:(nonnull RDGliderViewController *)glideViewController;

/**
 Delegate method to notify invoke object when glideView did decrease offset by one
 */
- (void)glideViewControllerDidCollapse:(nonnull RDGliderViewController *)glideViewController;

@end


@interface RDGliderViewController : UIViewController

@property (nonatomic, weak, nullable) id <RDGliderViewControllerDelegate> delegate;

@property (nonatomic, readonly, nonnull) UIViewController *contentViewController;

/**
 Margin of elastic animation default is 20px;
 */
@property (nonatomic) CGFloat marginOffset;

/**
 Sorted list of offsets in % of contentVC view. from 0 to 1
 */
@property (nonatomic, copy, nonnull) NSArray<NSNumber *> *offsets;

/**
 Orientation type of the glide view
 */
@property (nonatomic, readonly) RDScrollViewOrientationType orientationType;

/**
 Current offset of the glide view
 */
@property (nonatomic, readonly) NSUInteger currentOffsetIndex;

/**
 Returns a bool for determining if the glide view isn't closed, is different than offset % 0.
 */
@property (nonatomic, readonly) BOOL isOpen;

/**
 Bool meant for enabling the posibility to close the glide view dragging, Default value is NO;
 */
@property (nonatomic) BOOL disableDraggingToClose;

/**
 Change contentViewController type and offsets after the VC has been initialized.
 * @param contentViewController external ViewController placed as a content of the GlideView
 * @param type of GlideView Left to Right, Right to Left, Bottom To Top and Top to Bottom.
 * @param offsets Array of offsets in % (0 to 1) dependent of Content size if not expecified UIScreen  */
- (void)setContentViewController:(nonnull RDGliderContentViewController *)contentViewController
                            type:(RDScrollViewOrientationType)type
                         offsets:(nonnull NSArray<NSNumber *> *)offsets;

/**
 This method gives a shake to the Gliver view, is meant to grap users atention.
 */
- (void)shake;

/**
 Increase the position of the Gliver view by one in the list of offsets
 */
- (void)expand;

/**
 Decrease the position of the Gliver view by one in the list of offsets
 */
- (void)collapse;

/**
 Change offset of view.
 * @param offsetIndex setNew Offset of GlideView, parameter needs to be within offsets Array count list.
 * @param animated animates the offset change
 */
- (void)changeOffsetTo:(NSUInteger)offsetIndex animated:(BOOL)animated;

/**
 This method moves the View directly to the first offset which is the default position.
 */
- (void)close;

/**
 Initializator of the object, it requires the parent view controller to build its components
 * @param parent Parent Class of this instance
 * @param content external ViewController placed as a content of the GlideView
 * @param type of GlideView Left to Right, Right to Left, Bottom To Top and Top to Bottom.
 * @param offsets Array of offsets in % (0 to 1) dependent of Content size if not expecified UIScreen bounds.
 * @return A newly created RDGliderViewController instance
 */
- (nullable instancetype)initOn:(nonnull UIViewController *)parent
                     WithContent:(nonnull RDGliderContentViewController *)content
                            type:(RDScrollViewOrientationType)type
                      AndOffsets:(nonnull NSArray<NSNumber *> *)offsets;

#pragma mark - Unavailable methods

- (nullable instancetype)init NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *_Nullable)aDecoder NS_UNAVAILABLE;
- (nonnull instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
