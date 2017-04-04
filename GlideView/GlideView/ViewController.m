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

@property (nonatomic) GlideViewController *leftToRightGlideViewController;
@property (nonatomic) GlideViewController *bottomToTopGlideViewController;
@property (nonatomic) GlideViewController *topToBottomGlideViewController;
@property (nonatomic) GVGradientView *bgGradient;

@end

#define kGlideMargin 10.0f

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgGradient = [[GVGradientView alloc] initWithFrame:self.view.bounds];
    self.bgGradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.bgGradient.layer.colors = @[(id)[UIColor colorWithRed:.643 green:.569 blue:.776 alpha:1].CGColor,
                                     (id)[UIColor colorWithRed:.573 green:.875 blue:.678 alpha:1].CGColor];
    [self.view insertSubview:self.bgGradient atIndex:0];
    
    [self initLeftToRightGlideView];
    [self initBottomToTopGlideView];
}

- (void)initLeftToRightGlideView{
    
    GVScrollView *scrollView = [[GVScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.view addSubview:scrollView];
    
    self.leftToRightGlideViewController = [[GlideViewController alloc] initWithScrollView:scrollView];
    self.leftToRightGlideViewController.delegate = self;
    
    ContentViewController *contentVC = [[ContentViewController alloc] initWithRect:CGRectMake(0, 0, 200, CGRectGetHeight([UIScreen mainScreen].bounds))];
    [self.leftToRightGlideViewController setContentViewController:contentVC
                                                             type:GVScrollViewOrientationLeftToRight
                                                          offsets:@[@(0),
                                                                    @(CGRectGetWidth(contentVC.view.frame) - kGlideMargin)]];
    [self addChildViewController:self.leftToRightGlideViewController];
}

- (void)initBottomToTopGlideView{
    
    GVScrollView *scrollView = [[GVScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    [self.view addSubview:scrollView];
    
    self.bottomToTopGlideViewController = [[GlideViewController alloc] initWithScrollView:scrollView];
    self.bottomToTopGlideViewController.delegate = self;
    
    ContentViewController *contentVC = [[ContentViewController alloc] initWithRect:CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds), 200)];
    [self.bottomToTopGlideViewController setContentViewController:contentVC
                                                             type:GVScrollViewOrientationBottomToTop
                                                          offsets:@[@(0),
                                                                    @(CGRectGetHeight(contentVC.view.frame) - kGlideMargin)]];
    [self addChildViewController:self.bottomToTopGlideViewController];
}

#pragma mark - Actions

- (IBAction)bottomToTopButtonPressed:(id)sender {
    if ([self.bottomToTopGlideViewController currentOffsetIndex] < [[self.bottomToTopGlideViewController offsets] count] - 1) {
        [self.bottomToTopGlideViewController expand];
    } else {
        [self.bottomToTopGlideViewController collapse];
    }
}

- (IBAction)leftToRightButtonPressed:(id)sender {
    if ([self.leftToRightGlideViewController currentOffsetIndex] < [[self.leftToRightGlideViewController offsets] count] - 1) {
        [self.leftToRightGlideViewController expand];
    } else {
        [self.leftToRightGlideViewController collapse];
    }
}

- (IBAction)topToBottomButtonPressed:(id)sender {
    if ([self.topToBottomGlideViewController currentOffsetIndex] < [[self.topToBottomGlideViewController offsets] count] - 1) {
        [self.topToBottomGlideViewController expand];
    } else {
        [self.topToBottomGlideViewController collapse];
    }
}

@end
