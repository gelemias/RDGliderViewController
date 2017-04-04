//
//  GlideViewController.m
//  GlideView
//
//  Created by GuillermoD on 8/4/16.
//  Copyright © 2017. All rights reserved.
//

#import "GlideViewController.h"

#define kDefaultMargin 20;

NSString *const GVException = @"GliveViewException";

@interface GlideViewController () <UIScrollViewDelegate> {
    int _glideDidScrollSeed;
}

@property (nonatomic) GlideContentViewController *contentViewController;
@property (nonatomic) BOOL isMoving;
@property (nonatomic) BOOL isObservingOffsets;

@end

@implementation GlideViewController

- (instancetype)initWithScrollView:(GVScrollView *)scrollView {
    if (self = [super init]) {
        self.scrollView = scrollView;
        _glideDidScrollSeed = arc4random_uniform(100);
    }
    
    return self;
}

- (void)dealloc {
    [self removeObserverContentViewController:self.contentViewController];
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

- (NSString *)glideDidScrollNotificationName {
    return [NSString stringWithFormat:@"KglideDidScrollNotificationName_%d",_glideDidScrollSeed];
}

#pragma mark - Public methods

- (void)setContentViewController:(GlideContentViewController *)contentViewController
                            type:(GVScrollViewOrientationType)type
                         offsets:(NSArray<NSNumber *> *)offsets {
    
    if (!contentViewController) {
        @throw [NSException exceptionWithName:GVException
                                       reason:@"Invalid contentViewController - ViewController cannot be nil"
                                     userInfo:nil];
    }
    
    if (self.scrollView && !CGRectIsNull(self.scrollView.frame)) {
        
        self.margin = kDefaultMargin;

        [self.scrollView setOrientationType:type];
        [self.scrollView setOffsets:offsets];
        
        if (self.contentViewController) {
            [self removeObserverContentViewController:self.contentViewController];
        }
        
        self.contentViewController = contentViewController;
        [self.scrollView setContent:self.contentViewController.view];

        self.scrollView.delegate = self;
        
        [self setShadow:YES];
        [self setCanCloseDragging:YES];
        [self addObserverContentViewController:contentViewController];
    }
}

static int offsetsObservanceContext;

- (void)addObserverContentViewController:(GlideContentViewController *)controller {
    [controller addObserver:self forKeyPath:@"offsets" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:&offsetsObservanceContext];
}

- (void)removeObserverContentViewController:(GlideContentViewController *)controller {
    @try {
        [controller removeObserver:self forKeyPath:@"offsets"];
    } @catch (NSException *exception) {
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"offsets"]) {
        self.scrollView.offsets = self.contentViewController.offsets;
        [self.scrollView updateLayouts];
    }
}

- (void)removeContent {
    [self.contentViewController removeObserver:self forKeyPath:@"offsets"];
    self.contentViewController = nil;
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)shake {
    
    CGFloat shakeMargin = 10.0f;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:2];
    [animation setAutoreverses:YES];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    if (self.orientationType == GVScrollViewOrientationLeftToRight) {
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
    
    [self.scrollView changeOffsetTo:self.currentOffsetIndex completion:^(BOOL finished) {
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

- (void)setShadow:(BOOL)shadow {
    UIBezierPath *shadowPath;
    
    if (!self.contentViewController) {
        @throw [NSException exceptionWithName:GVException
                                       reason:@"Invalid contentView - Please set first contentView and then set the shadow"
                                     userInfo:nil];
    }
    
    if (shadow) {
        shadowPath = [UIBezierPath bezierPathWithRect:self.contentViewController.view.bounds];
        self.contentViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.contentViewController.view.layer.shadowOpacity = 0.5f;
        self.contentViewController.view.layer.shadowRadius = 5.0f;
    } else {
        shadowPath = [UIBezierPath bezierPathWithRect:CGRectZero];
    }
    
    self.contentViewController.view.layer.shadowPath = shadowPath.CGPath;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat max = [[self offsets] lastObject].floatValue;
    if (self.orientationType == GVScrollViewOrientationTopToBottom) {
        max -= self.margin;
    } else {
        max += self.margin;
    }
    
    if ([self.delegate respondsToSelector:@selector(glideViewController:hasChangedOffsetOfContent:)]) {
        [self.delegate glideViewController:self hasChangedOffsetOfContent:scrollView.contentOffset];
    }
    
    if (self.orientationType == GVScrollViewOrientationLeftToRight &&
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
    
    if (self.glideDidScrollNotificationName) {
        [[NSNotificationCenter defaultCenter] postNotificationName:self.glideDidScrollNotificationName object:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if ((self.scrollView.orientationType == GVScrollViewOrientationLeftToRight &&
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

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (self.contentViewController) {
        [self.contentViewController viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    }
}

@end
