//
//  XSFAccountNumberVC.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFAccountNumberVC.h"
#import "XSFRegisterViewController.h"
@interface XSFAccountNumberVC ()
{
    UITextField *_textFieldName;
    UITextField *_textFieldPassword;
}
@end

@implementation XSFAccountNumberVC

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
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"详情返回"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
}

- (void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    CGFloat buttonW = 40;
    CGFloat buttonH = 30;
    UIButton *buttonRegister = [[UIButton alloc] initWithFrame:CGRectMake((SCR_W - 2 * buttonW) / 3, _textFieldPassword.frame.origin.y + 50, buttonW, buttonH)];
    [buttonRegister setTitle:@"注册" forState:UIControlStateNormal];
    [buttonRegister setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonRegister addTarget:self action:@selector(clickRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRegister];
    
    
    UIButton *ButtonEnter = [[UIButton alloc] initWithFrame:CGRectMake(((SCR_W -  2 * buttonW) / 3) * 2 + buttonW, _textFieldPassword.frame.origin.y + 50, buttonW, buttonH)];
    [ButtonEnter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ButtonEnter setTitle:@"登录" forState:UIControlStateNormal];
    [ButtonEnter addTarget:self action:@selector(clickEnter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ButtonEnter];
}

#pragma mark - 注册按钮
- (void)clickRegister
{
    XSFRegisterViewController *registerVC = [[XSFRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - 登录按钮
- (void)clickEnter
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/userInfo.plist",NSHomeDirectory()];
    NSDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    //所有注册账户
    NSArray *arrayOfKey = [dictionary allKeys];
    
    for (NSInteger i = 0; i < arrayOfKey.count; i ++) {
        
        if ([_textFieldName.text isEqualToString: arrayOfKey[i]]) {
            
            if ([_textFieldPassword.text isEqualToString:dictionary[_textFieldName.text]]) {
                
                NSLog(@"登录成功");
            } else {
                UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码输入错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"重新输入", nil];
                [alter show];
                break;
            }
        } else {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该账户没有注册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"重新输入", nil];
            [alter show];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
