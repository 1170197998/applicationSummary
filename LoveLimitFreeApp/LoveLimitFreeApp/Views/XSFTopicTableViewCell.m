//
//  XSFTopicTableViewCell.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/5.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFTopicTableViewCell.h"
#import "XSFTopicSubTableViewCell.h"
#import "XSFTopicModel.h"
#import "XSFMainModel.h"
@interface XSFTopicTableViewCell ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _mArray;
    XSFTopicModel * _model;
    UITableView *_tableView;
}
@end

@implementation XSFTopicTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

#pragma mark - 获取数据模型
-(void)getModel:(XSFTopicModel *)model{

    _mArray = model.applications;
    
    [self creatTabeleView];
    [self addTableCellUI];
}

#pragma mark - 创建cell中的TableView
- (void)creatTabeleView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, SCR_W / 2, TOPIC_CELL_CELL * 4) style:UITableViewStylePlain];
    _tableView.rowHeight = TOPIC_CELL_CELL;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.scrollEnabled = NO;
#warning  禁止tableView被点击
    _tableView.allowsSelection = NO;
    [self.contentView addSubview:_tableView];
}

#pragma mark - 总共4行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mArray.count;
}

#pragma mark - 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"hehehegh";
    XSFTopicSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XSFTopicSubTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *dict = _mArray[indexPath.row];
    cell.name.text = dict[@"name"];
    [cell.iconUrl sd_setImageWithURL:[NSURL URLWithString:dict[@"iconUrl"]]];
    cell.downloads.text = [NSString stringWithFormat:@"下载量: %@",dict[@"downloads"]];
    [cell.starOverall setStar:[dict[@"starOverall"] floatValue]];
    
    return cell;
}

#pragma mark - 设置TableView之外的其他UI
- (void)addTableCellUI
{
    if (!self.title) {
        self.title = [XSFFactoryUI creatLabelWithFrame:CGRectMake(0, 0, SCR_W, 30) text:@"标题" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:20]];
        self.title.backgroundColor = RGB(arc4random() % 255, arc4random() % 255, arc4random() % 255);
        self.title.textAlignment = NSTextAlignmentCenter;
    }
    
    if (!self.img) {
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_W / 2, 35, SCR_W / 2, TOPIC_CELL_CELL * 4)];
        self.img.clipsToBounds = YES;
        [self.img.layer setCornerRadius:10];
    }
    
    if (!self.desc_img) {
        self.desc_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35 + TOPIC_CELL_CELL * 4, 50, 50)];
        self.desc_img.clipsToBounds = YES;
        [self.desc_img.layer setCornerRadius:10.0];
    }
    
    if (!self.desc) {
        self.desc = [XSFFactoryUI creatLabelWithFrame:CGRectMake(50,40 + TOPIC_CELL_CELL * 4, SCR_W - 50, 50) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:12]];
        self.desc.lineBreakMode = NSLineBreakByWordWrapping;
        self.desc.numberOfLines = 0;
    }

    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.desc];
    [self.contentView addSubview:self.desc_img];
    [self.contentView addSubview:self.img];
}

#pragma mark - 小cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(xsfTopIcTableViewCell:clickRowWithId:)]) {
        [_delegate xsfTopIcTableViewCell:self clickRowWithId:self.array[indexPath.row][@"applicationId"]];
    }
}


@end
