//
//  XSFCollectionViewCell.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFCollectionViewCell.h"

@implementation XSFCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addImageViewAndLabel];
    }
    return self;
}

- (void)addImageViewAndLabel
{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 70)];
    self.imageView.clipsToBounds = YES;
    [self.imageView.layer setCornerRadius:10];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 100, 30)];
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.buttonDelete = [[UIButton alloc] initWithFrame:CGRectMake(80, - 5, 25, 25)];
    [self.buttonDelete setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.label];
    [self addSubview:self.buttonDelete];
}

@end
