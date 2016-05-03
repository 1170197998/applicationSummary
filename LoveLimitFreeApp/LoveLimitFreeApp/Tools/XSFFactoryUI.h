//
//  XSFFactoryUI.h
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XSFFactoryUI : NSObject

/**
 *  创建UIView
 */
+ (UIView *)creatViewWithFrame:(CGRect )frame;

/**
 *  创建UILabel
 */
+ (UILabel *)creatLabelWithFrame:(CGRect )frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

/**
 *  创建UIButton
 */
+ (UIButton *)creatButtonWithFrame:(CGRect )frame title:(NSString *)title imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector;

/**
 *  创建UIImageName
 */
+ (UIImageView *)creatImageViewWithFrame:(CGRect )frame imageName:(NSString *)imageName;


@end
