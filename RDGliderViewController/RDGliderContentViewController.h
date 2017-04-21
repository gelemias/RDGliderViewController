//
//  ContentViewController.h
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDGliderContentViewController : UIViewController

/**
 shows a shadow behind the view, default value is NO
 */
@property (nonatomic) BOOL showShadow;

/**
 Sets a corner radius to the view, default value is 0.0f
 */
@property (nonatomic) CGFloat cornerRadius;


/**
 Constructor to define a fixed length view.
 */
- (instancetype)initWithLength:(CGFloat)lenght;

@end
