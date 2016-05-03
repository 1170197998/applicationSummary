//
//  XSFCategorySubVC.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFCategorySubVC.h"
#import "XSFMainTableViewCell.h"
#import "XSFCommendDetailViewController.h"
@interface XSFCategorySubVC ()<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_mArrayWithModel;
    
    //刷新相关
    int _page;
    MJRefreshHeaderView *_headerView;
    MJRefreshFooterView *_footerView;
}
@end

@implementation XSFCategorySubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _mArrayWithModel = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD showWithStatus:@"努力为你加载中"];
    [self setNavigationBar];
    [self requestData];
    [self creatTableView];
}

#pragma mark - 导航栏设置
- (void)setNavigationBar
{
    self.navigationItem.title = self.navigationBarTitle;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"详情返回"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
}

#pragma mark - 返回上一页
- (void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 请求数据
- (void)requestData
{
    [_headerView endRefreshing];
    [_footerView endRefreshing];
    
    NSString *path = [NSString stringWithFormat:COMMEND_URL,_page,self.categoryId];
    [XSFRequest RequestDataWithPath:path Finish:^(NSDictionary *dictinary) {
        
        NSArray *array = dictinary[@"applications"];
        
        if (_page == 1) {
            [_mArrayWithModel removeAllObjects];
        }
        
        for (NSDictionary *dict in array) {
            XSFMainModel *model = [[XSFMainModel alloc] init];
            model.iconUrl = dict[@"iconUrl"];
            model.name = dict[@"name"];
            model.version = dict[@"version"];
            model.fileSize = dict[@"fileSize"];
            model.downloads = dict[@"downloads"];
            model.lastPrice = dict[@"lastPrice"];
            model.currentPrice = dict[@"currentPrice"];
            model.descriptio = dict[@"description"];
            model.applicationId = dict[@"applicationId"];
            model.starCurrent = dict[@"starCurrent"];
            model.itunesUrl = dict[@"itunesUrl"];
            [_mArrayWithModel addObject:model];
        }
        [_tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 创建TableView
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 80;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    // 上拉加载，下拉刷新
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _tableView;
    _headerView.delegate = self;
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _tableView;
    _footerView.delegate = self;
}

#pragma mark - 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mArrayWithModel.count;
}

#pragma mark - 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSFMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IDID"];
    UIButton *button;
    if (cell == nil) {
        cell = [[XSFMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IDID"];
         button = [XSFFactoryUI creatButtonWithFrame:CGRectMake(SCR_W - 60, 25, 60, 30) title:@"详情" imageName:nil backgroundImageName:nil target:self selector:@selector(clickButtonDetail:)];
    }
    [cell config:_mArrayWithModel[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //为cell创建右边的按钮
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [cell.contentView addSubview:button];
    return cell;
}

#pragma mark - cell右边按钮点击事件
- (void)clickButtonDetail:(UIButton *)sender
{
    XSFCommendDetailViewController *detailVC = [[XSFCommendDetailViewController alloc] init];
    UINavigationController *navDetailVC = [[UINavigationController alloc] initWithRootViewController:detailVC];
    //***-->[(UITableViewCell *)[sender superview] superview])].row<---可以标记cell的行数
    //cell的上的Button的父视图是contentView,contentView的父视图是cell
    
    XSFMainModel *model = [_mArrayWithModel objectAtIndex:[_tableView indexPathForCell:([(UITableViewCell *)[sender superview] superview])].row];
    detailVC.model = model;
    //[self.view.window.rootViewController presentViewController:navDetailVC animated:NO completion:nil];
    [self presentViewController:navDetailVC animated:YES completion:nil];
}

#pragma mark - MJRefreshBaseViewDelegate代理方法(刷新)
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [SVProgressHUD showWithStatus:@"努力刷新中"];
    if (refreshView == _headerView) {// 刷新
        _page = 1;
    }else
    {// 加载
        _page ++;
    }
    
    // 请求数据
    [self requestData];
}


- (void)dealloc
{
    [_headerView free];
    [_footerView free];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
