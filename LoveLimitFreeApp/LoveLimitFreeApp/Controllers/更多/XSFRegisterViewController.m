//
//  XSFRegisterViewController.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFRegisterViewController.h"
#import "XSFAccountNumberVC.h"
@interface XSFRegisterViewController ()
{
    UITextField *_textFieldName;
    UITextField *_textFieldPassword;
}
@end

@implementation XSFRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    [self creatTextField];
    [self creatButton];
}


#pragma mark - 导航栏设置
- (void)setNavigationBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(clickBack)];
}

#pragma mark - 创建UITextField登陆框
- (void)creatTextField
{
    CGFloat textFieldW = 300;
    CGFloat textFieldH = 35;
    
    //账号输入框
    _textFieldName = [[UITextField alloc] initWithFrame:CGRectMake((SCR_W - textFieldW) / 2, SCR_H / 2 - 170, textFieldW, textFieldH)];
    _textFieldName.backgroundColor = [UIColor whiteColor];
    [_textFieldName.layer setBorderWidth:2.0];
    [_textFieldName.layer setCornerRadius:10.0];
    _textFieldName.placeholder = @"账号";
    _textFieldName.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.view addSubview:_textFieldName];
    
    //密码输入框
    _textFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake((SCR_W - textFieldW) / 2, SCR_H / 2 - 100, textFieldW, textFieldH)];
    _textFieldPassword.backgroundColor = [UIColor whiteColor];
    [_textFieldPassword.layer setBorderWidth:2.0];
    [_textFieldPassword.layer setCornerRadius:10.0];
    _textFieldPassword.placeholder = @"6 ~ 18位密码";
    _textFieldPassword.secureTextEntry = YES;
    [self.view addSubview:_textFieldPassword];
}

#pragma mark - 创建按钮
- (void)creatButton
{
    CGFloat buttonW = 80;
    CGFloat buttonH = 30;
    UIButton *buttonRegister = [[UIButton alloc] initWithFrame:CGRectMake((SCR_W -buttonW) / 2, _textFieldPassword.frame.origin.y + 50, buttonW, buttonH)];
    [buttonRegister setTitle:@"确定注册" forState:UIControlStateNormal];
    [buttonRegister setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonRegister addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRegister];
}

#pragma mark - 点击注册按钮
- (void)clickRegister
{
    if (![_textFieldName.text isEqual:@""] && ![_textFieldPassword.text isEqual:@""]) {
        
        if (_textFieldPassword.text.length >= 6 || _textFieldPassword.text.length > 18) {
            
            //写入沙盒路径(applicationId作为字典的键,避免重复收藏)
            NSString *path = [NSString stringWithFormat:@"%@/Documents/userInfo.plist",NSHomeDirectory()];
            NSMutableDictionary *mDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
            if (!mDictionary) {
                mDictionary = [[NSMutableDictionary alloc] init];
            }
            [mDictionary setValue:_textFieldPassword.text forKey:_textFieldName.text];
            [mDictionary writeToFile:path atomically:NO];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码长度不能少于6位或大于18位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"重新输入", nil];
            //设置不同的样式
            alter.alertViewStyle = UIAlertViewStyleDefault;
            [alter show];
        }
    } else {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账号或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"重新输入", nil];
        //设置不同的样式
        alter.alertViewStyle = UIAlertViewStyleDefault;
        [alter show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
