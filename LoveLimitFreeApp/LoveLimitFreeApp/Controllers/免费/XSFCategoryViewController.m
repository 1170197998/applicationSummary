//
//  XSFCategoryViewController.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFCategoryViewController.h"
#import "XSFMainTableViewCell.h"
#import "XSFTopicRequest.h"
#import "XSFCategorySubVC.h"
@interface XSFCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_mArray;
}

@end

@implementation XSFCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
}

#pragma mark - 请求数据
- (void)requestData
{
    NSString *path = CATE_URL;
    [XSFTopicRequest RequestDataWithPath:path Finish:^(NSArray *array) {
        
        _mArray = array;
        [self creatTableView];
    }];
}

#pragma mark - 创建TableView
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 45 - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - 多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mArray.count;
}

#pragma mark - 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CATE"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CATE"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    NSDictionary *dict = [_mArray objectAtIndex:indexPath.row];
    cell.textLabel.text = dict[@"categoryCname"];
    return cell;
}

#pragma mark - 点击cell进去对应的分类
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSFCategorySubVC *categoryVC = [[XSFCategorySubVC alloc] init];
    NSDictionary *dict = [_mArray objectAtIndex:indexPath.row];
    categoryVC.categoryId = dict[@"categoryId"];
    categoryVC.navigationBarTitle = dict[@"categoryCname"];
    UINavigationController *navDetailVC = [[UINavigationController alloc] initWithRootViewController:categoryVC];
    [self.view.window.rootViewController presentViewController:navDetailVC animated:NO completion:nil];
}

@end
