//
//  GVGradientView.m
//  GliderSample
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import "GVGradientView.h"

@implementation GVGradientView

@dynamic layer;

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end
