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
@property (nonatomic) GVGradientView *bgGradient;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgGradient = [[GVGradientView alloc] initWithFrame:self.view.bounds];
    self.bgGradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.bgGradient.layer.colors = @[(id)[UIColor colorWithRed:.643 green:.569 blue:.776 alpha:1].CGColor,
                                     (id)[UIColor colorWithRed:.573 green:.875 blue:.678 alpha:1].CGColor];
    [self.view insertSubview:self.bgGradient atIndex:0];
    
    [self initRightToLeftGlideView];
    [self initBottomToTopGlideView];
}

- (void)initRightToLeftGlideView{
    
    self.rightToLeftGlideVC = [[GlideViewController alloc] initOnViewController:self];
    self.rightToLeftGlideVC.delegate = self;
    
    ContentViewController *contentVC = [[ContentViewController alloc] initWithRect:CGRectMake(0, 0, 200, CGRectGetHeight([UIScreen mainScreen].bounds))];
    [self.rightToLeftGlideVC setContentViewController:contentVC
                                                type:GVScrollViewOrientationLeftToRight
                                              offsets:@[@(0), @(CGRectGetWidth(contentVC.view.frame) - self.rightToLeftGlideVC.margin / 2)]];
}

- (void)initBottomToTopGlideView{
    self.bottomToTopGlideVC = [[GlideViewController alloc] initOnViewController:self];
    self.bottomToTopGlideVC.delegate = self;
    
    ContentViewController *contentVC = [[ContentViewController alloc] initWithRect:CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds), 200)];
    [self.bottomToTopGlideVC setContentViewController:contentVC
                                                 type:GVScrollViewOrientationBottomToTop
                                              offsets:@[@(0), @(CGRectGetHeight(contentVC.view.frame) - self.bottomToTopGlideVC.margin / 2)]];
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

@end
