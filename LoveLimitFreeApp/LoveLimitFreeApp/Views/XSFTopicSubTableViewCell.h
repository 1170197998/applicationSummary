//
//  XSFTopicSubTableViewCell.h
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface XSFTopicSubTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *iconUrl;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *downloads;
@property (nonatomic,strong)StarView *starOverall;

@end
