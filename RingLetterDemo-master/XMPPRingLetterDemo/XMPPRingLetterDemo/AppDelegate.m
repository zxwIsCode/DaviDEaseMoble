//
//  AppDelegate.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/11.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "AppDelegate.h"
//#import "EMSDK.h"
#import "RegisterViewController.h"
#import "ToobarHelper.h"
#import "MainViewController.h"
#import "IQKeyboardManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"1148161111115607#xmppringletterdemo"];
//    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    // 推送类UNUserNotificationCenter（iOS 10专用）存在的话，就设置推送的代理为Application
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    
    [self settingKeyboardAuto];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if ([XMUserDefaults getsBoolFromLocal:isFirstLogin]) {
//        self.window.rootViewController =[[MainViewController alloc]init];
        [ToobarHelper choseAllRootViewControllersisTabBar:YES andWindow:self.window];
//        [XMUserDefaults saveBoolToLoacl:isFirstLogin andBool:NO];

    }else {
//        self.window.rootViewController =[[RegisterViewController alloc]init];

        [ToobarHelper choseAllRootViewControllersisTabBar:NO andWindow:self.window];
//        [XMUserDefaults saveBoolToLoacl:isFirstLogin andBool:YES];

    }
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}
-(void)settingKeyboardAuto {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; // 控制整个功能是否启用。
    manager.shouldResignOnTouchOutside =YES; // 控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor =YES; // 控制键盘上的工具条文字颜色是否用户自定义
    manager.enableAutoToolbar =YES; // 控制是否显示键盘上的工具条
    manager.toolbarManageBehaviour =IQAutoToolbarByTag; // 最新版的设置键盘的returnKey的关键字 ,可以点击键盘上的next键，自动跳转到下一个输入框，最后一个输入框点击完成，自动收起键盘。
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

@end
