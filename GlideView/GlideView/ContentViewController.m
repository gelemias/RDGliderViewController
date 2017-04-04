//
//  ContentViewController.m
//  GlideView
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (nonatomic) CGRect rect;

@end

@implementation ContentViewController

- (instancetype)initWithRect:(CGRect)rect {
    if (self = [self init]) {
        self.rect = rect;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = self.rect;
}

@end
