//
//  ChatDemoHelper.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/11.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMMainTabBarViewController.h"
#import "XLCoversationViewController.h"
#import "XLAddressViewController.h"
#import "XLSettingViewController.h"

@interface ChatDemoHelper : NSObject<IEMContactManager>

@property (nonatomic, weak) XLAddressViewController *contactViewVC;

@property (nonatomic, weak) XLCoversationViewController *conversationListVC;

@property (nonatomic, weak) CMMainTabBarViewController *mainVC;

+ (instancetype)shareHelper;

- (void)asyncConversationFromDB;

- (void)asyncGroupFromServer;

@end
