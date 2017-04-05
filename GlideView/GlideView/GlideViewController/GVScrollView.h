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
 Orientation for draggable container
 Default value : GVScrollViewOrientationLeftToRight
 */
@property (nonatomic) GVScrollViewOrientationType orientationType;

/**
 Default expandable offset
 Default value : container.frame.width - marginOffset 
 */
@property (nonatomic) NSArray<NSNumber *> *offsets;

/**
 Determines whether the element is Open or not
 */
@property (nonatomic, readonly) BOOL isOpen;

/**
 Returns the position of open Offsets
 */
@property (nonatomic, readonly) int offsetIndex;

/**
 Margin of elastic animation default is 20px
 */
@property (nonatomic) CGFloat margin;

/**
 Consider subviews of the content as part of the content, used when dragging
 Default Value is False
 */
@property (nonatomic) BOOL selectContentSubViews;

extern NSString *const offsetWillChangeNotification;
extern NSString *const offsetDidChangeNotification;

- (void)changeOffsetTo:(int)offsetIndex completion:(void (^)(BOOL finished))completion;
- (void)expandWithCompletion:(void (^)(BOOL finished))completion;
- (void)collapseWithCompletion:(void (^)(BOOL finished))completion;
- (void)closeWithCompletion:(void (^)(BOOL finished))completion;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
