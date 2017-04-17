//
//  GVGlideViewController.m
//  GlideView
//
//  Created by GuillermoD on 8/4/16.
//  Copyright © 2017. All rights reserved.
//

#import "GVGlideViewController.h"

NSString *const GVException = @"GliveViewException";

@interface GVGlideViewController () <UIScrollViewDelegate>

@property (nonatomic) GVScrollView *scrollView;

@property (nonatomic) BOOL isObservingOffsets;

@end

@implementation GVGlideViewController

- (instancetype)initOn:(UIViewController *)parent
           WithContent:(UIViewController *)content
                  type:(GVScrollViewOrientationType)type
            AndOffsets:(NSArray<NSNumber *> *)offsets {
    if (self = [super init]) {
        
        [parent addChildViewController:self];
        self.scrollView = [[GVScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(parent.view.frame), CGRectGetHeight(parent.view.frame))];
        [parent.view addSubview:self.scrollView];
        
        [self setContentViewController:content type:type offsets:offsets];
    }
    
    return self;
}

- (NSArray<NSNumber *> *)offsets {
    if (!self.scrollView) {
        [NSException raise:@"Invalid request" format:@"GVGlideViewController have to instantiate first on a viewController"];
    }
    
    return self.scrollView.offsets;

}

- (void)setOffsets:(NSArray<NSNumber *> *)offsets {
    if (self.scrollView) {
        [self.scrollView setOffsets:offsets];
    }
}

- (NSUInteger)currentOffsetIndex {
    if (self.scrollView) {
        return self.scrollView.offsetIndex;
    }

    return 0;
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
        return 0.0f;
    }
    
    return [self.scrollView margin];
}

#pragma mark - Public methods

- (void)setContentViewController:(UIViewController *)contentViewController
                            type:(GVScrollViewOrientationType)type
                         offsets:(NSArray<NSNumber *> *)offsets {
    
    if (!contentViewController) {
        @throw [NSException exceptionWithName:GVException
                                       reason:@"Invalid contentViewController - ViewController cannot be nil"
                                     userInfo:nil];
    }
    
    if (self.scrollView && !CGRectIsNull(self.scrollView.frame)) {
        
        self.parentViewController.automaticallyAdjustsScrollViewInsets = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        [self.scrollView setOrientationType:type];
        [self.scrollView setOffsets:offsets];
        
        self.contentViewController = contentViewController;
        [self.scrollView setContent:self.contentViewController.view];
 
        self.scrollView.delegate = self;
    
        [self close];
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
    }
    else if (self.orientationType == GVScrollViewOrientationLeftToRight) {
        [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView center].x,
                                                                       [self.scrollView  center].y)]];
        [animation setToValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView  center].x - shakeMargin,
                                                                     [self.scrollView  center].y)]];
    }
    else if (self.orientationType == GVScrollViewOrientationBottomToTop) {
        [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView center].x,
                                                                       [self.scrollView  center].y)]];
        [animation setToValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView  center].x,
                                                                     [self.scrollView  center].y + shakeMargin)]];
    }
    else if (self.orientationType == GVScrollViewOrientationTopToBottom) {
        [animation setFromValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView center].x,
                                                                       [self.scrollView  center].y)]];
        [animation setToValue:[NSValue valueWithCGPoint: CGPointMake([self.scrollView  center].x,
                                                                     [self.scrollView  center].y - shakeMargin)]];
    }

    [[self.scrollView layer] addAnimation:animation forKey:@"position"];
}

- (void)expand {
    if ([self.delegate respondsToSelector:@selector(glideViewControllerWillExpand:)]) {
        [self.delegate glideViewControllerWillExpand:self];
    }
    
    [self.scrollView expandWithCompletion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(glideViewControllerDidExpand:)]) {
            [self.delegate glideViewControllerDidExpand:self];
        }
    }];
}

- (void)collapse {
    if ([self.delegate respondsToSelector:@selector(glideViewControllerWillCollapse:)]) {
        [self.delegate glideViewControllerWillCollapse:self];
    }
    
    [self.scrollView collapseWithCompletion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(glideViewControllerDidCollapse:)]) {
            [self.delegate glideViewControllerDidCollapse:self];
        }
    }];
}

- (void)changeOffsetTo:(NSUInteger)offsetIndex animated:(BOOL)animated {
    if (offsetIndex > self.currentOffsetIndex) {
        if ([self.delegate respondsToSelector:@selector(glideViewControllerWillExpand:)]) {
            [self.delegate glideViewControllerWillExpand:self];
        }
    } else if (offsetIndex < self.currentOffsetIndex) {
        if ([self.delegate respondsToSelector:@selector(glideViewControllerWillCollapse:)]) {
            [self.delegate glideViewControllerWillCollapse:self];
        }
        
    }
    
    [self.scrollView changeOffsetTo:offsetIndex
                           animated:animated
                         completion:^(BOOL finished) {
                             if (offsetIndex > self.currentOffsetIndex) {
                                 if ([self.delegate respondsToSelector:@selector(glideViewControllerDidExpand:)]) {
                                     [self.delegate glideViewControllerDidExpand:self];
                                 }
                             } else {
                                  if ([self.delegate respondsToSelector:@selector(glideViewControllerDidCollapse:)]) {
                                     [self.delegate glideViewControllerDidCollapse:self];
                                  }
                             }
                         }];
}

- (void)close {
    if ([self.delegate respondsToSelector:@selector(glideViewControllerWillCollapse:)]) {
        [self.delegate glideViewControllerWillCollapse:self];
    }
    
    [self.scrollView closeWithCompletion:^(BOOL finished) {
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
    NSLog(@"offset: %@ / size: %@ / frame: %@",
          NSStringFromCGPoint(scrollView.contentOffset),
          NSStringFromCGSize(scrollView.contentSize),
          NSStringFromCGSize(scrollView.frame.size));
    
    if ([self.delegate respondsToSelector:@selector(glideViewController:hasChangedOffsetOfContent:)]) {
        [self.delegate glideViewController:self hasChangedOffsetOfContent:scrollView.contentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSUInteger index = 0;
    CGFloat offset = self.scrollView.contentOffset.x;
    CGFloat threshold = CGRectGetWidth(self.scrollView.content.frame);

    if (self.orientationType == GVScrollViewOrientationBottomToTop ||
        self.orientationType == GVScrollViewOrientationTopToBottom) {
        offset = self.scrollView.contentOffset.y;
        threshold = CGRectGetHeight(self.scrollView.content.frame);
    }
    
    NSUInteger distance = INT_MAX;
    for (int i = 0 ; i < [self.offsets count] ; i++) {
        CGFloat transformedOffset = [[self.scrollView offsets] objectAtIndex:i].floatValue * threshold;
        NSUInteger distToAnchor = fabs(offset - transformedOffset);
        if (distToAnchor < distance) {
            distance = distToAnchor;
            index = i;
        }
    }
    
    [self changeOffsetTo:(index == 0 && self.disableDraggingToClose) ? 1 : index animated:NO];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.scrollView setContentOffset:self.scrollView.contentOffset animated:NO];
}

#pragma mark - Rotation event

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if (self.contentViewController) {
        [self.contentViewController viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    }
    
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
        [self changeOffsetTo:self.currentOffsetIndex animated:YES];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.scrollView recalculateContentSize];
    }];
}

@end
