//
//  XSFShowPictureViewController.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/1.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFShowPictureViewController.h"

@interface XSFShowPictureViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@end

@implementation XSFShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatScrollView];
    self.title = [NSString stringWithFormat:@"%d / %d",_pageNum + 1,_mArrayOfimage.count];
}

#pragma mark - 滑动展示图片
- (void)creatScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //添加图片
    _scrollView.contentSize = CGSizeMake(SCR_W * self.mArrayOfimage.count, 0);
    
    for (int i = 0; i < _mArrayOfimage.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCR_W, 64, SCR_W, 400)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_mArrayOfimage[i]] placeholderImage:[UIImage imageNamed:@"angle-mask"]];
        [_scrollView addSubview:imageView];
    }
    [_scrollView setContentOffset:CGPointMake(_pageNum * SCR_W, 0)];
}

#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.title = [NSString stringWithFormat:@"%.f / %d",_scrollView.contentOffset.x / SCR_W + 1,_mArrayOfimage.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
