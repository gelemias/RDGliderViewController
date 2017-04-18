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
@property (nonatomic) CGFloat lenght;

@end

@implementation ContentViewController

- (instancetype)initWithLength:(CGFloat)lenght {
    if (self = [self init]) {
        self.lenght = lenght;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.lenght, self.lenght);
    
    // corner radius
    self.view.layer.cornerRadius = 10.0f;
    [self.view.subviews firstObject].layer.cornerRadius = 10.0f;
    
    // shadow
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOpacity = 0.5f;
    self.view.layer.shadowRadius = 5.0f;
    self.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
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
