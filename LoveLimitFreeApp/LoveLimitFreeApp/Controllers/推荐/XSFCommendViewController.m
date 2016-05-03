//
//  XSFCommendViewController.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/30.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFCommendViewController.h"
#import "XSFMainTableViewCell.h"
#import "XSFMainModel.h"
#import "XSFCommendDetailViewController.h"
@interface XSFCommendViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,UISearchResultsUpdating>
{
    UITableView *_tableView;
    NSMutableArray *_mArrayWithModel;
    
    //刷新相关
    int _page;
    MJRefreshHeaderView *_headerView;
    MJRefreshFooterView *_footerView;
    
    //搜索相关
    UISearchController *_searchController;
    NSMutableArray *_mArraySearch;
}
@end

@implementation XSFCommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 2;
    _mArrayWithModel = [NSMutableArray array];
    _mArraySearch = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [SVProgressHUD showWithStatus:@"努力为你加载中"];
    [self requestData];
    [self creatTableView];
}

#pragma mark - 请求数据
- (void)requestData
{
    [_headerView endRefreshing];
    [_footerView endRefreshing];

    NSString *path = [NSString stringWithFormat:COMMEND_URL,_page,[NSString stringWithFormat:@"%d",6014]];
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
        _mArraySearch = _mArrayWithModel;
        [_tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 创建TableView
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 45 - 64) style:UITableViewStylePlain];
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
    
    //搜索控制器
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    [_searchController.searchBar sizeToFit];
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.placeholder = @"海量应用任意搜索";
    //把搜索searchBar放在导航条上
    self.navigationItem.titleView = _searchController.searchBar;
}

#pragma mark - 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_mArraySearch || _mArraySearch.count == 0) {
        _mArraySearch = _mArrayWithModel;
    }
    return _mArraySearch.count;
}

#pragma mark - 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSFMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    UIButton *button;
    if (cell == nil) {
        cell = [[XSFMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
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
    [self.view.window.rootViewController presentViewController:navDetailVC animated:NO completion:nil];
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

#pragma mark - UISearchResultsUpdating代理方法
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //1. 获取用户输入的字符
    NSString *string = searchController.searchBar.text;
    //2. 获取搜索数据源
    NSMutableArray *mArray = [NSMutableArray array];
    for (XSFMainModel *model in _mArrayWithModel) {
        
        if ([model.name rangeOfString:string].length > 0) {
            [mArray addObject:model];
        }
    }
    
    //3. 赋值数据源
    _mArraySearch = mArray;
    
    //4. 刷新数据
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
