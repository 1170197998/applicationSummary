//
//  XSFTopicViewController.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFTopicViewController.h"
#import "XSFTopicTableViewCell.h"
#import "XSFTopicRequest.h"
#import "XSFTopicModel.h"
#import "TopicSubModel.h"
#import "XSFCommendViewController.h"
@interface XSFTopicViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,XSFTopicTableViewCellDelegate>
{
    NSDictionary *_dictt;
    NSMutableArray *_mArrayWithModel;
    NSMutableArray *_mArrayWithSubModel;
    NSArray *_arrayApplocations;
    UITableView *_tableView;
    NSMutableArray *_mArray;
    //刷新相关
    int _page;
    MJRefreshHeaderView *_headerView;
    MJRefreshFooterView *_footerView;
}
@end

@implementation XSFTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    _mArrayWithModel = [NSMutableArray array];
    _mArrayWithSubModel = [NSMutableArray array];
    _mArray = [NSMutableArray array];
    _page = 1;
    [self requestData];
    [self creatTableView];
}

#pragma mark - 请求数据
- (void)requestData
{
    [_headerView endRefreshing];
    [_footerView endRefreshing];
    
    NSString *path = [NSString stringWithFormat:TOPIC_URL,_page];
    [XSFTopicRequest RequestDataWithPath:path Finish:^(NSArray *array) {

        if (_page == 1) {
            [_mArrayWithModel removeAllObjects];
        }
        for (NSDictionary *dict in array) {
            
            XSFTopicModel *model = [[XSFTopicModel alloc] initWithDictionary:dict];
            [_mArrayWithModel addObject:model];
            [_mArray addObject:dict];
            
            _arrayApplocations = dict[@"applications"];
            for (NSDictionary *dict in _arrayApplocations) {
                TopicSubModel *subModel = [[TopicSubModel alloc] initWithDictionary:dict];
                [_mArrayWithSubModel addObject:subModel];
            }
        }
        [_tableView reloadData];
        [SVProgressHUD dismiss];   
    }];
}

#pragma mark - 创建TableView
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 45 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = SCR_H / 2;
    [self.view addSubview:_tableView];
    
    
    // 上拉加载，下拉刷新
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _tableView;
    _headerView.delegate = self;
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _tableView;
    _footerView.delegate = self;
}

#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mArrayWithModel.count;
}

#pragma mark - 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"XSFTopoller";
    XSFTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XSFTopicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    XSFTopicModel *model = _mArrayWithModel[indexPath.row];
    [cell getModel:model];
    
    cell.title.text = _mArray[indexPath.row][@"title"];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:_mArray[indexPath.row][@"img"]]];
    [cell.desc_img sd_setImageWithURL:[NSURL URLWithString:_mArray[indexPath.row][@"desc_img"]]];
    cell.desc.text = _mArray[indexPath.row][@"desc"];
    return cell;
}

#pragma mark - MJRefreshBaseViewDelegate代理方法(刷新)
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [SVProgressHUD showWithStatus:@"努力刷新中"];
    if (refreshView == _headerView) {// 刷新
        _page = 1;
    } else {
        // 加载
        _page ++;
    }
    
    // 请求数据
    [self requestData];
}

#pragma mark - 小cell点击事件
- (void)xsfTopIcTableViewCell:(XSFTopicTableViewCell *)tableViewCell clickRowWithId:(NSString *)RowId
{
    NSLog(@"%@",RowId);
}

- (void)dealloc
{
    [_headerView free];
    [_footerView free];
}

@end
