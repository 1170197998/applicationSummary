//
//  XSFTopicTableViewCell.h
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSFTopicSubTableViewCell.h"
#import "XSFTopicModel.h"

@class XSFTopicTableViewCell;
@protocol XSFTopicTableViewCellDelegate <NSObject>
- (void)xsfTopIcTableViewCell:(XSFTopicTableViewCell *)tableViewCell clickRowWithId:(NSString *)RowId;
@end

@interface XSFTopicTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UILabel *desc;
@property (nonatomic,strong)UIImageView *desc_img;

@property (nonatomic,strong)NSArray *array;

@property (nonatomic,weak) id<XSFTopicTableViewCellDelegate>delegate;

-(void)getModel:(XSFTopicModel *)model;

@end
