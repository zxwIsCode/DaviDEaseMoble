//
//  ChatDemoHelper.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 17/1/5.
//  Copyright © 2017年 李保东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLAddressViewController.h"
#import "XLCoversationViewController.h"
#import "XLAddressViewController.h"
#import "XLDiscoverViewController.h"
#import "XLSettingViewController.h"
#import "CMMainTabBarViewController.h"

@interface ChatDemoHelper : NSObject

@property (nonatomic, weak) XLAddressViewController *contactViewVC;

@property (nonatomic, weak) XLCoversationViewController *conversationListVC;

@property (nonatomic, weak) CMMainTabBarViewController *mainVC;

//@property (nonatomic, weak) ChatViewController *chatVC;

+ (instancetype)shareHelper;

- (void)asyncPushOptions;

- (void)asyncGroupFromServer;

- (void)asyncConversationFromDB;

@end
