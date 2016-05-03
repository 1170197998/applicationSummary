//
//  XSFFactoryUI.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFFactoryUI.h"

@implementation XSFFactoryUI

/**
 *  创建UIView
 */
+ (UIView *)creatViewWithFrame:(CGRect )frame
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    return view;
}

/**
 *  创建UILabel
 */
+ (UILabel *)creatLabelWithFrame:(CGRect )frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}

/**
 *  创建UIButton
 */
+ (UIButton *)creatButtonWithFrame:(CGRect )frame title:(NSString *)title imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector
{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/**
 *  创建UIImageName
 */
+ (UIImageView *)creatImageViewWithFrame:(CGRect )frame imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}

@end
