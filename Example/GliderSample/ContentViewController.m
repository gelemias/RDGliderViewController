//
//  ContentViewController.m
//  GliderSample
//
//  Created by Guillermo Delgado on 03/04/2017.
//  Copyright © 2017 Guillermo Delgado. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *indexTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *offsetTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexBottomLabel;
@property (weak, nonatomic) IBOutlet UILabel *offsetBottomLabel;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showShadow = YES;
    self.cornerRadius = 10.0f;
}

- (void)setIndex:(NSUInteger)index ofMax:(NSUInteger)max {
    [self.indexTopLabel setText:[NSString stringWithFormat:@"Index (%lu of %lu)",(unsigned long)index , (unsigned long)max]];
    [self.indexBottomLabel setText:[NSString stringWithFormat:@"Index (%lu of %lu)",(unsigned long)index , (unsigned long)max]];
}

- (void)setOffset:(NSString *)offset {
    [self.offsetTopLabel setText:[NSString stringWithFormat:@"offset %@", offset]];
    [self.offsetBottomLabel setText:[NSString stringWithFormat:@"offset %@", offset]];
}

@end
