//
//  AppDelegate.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/10/29.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "XSFMainViewController.h"
#import "XSFCommendViewController.h"
#import "XSFCategoryViewController.h"
#import "XSFTopicViewController.h"
#import "XSFMoreViewController.h"

//#import "UMSocial.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"  //支持微信
#import "TencentOpenAPI/QQApiInterface.h"  	//支持qq
#import "TencentOpenAPI/TencentOAuth.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    XSFCommendViewController *commendVC = [[XSFCommendViewController alloc] init];
    //把commendVC包装UINavigationController是为了放置搜索框
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:commendVC];
    nav.navigationBar.barTintColor = [UIColor blueColor];
    XSFCategoryViewController *freeVC = [[XSFCategoryViewController alloc] init];
    XSFTopicViewController *topicVC = [[XSFTopicViewController alloc] init];
    XSFMoreViewController *moreVC = [[XSFMoreViewController alloc] init];
    XSFMainViewController *mainVC = [[XSFMainViewController alloc] init];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainVC.arrayWithViewController  = @[nav,freeVC,topicVC,moreVC];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    
    
    //注册友盟分享
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    
    //设置微信的appid,如果url为空,则默认支持友盟的官网
    [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:nil];
    
    //设置QQ的appid  和 所支持的类
    [UMSocialConfig setQQAppId:@"100424468" url:nil importClasses:@[[TencentOAuth class]]];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
