//
//  ContentViewController.h
//  GlideView
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlideContentViewControllerProtocol.h"

@interface ContentViewController : UIViewController <GlideContentViewControllerProtocol>

- (instancetype)initWithRect:(CGRect)rect;

@end
