//
//  ChatDemoHelper.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 17/1/5.
//  Copyright © 2017年 李保东. All rights reserved.
//  整体调控所有登录或者各个其他模块的收发信息和处理

#import <Foundation/Foundation.h>
#import "XLAddressViewController.h"
#import "XLCoversationViewController.h"
#import "XLAddressViewController.h"
#import "XLDiscoverViewController.h"
#import "XLSettingViewController.h"
#import "CMMainTabBarViewController.h"
#import "ChatViewController.h"

@interface ChatDemoHelper : NSObject<EMClientDelegate,EMChatManagerDelegate,EMContactManagerDelegate,EMGroupManagerDelegate,EMChatroomManagerDelegate>

@property (nonatomic, weak) XLAddressViewController *contactViewVC;

@property (nonatomic, weak) XLCoversationViewController *conversationListVC;

@property (nonatomic, weak) CMMainTabBarViewController *mainVC;

@property (nonatomic, weak) ChatViewController *chatVC;

+ (instancetype)shareHelper;

- (void)asyncPushOptions;

- (void)asyncGroupFromServer;

- (void)asyncConversationFromDB;

@end
