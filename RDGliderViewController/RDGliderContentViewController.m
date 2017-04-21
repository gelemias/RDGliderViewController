//
//  ContentViewController.m
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import "RDGliderContentViewController.h"

@interface RDGliderContentViewController ()

@property (nonatomic) CGFloat lenght;

@end

@implementation RDGliderContentViewController

- (instancetype)initWithLength:(CGFloat)lenght {
    if (self = [self init]) {
        _lenght = lenght;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.lenght, self.lenght);
    
    [self setCornerRadius:0.0f];
    [self setShowShadow:NO];
}

- (void)setShowShadow:(BOOL)showShadow {
    if (showShadow) {
        self.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.view.layer.shadowOpacity = 0.5f;
        self.view.layer.shadowRadius = 5.0f;
        self.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.view.layer.cornerRadius = cornerRadius;
    [self.view.subviews firstObject].layer.cornerRadius = cornerRadius;
    
}
@end
