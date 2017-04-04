//
//  GlideContentViewControllerProtocol.h
//  GlideView
//
//  Created by Guillermo Delgado on 04/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GlideContentViewControllerProtocol <NSObject>

@property (nonatomic, readonly) NSArray<NSNumber *> *listOfSizes;
@property (nonatomic) NSArray<NSNumber *> *offsets;

@end
