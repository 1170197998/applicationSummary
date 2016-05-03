//
//  XSFCommendDetailViewController.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/31.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFCommendDetailViewController.h"
#import "StarView.h"
#import "XSFShowPictureViewController.h"
#import "UMSocial.h"
@interface XSFCommendDetailViewController ()<UIActionSheetDelegate,UMSocialUIDelegate>
{
    StarView *_starView;
    UIView *_backgroundView;
    UIImageView *_imageViewIcon;
    UILabel *_nameLabel;
    UILabel *_priceLabel;
    UITextView *_textView;
    UIScrollView *_scrollView;
    
    NSMutableArray *_mArrayOriginalUrl;
    NSMutableArray *_mArraysmallUrl;
}
@end

@implementation XSFCommendDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationBar];
    [self requestData];
}

#pragma mark - 导航栏设置
- (void)setNavigationBar
{
    _mArrayOriginalUrl = [NSMutableArray array];
    _mArraysmallUrl = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = @"应用详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"详情返回"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
}

- (void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 请求数据
- (void)requestData
{
    NSString *path = [NSString stringWithFormat:DETAIL_URL,[_model.applicationId intValue]];
    [XSFRequest RequestDataWithPath:path Finish:^(NSDictionary *dictinary) {

        for (NSDictionary *dict in dictinary[@"photos"]) {
            
            [_mArraysmallUrl addObject:dict[@"smallUrl"]];
            [_mArrayOriginalUrl addObject:dict[@"originalUrl"]];
        }
        [self BuildUI];
    }];
}

#pragma mark - 搭建UI
- (void)BuildUI
{
    //View背景
    _backgroundView = [XSFFactoryUI creatViewWithFrame:CGRectMake(10, 84, SCR_W - 20, SCR_H - 100)];
    //_backgroundView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_backgroundView];
    
    //图标
    _imageViewIcon = [XSFFactoryUI creatImageViewWithFrame:CGRectMake(0, 0, _backgroundView.frame.size.width / 3, _backgroundView.frame.size.width / 3) imageName:@""];
    _imageViewIcon.clipsToBounds = YES;
    [_imageViewIcon.layer setCornerRadius:10];
    [_backgroundView addSubview:_imageViewIcon];
    
    //名称标签
    _nameLabel = [XSFFactoryUI creatLabelWithFrame:CGRectMake(_imageViewIcon.frame.size.width + 10, 0, _backgroundView.frame.size.width / 2, _imageViewIcon.frame.size.width / 3) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    [_backgroundView addSubview:_nameLabel];
    
    //价格标签
    _priceLabel = [XSFFactoryUI creatLabelWithFrame:CGRectMake(_imageViewIcon.frame.size.width + 10, _imageViewIcon.frame.size.width / 3, _backgroundView.frame.size.width / 2, _imageViewIcon.frame.size.width / 3) text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15]];
    [_backgroundView addSubview:_priceLabel];
    
    //星星个数
    _starView = [[StarView alloc] initWithFrame:CGRectMake(_imageViewIcon.frame.size.width + 10, _imageViewIcon.frame.size.width / 1.5 + 7, _backgroundView.frame.size.width / 2, _imageViewIcon.frame.size.width / 3)];
    _starView.backgroundColor = [UIColor clearColor];
    [_backgroundView addSubview:_starView];
    
    //滚图
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _imageViewIcon.frame.size.height + 10, _backgroundView.frame.size.width, _imageViewIcon.frame.size.width + 20)];
    [_backgroundView addSubview:_scrollView];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(_mArraysmallUrl.count * _backgroundView.frame.size.width / 2.5, _imageViewIcon.frame.size.width + 20);
    //为滚图添加图片
    for (NSInteger i = 0; i < _mArraysmallUrl.count; i ++) {
        
        UIImageView *imageView = [XSFFactoryUI creatImageViewWithFrame:CGRectMake(i * _backgroundView.frame.size.width / 2.5 , 0, _backgroundView.frame.size.width / 2.5, _imageViewIcon.frame.size.width + 20) imageName:nil];
        [imageView sd_setImageWithURL:[NSURL URLWithString:_mArraysmallUrl[i]] placeholderImage:[UIImage imageNamed:@"error"]];
        [_scrollView addSubview:imageView];
        
        //为图片添加点击手势
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabDetailGes:)];
        [imageView addGestureRecognizer:tap];
    }
   
    //文字说明
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, _scrollView.frame.size.height + _scrollView.frame.origin.y + 10, _backgroundView.frame.size.width, _backgroundView.frame.size.height - (_scrollView.frame.size.height + _scrollView.frame.origin.y + 50))];
    _textView.backgroundColor = RGB(246, 246, 246);
    _textView.editable = NO;
    [_backgroundView addSubview:_textView];
    
    //底部按钮
    NSArray *arrayButtonTitle = @[@"收藏",@"分享",@"下载"];
    for (NSInteger i = 0; i < 3; i ++) {
        UIButton *button = [XSFFactoryUI creatButtonWithFrame:CGRectMake(i * _backgroundView.frame.size.width / 3, _backgroundView.frame.size.height - 50, _backgroundView.frame.size.width / 3, 50) title:arrayButtonTitle[i] imageName:nil backgroundImageName:nil target:nil selector:nil];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 200 + i;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:button];
        if (i == 0) {
            [button setTitle:@"收藏成功" forState:UIControlStateSelected];
        }
    }
    [self setValueForUI];
}

#pragma mark - 手势点击事件
- (void)tabDetailGes:(UITapGestureRecognizer *)sender
{
    //记下tag值
    UIView *view = sender.view;
    XSFShowPictureViewController *showPictureVC = [[XSFShowPictureViewController alloc] init];
    //传递Tag值和数组图片
    showPictureVC.mArrayOfimage = _mArrayOriginalUrl;
    showPictureVC.pageNum = view.tag - 100;
    
    [self.navigationController pushViewController:showPictureVC animated:YES];
}

#pragma mark - 底部按钮点击事件
- (void)clickButton:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:{
            if (sender.selected == NO) {
                sender.selected = YES;
                sender.userInteractionEnabled = NO;

                //写入沙盒路径(applicationId作为字典的键,避免重复收藏)
                NSString *path = [NSString stringWithFormat:@"%@/Documents/collections.plist",NSHomeDirectory()];
                NSMutableDictionary *mDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
                if (!mDictionary) {
                    mDictionary = [[NSMutableDictionary alloc] init];
                }
                //字典的值dict
                NSDictionary *dict = @{@"name":_model.name,@"iconUrl":_model.iconUrl,@"applicationId":_model.applicationId};
                [mDictionary setValue:dict forKey:_model.applicationId];
                [mDictionary writeToFile:path atomically:NO];
            }
        }   break;
            
        case 201:{
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ",@"微信",@"新浪微博",@"人人",@"SMS", nil];
            [sheet showInView:self.view];
        }   break;
            
        case 202:{
            NSMutableString *mStringPathReqult = [NSMutableString stringWithString:_model.iconUrl];
            //修改为苹果商店链接
                [mStringPathReqult deleteCharactersInRange:NSMakeRange(0, 7)];
                [mStringPathReqult insertString:@"http://www.apple.com/" atIndex:0];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mStringPathReqult]];
        }   break;
    }
}

#pragma mark - 友盟分享
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex < 5) {
        [[UMSocialControllerService defaultControllerService] setShareText:@"一起来玩呗" shareImage:nil socialUIDelegate:nil];
        NSArray *platFormArray = @[UMShareToQQ,UMShareToWechatSession,UMShareToSina,UMShareToRenren,UMShareToSms];
        UMSocialSnsPlatform *platForm = [UMSocialSnsPlatformManager getSocialPlatformWithName:platFormArray[buttonIndex]];
        platForm.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
}

#pragma mark - 为UI控件赋值
- (void)setValueForUI
{
    [_imageViewIcon sd_setImageWithURL:[NSURL URLWithString:_model.iconUrl] placeholderImage:[UIImage imageNamed:@"angle-mask"]];
    _nameLabel.text = _model.name;
    _priceLabel.text = [NSString stringWithFormat:@"原价:%@    现价:%@",_model.lastPrice,_model.currentPrice];
    _textView.text = _model.descriptio;
    [_starView setStar:_model.starCurrent.floatValue];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
