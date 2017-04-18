//
//  GVScrollView.h
//  GlideView
//
//  Created by GuillermoD on 8/3/16.
//  Copyright © 2017. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GVScrollViewOrientationLeftToRight = 0,
    GVScrollViewOrientationBottomToTop,
    GVScrollViewOrientationRightToLeft,
    GVScrollViewOrientationTopToBottom
    
}GVScrollViewOrientationType;

@interface GVScrollView : UIScrollView

/**
 DraggableContainer
 */
@property (nonatomic) UIView *content;

/**
 Orientation for draggable container.
 Default value : GVScrollViewOrientationLeftToRight
 */
@property (nonatomic) GVScrollViewOrientationType orientationType;

/**
 Expandable offset in % of content view. from 0 to 1.
 */
@property (nonatomic) NSArray<NSNumber *> *offsets;

/**
 Determines whether the element is Open or not.
 */
@property (nonatomic, readonly) BOOL isOpen;

/**
 Returns the position of open Offsets.
 */
@property (nonatomic, readonly) NSUInteger offsetIndex;

/**
 Margin of elastic animation default is 20px.
 */
@property (nonatomic) CGFloat margin;

/**
 Consider subviews of the content as part of the content, used when dragging.
 Default Value is False
 */
@property (nonatomic) BOOL selectContentSubViews;

/**
 Duration of animation for changing offset, default vaule is 0.3
 */
@property (nonatomic) CGFloat duration;

/**
 Delay of animation for changing offset, default vaule is 0.0
 */
@property (nonatomic) CGFloat delay;

/**
 Damping of animation for changing offset, default vaule is 0.7
 */
@property (nonatomic) CGFloat damping;

/**
 Damping of animation for changing offset, default vaule is 0.6
 */
@property (nonatomic) CGFloat velocity;

/**
 Call this method to force recalculation of contentSize in ScrollView, i.e. when content changes.
 */
- (void)recalculateContentSize;

// Methods to Increase or decrease offset of content within GVScrollView.

- (void)changeOffsetTo:(NSUInteger)offsetIndex animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
- (void)expandWithCompletion:(void (^)(BOOL finished))completion;
- (void)collapseWithCompletion:(void (^)(BOOL finished))completion;
- (void)closeWithCompletion:(void (^)(BOOL finished))completion;

// Unavailable constructors.

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
