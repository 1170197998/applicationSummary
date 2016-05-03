//
//  XSFTopicSubTableViewCell.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFTopicSubTableViewCell.h"
#import "TopicSubModel.h"
@implementation XSFTopicSubTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatCell];
    }
    return self;
}

#pragma mark - 设置cell 中的UI
- (void)creatCell
{
    self.iconUrl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, TOPIC_CELL_CELL, TOPIC_CELL_CELL)];
    self.iconUrl.clipsToBounds = YES;
    [self.iconUrl.layer setCornerRadius:8.0];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(self.iconUrl.frame.size.width, 0, SCR_W / 2 - self.iconUrl.frame.size.width, (TOPIC_CELL_CELL / 3))];
    
    self.downloads = [[UILabel alloc] initWithFrame:CGRectMake(self.iconUrl.frame.size.width, TOPIC_CELL_CELL / 3, SCR_W / 2 - self.iconUrl.frame.size.width, TOPIC_CELL_CELL / 3)];
    
    //星星个数
    self.starOverall = [[StarView alloc] initWithFrame:CGRectMake(self.iconUrl.frame.size.width, TOPIC_CELL_CELL / 1.5, SCR_W / 2 - self.iconUrl.frame.size.width, TOPIC_CELL_CELL / 3)];
    self.starOverall.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.starOverall];
    [self.contentView addSubview:self.iconUrl];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.downloads];
    [self.contentView addSubview:self.starOverall];
}

@end
