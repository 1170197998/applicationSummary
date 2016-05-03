//
//  XSFMainTableViewCell.h
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/30.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSFMainModel.h"
@interface XSFMainTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *iconUrl;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *version;
@property (nonatomic,strong)UILabel *fileSize;
@property (nonatomic,strong)UILabel *downloads;

-(void)config:(XSFMainModel *)model;


@end
