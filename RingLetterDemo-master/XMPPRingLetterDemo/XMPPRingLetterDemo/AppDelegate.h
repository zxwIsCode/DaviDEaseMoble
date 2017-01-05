//
//  AppDelegate.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/11.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMMainTabBarViewController.h"
#import "EMSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
// 网络连接状态
{
    EMConnectionState _connectionState;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)CMMainTabBarViewController *mainController;

@end

