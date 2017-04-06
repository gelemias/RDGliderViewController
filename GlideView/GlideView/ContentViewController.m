//
//  ContentViewController.m
//  GlideView
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize listOfSizes, offsets;

- (instancetype)initWithRect:(CGRect)rect {
    if (self = [self init]) {
        self.view.frame = rect;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 10.0f;    
    [self.view.subviews firstObject].layer.cornerRadius = 10.0f;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOpacity = 0.5f;
    self.view.layer.shadowRadius = 5.0f;
    self.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.view.layer.shadowPath = shadowPath.CGPath;
}

@end
