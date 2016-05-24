//
//  XSFMainTableViewCell.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/30.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFMainTableViewCell.h"

@implementation XSFMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatTableViewCell];
    }
    return self;
}

#pragma mark - 创建cell 
- (void)creatTableViewCell
{
    _iconUrl = [XSFFactoryUI creatImageViewWithFrame:CGRectMake(15, 10, 60, 60) imageName:@""];
    _iconUrl.clipsToBounds = YES;
    _iconUrl.layer.cornerRadius = 8.0;
    [self.contentView addSubview:_iconUrl];
    
    _name = [XSFFactoryUI creatLabelWithFrame:CGRectMake(80, 10, SCR_W - 80, 20) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_name];
    
    _version = [XSFFactoryUI creatLabelWithFrame:CGRectMake(80, 30, SCR_W - 80, 20) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_version];
    
    _downloads = [XSFFactoryUI creatLabelWithFrame:CGRectMake(80, 50, SCR_W - 80, 20) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:_downloads];
}

#pragma mark - 为控件赋值
-(void)config:(XSFMainModel *)model
{
    [_iconUrl sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    _name.text = model.name;
    _version.text = [NSString stringWithFormat:@"版本: %@",model.version];
    _downloads.text = [NSString stringWithFormat:@"下载量: %@   大小: %@M",model.downloads,model.fileSize];
}

@end
