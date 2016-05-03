//
//  XSFMoreViewController.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//
//缓存路径
#define cachesPath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

#import "XSFMoreViewController.h"
#import "XSFAccountNumberVC.h"
#import "XSFCollectionVC.h"

@interface XSFMoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    NSArray *_arrayCellTitleOne;
    NSArray *_arrayCellTitleTwo;
    
    //缓存大小
    float _cachesSize;
}
@end

@implementation XSFMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayCellTitleOne = @[@"我的收藏"];
    _arrayCellTitleTwo = @[@"wifi下自动加载图片",@"推送服务",@"清理缓存",@"评分",@"版本号"];
    [self creatTableView];
}

#pragma mark - 创建TableView
- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - 设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark - 设置section的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 5;
    }
}

#pragma mark - 返回每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell.textLabel.text = _arrayCellTitleOne[indexPath.row];
    } else {
        cell.textLabel.text = _arrayCellTitleTwo[indexPath.row];
    }

    //添加UISwitch
    if (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 1)) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        UISwitch *switcher = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switcher addTarget:self action:@selector(updataSwitchAtindexPath:) forControlEvents:UIControlEventValueChanged];
        switcher.tag = indexPath.row;
        cell.accessoryView = switcher;
    }
    
    //添加版本号
    if (indexPath.section == 1 && (indexPath.row == 4)) {
        cell.accessoryType = UITableViewCellAccessoryNone;
       cell.detailTextLabel.text = @"1.10";
    }
    return cell;
}

#pragma mark - UISwitch开关事件
- (void)updataSwitchAtindexPath:(UISwitch *)sender
{
    if (sender.tag == 0) {
        if ([sender isOn]) {
            
        } else {
            
        }
    }
    if (sender.tag == 1) {
        if ([sender isOn]) {
            
        } else {
            
        }
    }
}

#pragma mark - cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转收藏界面
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        XSFCollectionVC *collectionVC = [[XSFCollectionVC alloc] init];
        UINavigationController *navCollection = [[UINavigationController alloc] initWithRootViewController:collectionVC];
        [self.view.window.rootViewController presentViewController:navCollection animated:NO completion:nil];
    }

    //清理缓存
    if (indexPath.section == 1 && indexPath.row == 2) {
        _cachesSize = [self folderSizeAtPath:cachesPath];
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"确定要清理 %.2fM缓存吗?",_cachesSize] delegate:self cancelButtonTitle:@"只清理缓存" otherButtonTitles:@"账号信息和缓存一并清理", nil];
        [alterView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    //账号信息路径
    NSString *accountPath = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    
    if (buttonIndex == 0) {

        [self clearCache:cachesPath];
    } else {
        
        //缓存和账号信息一并清理
        [self clearCache:cachesPath];
        [self clearCache:accountPath];
    }
}

#pragma mark - 计算单个文件的大小
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

#pragma mark - 计算整个目录的大小
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

#pragma mark - 清理缓存
- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
