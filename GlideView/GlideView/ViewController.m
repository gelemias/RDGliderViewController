//
//  ViewController.m
//  GlideView
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017. All rights reserved.
//

#import "ViewController.h"
#import "GlideViewController.h"
#import "ContentViewController.h"
#import "GVGradientView.h"

@interface ViewController () <GlideViewControllerDelegate>

@property (nonatomic) GlideViewController *leftToRightGlideVC;
@property (nonatomic) GlideViewController *bottomToTopGlideVC;
@property (nonatomic) GlideViewController *topToBottomGlideVC;
@property (nonatomic) GlideViewController *rightToLeftGlideVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GVGradientView *bgGradient = [[GVGradientView alloc] initWithFrame:self.view.bounds];
    bgGradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bgGradient.layer.colors = @[(id)[UIColor colorWithRed:.643 green:.569 blue:.776 alpha:1].CGColor,
                                     (id)[UIColor colorWithRed:.573 green:.875 blue:.678 alpha:1].CGColor];
    [self.view insertSubview:bgGradient atIndex:0];
    
    [self initRightToLeftGlideView];
    [self initBottomToTopGlideView];
}

- (void)initRightToLeftGlideView{
    
    self.rightToLeftGlideVC = [[GlideViewController alloc] initOnViewController:self];
    self.rightToLeftGlideVC.delegate = self;
    
    ContentViewController *contentVC = [[ContentViewController alloc] initWithRect:CGRectMake(0, 0, 200, 200)];
    [self.rightToLeftGlideVC setContentViewController:contentVC
                                                type:GVScrollViewOrientationRightToLeft
                                              offsets:@[@(0), @(1)]];
}

- (void)initBottomToTopGlideView{
    self.bottomToTopGlideVC = [[GlideViewController alloc] initOnViewController:self];
    self.bottomToTopGlideVC.delegate = self;
    self.bottomToTopGlideVC.marginOffset = 10;
    
    [self.bottomToTopGlideVC setContentViewController:[ContentViewController new]
                                                 type:GVScrollViewOrientationBottomToTop
                                              offsets:@[@(0),
                                                        @(0.6),
                                                        @(0.2),
                                                        @(0.4),
                                                        @(0.8),
                                                        @(1)]];
}

#pragma mark - Actions

- (IBAction)bottomToTopButtonPressed:(id)sender {
    if ([self.bottomToTopGlideVC currentOffsetIndex] < [[self.bottomToTopGlideVC offsets] count] - 1) {
        [self.bottomToTopGlideVC expand];
    } else {
        [self.bottomToTopGlideVC collapse];
    }
}

- (IBAction)leftToRightButtonPressed:(id)sender {
    if ([self.leftToRightGlideVC currentOffsetIndex] < [[self.leftToRightGlideVC offsets] count] - 1) {
        [self.leftToRightGlideVC expand];
    } else {
        [self.leftToRightGlideVC collapse];
    }
}

- (IBAction)topToBottomButtonPressed:(id)sender {
    if ([self.topToBottomGlideVC currentOffsetIndex] < [[self.topToBottomGlideVC offsets] count] - 1) {
        [self.topToBottomGlideVC expand];
    } else {
        [self.topToBottomGlideVC collapse];
    }
}

- (IBAction)rightToLeftButtonPressed:(id)sender {
    if ([self.rightToLeftGlideVC currentOffsetIndex] < [[self.rightToLeftGlideVC offsets] count] - 1) {
        [self.rightToLeftGlideVC expand];
    } else {
        [self.rightToLeftGlideVC collapse];
    }
}

#pragma mark - GlideViewControllerDelegate

- (void)glideViewController:(GlideViewController *)glideViewController hasChangedOffsetOfContent:(CGPoint)offset {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setOffset:NSStringFromCGPoint(offset)];
}

- (void)glideViewControllerDidExpand:(GlideViewController *)glideViewController {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setIndex:glideViewController.currentOffsetIndex ofMax:[glideViewController.offsets count]];
}

- (void)glideViewControllerDidCollapse:(GlideViewController *)glideViewController {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setIndex:glideViewController.currentOffsetIndex ofMax:[glideViewController.offsets count]];
}

@end
