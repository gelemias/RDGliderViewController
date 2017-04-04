//
//  GAButton.m
//  GlideView
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017. All rights reserved.
//

#import "GVButton.h"

@interface GVButton()

@property (nonatomic) UIColor *bgColor;

@end

@implementation GVButton

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([self.bgColor CGColor]));
    CGContextFillPath(ctx);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _bgColor = [backgroundColor copy];
    super.backgroundColor = [UIColor clearColor];
}

@end
