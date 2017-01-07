//
//  CMMainTabBarViewController.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UserNotifications/UserNotifications.h>


@interface CMMainTabBarViewController : UITabBarController

// 统计未读消息数
-(void)setupUnreadMessageCount;

// 跳到聊天界面
- (void)jumpToChatList;

// 收到本地的通知
- (void)didReceiveLocalNotification:(UILocalNotification *)notification;
// 收到通知（iOS10专用）
- (void)didReceiveUserNotification:(UNNotification *)notification;


@end
