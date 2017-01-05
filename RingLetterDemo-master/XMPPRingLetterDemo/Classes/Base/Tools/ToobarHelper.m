//
//  ToobarHelper.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/12.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "ToobarHelper.h"
#import "MainViewController.h"
#import "RegisterViewController.h"
#import "ChatDemoHelper.h"
@implementation ToobarHelper

+(void)choseAllRootViewControllersisTabBar:(BOOL)isMain andWindow:(UIWindow *)window {
    if (isMain) {
        MainViewController *main =[[MainViewController alloc]init];
        [ChatDemoHelper shareHelper].mainVC;
          window.rootViewController =main;
    }else {
        [ChatDemoHelper shareHelper].mainVC =nil;
        window.rootViewController =[[RegisterViewController alloc]init];
    }
  
}

@end