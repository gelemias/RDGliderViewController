//
//  ViewController.m
//  GliderSample
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017. All rights reserved.
//

#import "ViewController.h"
#import "RDGliderViewController.h"
#import "ContentViewController.h"
#import "RDGradientView.h"

@interface ViewController () <RDGliderViewControllerDelegate>

@property (nonatomic) RDGliderViewController *leftToRightGlideVC;
@property (nonatomic) RDGliderViewController *bottomToTopGlideVC;
@property (nonatomic) RDGliderViewController *topToBottomGlideVC;
@property (nonatomic) RDGliderViewController *rightToLeftGlideVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RDGradientView *bgGradient = [[RDGradientView alloc] initWithFrame:self.view.bounds];
    bgGradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bgGradient.layer.colors = @[(id)[UIColor colorWithRed:(CGFloat)0.643 green:(CGFloat)0.569 blue:(CGFloat)0.776 alpha:1].CGColor,
                                     (id)[UIColor colorWithRed:(CGFloat)(CGFloat)0.573 green:(CGFloat)0.875 blue:(CGFloat)0.678 alpha:1].CGColor];
    [self.view insertSubview:bgGradient atIndex:0];
    
    [self initRightToLeftGlideView];
    [self initBottomToTopGlideView];
    [self initTopToBottomGlideView];
    [self initLeftToRightGlideView];
}

- (void)initRightToLeftGlideView{
    self.rightToLeftGlideVC = [[RDGliderViewController alloc] initOn:self
                                                      WithContent:[[ContentViewController alloc] initWithLength:200.0f]
                                                             type:RDScrollViewOrientationRightToLeft
                                                       AndOffsets:@[@(0), @(1)]];
    self.rightToLeftGlideVC.delegate = self;
}

- (void)initBottomToTopGlideView {
    self.bottomToTopGlideVC = [[RDGliderViewController alloc] initOn:self
                                                      WithContent:[ContentViewController new]
                                                             type:RDScrollViewOrientationBottomToTop
                                                       AndOffsets:@[@(0),
                                                                    @(0.6),
                                                                    @(0.2),
                                                                    @(0.4),
                                                                    @(0.8)]];
    self.bottomToTopGlideVC.delegate = self;
    self.bottomToTopGlideVC.marginOffset = 30;
}

- (void)initTopToBottomGlideView {
    self.topToBottomGlideVC = [[RDGliderViewController alloc] initOn:self
                                                      WithContent:[[ContentViewController alloc] initWithLength:400.0f]
                                                             type:RDScrollViewOrientationTopToBottom
                                                       AndOffsets:@[@(0),
                                                                    @(0.5),
                                                                    @(1)]];
    self.topToBottomGlideVC.delegate = self;
}

- (void)initLeftToRightGlideView {
    self.leftToRightGlideVC = [[RDGliderViewController alloc] initOn:self
                                                      WithContent:[ContentViewController new]
                                                             type:RDScrollViewOrientationLeftToRight
                                                       AndOffsets:@[@(0),
                                                                    @(0.6),
                                                                    @(0.2),
                                                                    @(0.4),
                                                                    @(0.8),
                                                                    @(1)]];
    self.leftToRightGlideVC.delegate = self;
    self.leftToRightGlideVC.marginOffset = 10;
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

- (void)glideViewController:(RDGliderViewController *)glideViewController hasChangedOffsetOfContent:(CGPoint)offset {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setOffset:NSStringFromCGPoint(offset)];
}

- (void)glideViewControllerDidExpand:(RDGliderViewController *)glideViewController {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setIndex:glideViewController.currentOffsetIndex ofMax:[glideViewController.offsets count] - 1];
}

- (void)glideViewControllerDidCollapse:(RDGliderViewController *)glideViewController {
    ContentViewController *vc = (ContentViewController *)glideViewController.contentViewController;
    [vc setIndex:glideViewController.currentOffsetIndex ofMax:[glideViewController.offsets count] - 1];
}

@end
