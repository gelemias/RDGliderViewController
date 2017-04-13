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
    [self initTopToBottomGlideView];
    [self initLeftToRightGlideView];
}

- (void)initRightToLeftGlideView{
    self.rightToLeftGlideVC = [[GlideViewController alloc] initOn:self
                                                      WithContent:[[ContentViewController alloc] initWithLength:200.0f]
                                                             type:GVScrollViewOrientationRightToLeft
                                                       AndOffsets:@[@(0), @(1)]];
    self.rightToLeftGlideVC.delegate = self;
}

- (void)initBottomToTopGlideView{
    self.bottomToTopGlideVC = [[GlideViewController alloc] initOn:self
                                                      WithContent:[ContentViewController new]
                                                             type:GVScrollViewOrientationBottomToTop
                                                       AndOffsets:@[@(0),
                                                                    @(0.6),
                                                                    @(0.2),
                                                                    @(0.4),
                                                                    @(0.8)]];
    self.bottomToTopGlideVC.delegate = self;
    self.bottomToTopGlideVC.marginOffset = 10;
}

- (void)initTopToBottomGlideView{
    self.topToBottomGlideVC = [[GlideViewController alloc] initOn:self
                                                      WithContent:[[ContentViewController alloc] initWithLength:400.0f]
                                                             type:GVScrollViewOrientationTopToBottom
                                                       AndOffsets:@[@(0),
                                                                    @(0.5),
                                                                    @(1)]];
    self.topToBottomGlideVC.delegate = self;
}

- (void)initLeftToRightGlideView {
    self.leftToRightGlideVC = [[GlideViewController alloc] initOn:self
                                                      WithContent:[ContentViewController new]
                                                             type:GVScrollViewOrientationLeftToRight
                                                       AndOffsets:@[@(0),
                                                                    @(0.6),
                                                                    @(0.2),
                                                                    @(0.4),
                                                                    @(0.8),
                                                                    @(1)]];
    self.leftToRightGlideVC.delegate = self;
//    self.leftToRightGlideVC.marginOffset = 10;
}

#pragma mark - Actions

- (IBAction)bottomToTopButtonPressed:(id)sender {
    if ([self.bottomToTopGlideVC currentOffsetIndex] < [[self.bottomToTopGlideVC offsets] count] - 1) {
        [self.bottomToTopGlideVC expand];
    } else {
        [self.bottomToTopGlideVC shake];
    }
}

- (IBAction)leftToRightButtonPressed:(id)sender {
    if ([self.leftToRightGlideVC currentOffsetIndex] < [[self.leftToRightGlideVC offsets] count] - 1) {
        [self.leftToRightGlideVC expand];
    } else {
        [self.leftToRightGlideVC shake];
    }
}

- (IBAction)topToBottomButtonPressed:(id)sender {
    if ([self.topToBottomGlideVC currentOffsetIndex] < [[self.topToBottomGlideVC offsets] count] - 1) {
        [self.topToBottomGlideVC expand];
    } else {
        [self.topToBottomGlideVC shake];
    }
}

- (IBAction)rightToLeftButtonPressed:(id)sender {
    if ([self.rightToLeftGlideVC currentOffsetIndex] < [[self.rightToLeftGlideVC offsets] count] - 1) {
        [self.rightToLeftGlideVC expand];
    } else {
        [self.rightToLeftGlideVC shake];
    }
}

#pragma mark - GlideViewControllerDelegate

- (void)glideViewController:(GlideViewController *)glideViewController hasChangedOffsetOfContent:(CGPoint)offset {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setOffset:NSStringFromCGPoint(offset)];
}

- (void)glideViewControllerDidExpand:(GlideViewController *)glideViewController {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setIndex:glideViewController.currentOffsetIndex ofMax:[glideViewController.offsets count] - 1];
}

- (void)glideViewControllerDidCollapse:(GlideViewController *)glideViewController {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setIndex:glideViewController.currentOffsetIndex ofMax:[glideViewController.offsets count] - 1];
}

@end
