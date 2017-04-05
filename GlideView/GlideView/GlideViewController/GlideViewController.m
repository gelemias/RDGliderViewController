//
//  GlideViewController.m
//  GlideView
//
//  Created by GuillermoD on 8/4/16.
//  Copyright © 2017. All rights reserved.
//

#import "GlideViewController.h"

NSString *const GVException = @"GliveViewException";

@interface GlideViewController () <UIScrollViewDelegate>

@property (nonatomic) UIViewController<GlideContentViewControllerProtocol> *contentViewController;
@property (nonatomic) GVScrollView *scrollView;

@property (nonatomic) BOOL isMoving;
@property (nonatomic) BOOL isObservingOffsets;

@end

@implementation GlideViewController

- (instancetype)initOnViewController:(UIViewController *)viewController {
    if (self = [super init]) {

        [viewController addChildViewController:self];

        self.scrollView = [[GVScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(viewController.view.frame), CGRectGetHeight(viewController.view.frame))];
        [viewController.view addSubview:self.scrollView];
    }
    
    return self;
}

- (NSArray<NSNumber *> *)offsets {
    if (self.scrollView) {
        return self.scrollView.offsets;
    }
    
    return nil;
}

- (void)setOffsets:(NSArray<NSNumber *> *)offsets {
    if (self.scrollView) {
        [self.scrollView setOffsets:offsets];
    }
}

- (int)currentOffsetIndex {
    if (self.scrollView) {
        return self.scrollView.offsetIndex;
    }

    return INT_MIN;
}

- (GVScrollViewOrientationType)orientationType {
    if (self.scrollView) {
        return self.scrollView.orientationType;
    }
    
    return 0;
}

- (void)setMarginOffset:(CGFloat)marginOffset {
    [self.scrollView setMargin:marginOffset];
}

- (CGFloat)marginOffset {
    if (!self.scrollView) {
        
    }
    
    return [self.scrollView margin];
}

#pragma mark - Public methods

- (void)setContentViewController:(UIViewController<GlideContentViewControllerProtocol> *)contentViewController
                            type:(GVScrollViewOrientationType)type
                         offsets:(NSArray<NSNumber *> *)offsets {
    
    if (!contentViewController) {
        @throw [NSException exceptionWithName:GVException
                                       reason:@"Invalid contentViewController - ViewController cannot be nil"
                                     userInfo:nil];
    }
    
    if (self.scrollView && !CGRectIsNull(self.scrollView.frame)) {
        
        [self.scrollView setOrientationType:type];
        [self.scrollView setOffsets:offsets];
        
        self.contentViewController = contentViewController;
        [self.scrollView setContent:self.contentViewController.view];
 
        self.scrollView.delegate = self;
        
        [self setCanCloseDragging:YES];
    }
}

- (void)shake {
    
    CGFloat shakeMargin = 10.0f;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:2];
    [animation setAutoreverses:YES];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    if (self.orientationType == GVScrollViewOrientationRightToLeft) {
        [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView center].x,
                                                                       [self.scrollView  center].y)]];
        [animation setToValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView  center].x + shakeMargin,
                                                                     [self.scrollView  center].y)]];
        
    } else if (self.orientationType == GVScrollViewOrientationBottomToTop ||
               self.orientationType == GVScrollViewOrientationTopToBottom) {
        [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView center].x,
                                                                       [self.scrollView  center].y)]];
        [animation setToValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView  center].x,
                                                                     [self.scrollView  center].y + shakeMargin)]];
    }

    [[self.scrollView layer] addAnimation:animation forKey:@"position"];
}

- (void)expand {
    if (self.isMoving) {
        return;
    }
    self.isMoving = YES;
    
    if ([self.delegate respondsToSelector:@selector(glideViewControllerWillExpand:)]) {
        [self.delegate glideViewControllerWillExpand:self];
    }
    
    [self.scrollView expandWithCompletion:^(BOOL finished) {
        self.isMoving = NO;
        if ([self.delegate respondsToSelector:@selector(glideViewControllerDidExpand:)]) {
            [self.delegate glideViewControllerDidExpand:self];
        }
    }];
}

- (void)collapse {
    if (self.isMoving) {
        return;
    }
    self.isMoving = YES;
    
    if ([self.delegate respondsToSelector:@selector(glideViewControllerWillCollapse:)]) {
        [self.delegate glideViewControllerWillCollapse:self];
    }
    
    [self.scrollView collapseWithCompletion:^(BOOL finished) {
        self.isMoving = NO;
        if ([self.delegate respondsToSelector:@selector(glideViewControllerDidCollapse:)]) {
            [self.delegate glideViewControllerDidCollapse:self];
        }
    }];
}

- (void)remain {
    if (self.isMoving) {
        return;
    }
    self.isMoving = YES;
    
    [self.scrollView changeOffsetTo:self.currentOffsetIndex animated:YES completion:^(BOOL finished) {
        self.isMoving = NO;
    }];
}

- (void)close {
    if (self.isMoving) {
        return;
    }
    self.isMoving = YES;
    
    if ([self.delegate respondsToSelector:@selector(glideViewControllerWillCollapse:)]) {
        [self.delegate glideViewControllerWillCollapse:self];
    }
    
    [self.scrollView closeWithCompletion:^(BOOL finished) {
        self.isMoving = NO;
        if ([self.delegate respondsToSelector:@selector(glideViewControllerDidCollapse:)]) {
            [self.delegate glideViewControllerDidCollapse:self];
        }
    }];
}

- (BOOL)isOpen {
    return self.scrollView.isOpen;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat max = [[self offsets] lastObject].floatValue;
    if (self.orientationType == GVScrollViewOrientationTopToBottom) {
        max -= [self marginOffset];
    } else {
        max += [self marginOffset];
    }
    
//    NSLog(@"%@ -> max(%.1f) contentSize: %@", NSStringFromCGPoint(scrollView.contentOffset), max, NSStringFromCGSize(scrollView.contentSize));
    
    if ([self.delegate respondsToSelector:@selector(glideViewController:hasChangedOffsetOfContent:)]) {
        [self.delegate glideViewController:self hasChangedOffsetOfContent:scrollView.contentOffset];
    }
    
    if (self.orientationType == GVScrollViewOrientationRightToLeft &&
        scrollView.contentOffset.x >= max) {
        [scrollView setContentOffset:CGPointMake(max, scrollView.contentOffset.y) animated:NO];
    }
    else if (self.orientationType == GVScrollViewOrientationBottomToTop &&
             scrollView.contentOffset.y >= max) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, max) animated:NO];
    }
    else if (self.orientationType == GVScrollViewOrientationTopToBottom &&
             scrollView.contentOffset.y <= max) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, max) animated:NO];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if ((self.scrollView.orientationType == GVScrollViewOrientationRightToLeft &&
        self.scrollView.contentOffset.x > [[self.scrollView offsets] objectAtIndex:self.scrollView.offsetIndex].floatValue)
        ||
        (self.scrollView.orientationType == GVScrollViewOrientationBottomToTop &&
         self.scrollView.contentOffset.y > [[self.scrollView offsets] objectAtIndex:self.scrollView.offsetIndex].floatValue)
        ||
        (self.scrollView.orientationType == GVScrollViewOrientationTopToBottom &&
         self.scrollView.contentOffset.y < [[self.scrollView offsets] objectAtIndex:self.scrollView.offsetIndex].floatValue)) {
            
        [self expand];
    }
    else if (self.currentOffsetIndex > 1 || (self.canCloseDragging && self.currentOffsetIndex == 1)) {
        [self collapse];
    } else {
        [self remain];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.scrollView setContentOffset:self.scrollView.contentOffset animated:YES];
}

#pragma mark - Rotation event

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (self.contentViewController) {
        [self.contentViewController viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    }
    
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
        [self remain];
    } completion:nil];
}

@end
