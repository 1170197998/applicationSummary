//
//  XSFMainViewController.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFMainViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface XSFMainViewController ()<UIScrollViewDelegate>
{
    //放置底部按钮和按钮底线
    NSMutableArray *_mArrayButtomButton;
    UILabel *_labelLine;
    
    //创建主scrollview
    UIScrollView *_scrollView;
    
    BOOL _isClickSettingButton;
}
@end

@implementation XSFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建主滑动界面
    [self creatMainScrollView];
    
    //设置导航栏
    [self buildNavigationBar];
    
    //创建底部按钮
    [self creatTabBarItems];
}

#pragma mark - 导航栏设置
- (void)buildNavigationBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"main";
}

#pragma mark - 创建底部按钮
- (void)creatTabBarItems
{
    _mArrayButtomButton = [NSMutableArray arrayWithCapacity:0];
    
    //创建底部按钮背景色
    UIView *viewBottom = [XSFFactoryUI creatViewWithFrame:CGRectMake(0, SCR_H - 45, SCR_W, 45)];
    viewBottom.backgroundColor = RGB(246, 246, 246);
    [self.view addSubview:viewBottom];
    
    NSArray *arrayButtonTitle = @[@"推荐",@"分类",@"专题",@"更多"];
    UIButton *button;
    for (NSInteger i = 0; i < 4; i ++) {
        button = [XSFFactoryUI creatButtonWithFrame:CGRectMake(10 + i * (SCR_W - 20) / 4, 0, (SCR_W - 20) / 4, viewBottom.frame.size.height) title:arrayButtonTitle[i] imageName:nil backgroundImageName:nil target:self selector:@selector(clickButton:)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = i;
        [viewBottom addSubview:button];
        [_mArrayButtomButton addObject:button];
    }
    ((UIButton *)_mArrayButtomButton[0]).selected = YES;
    
    _labelLine = [[UILabel alloc] initWithFrame:CGRectMake(10 + (SCR_W - 20) / 8, 35, 8, 8)];
    _labelLine.center = CGPointMake(10 + (SCR_W - 20) / 8, 42);
    _labelLine.clipsToBounds = YES;
    _labelLine.layer.cornerRadius = 4;
    _labelLine.backgroundColor = [UIColor redColor];
    [viewBottom addSubview:_labelLine];
}

#pragma mark - 底部按钮点击事件
- (void)clickButton:(UIButton *)sender
{
    // 设置Button的选中情况
    for (UIButton *button in _mArrayButtomButton) {
        if (button.selected == YES) {
            button.selected = NO;
        }
    }
    sender.selected = YES;
    
    //点击按钮界面跳转
    for (NSInteger i = 0; i < 4; i ++) {
        if (sender.tag == i) {
            [_scrollView setContentOffset:CGPointMake(i * SCR_W, - 64)];
        }
    }
    //设置标记(横线)的移动情况
    [UIView animateWithDuration:0 animations:^{
        _labelLine.center = CGPointMake(10 + (2 * sender.tag + 1) * (SCR_W - 20) / 8, 42);
    }];
}

#pragma mark - 创建主滑动界面
- (void)creatMainScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 45)];
    [_scrollView setContentSize:CGSizeMake(SCR_W * self.arrayWithViewController.count, SCR_H - 45 - 64)];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    //把Controller的view添加到scrollView
    int i = 0;
    for (UIViewController *viewController in self.arrayWithViewController) {
        
        viewController.view.frame = CGRectMake(i * SCR_W, 0, SCR_W, _scrollView.frame.size.height);
        [_scrollView addSubview:viewController.view];
        i ++;
    }
    [self.view addSubview:_scrollView];
}

#pragma mark - UIscrollView 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //设置标记(横线)的移动情况
    [UIView animateWithDuration:0 animations:^{
        _labelLine.center = CGPointMake(10 + (2 * scrollView.contentOffset.x / SCR_W + 1) * (SCR_W - 20) / 8, 42);
    }];
    
    // 设置Button的选中情况
    for (UIButton *button in _mArrayButtomButton) {
        if (button.selected == YES) {
            button.selected = NO;
        }
    }
    ((UIButton *)[_mArrayButtomButton objectAtIndex:scrollView.contentOffset.x / SCR_W]).selected = YES;
}

@end
