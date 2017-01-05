//
//  ChatDemoHelper.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/11.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "ConversationViewController.h"
#import "ContactViewController.h"
#import "SettingViewController.h"

@interface ChatDemoHelper : NSObject<IEMContactManager>

@property (nonatomic, weak) ContactViewController *contactViewVC;

@property (nonatomic, weak) ConversationViewController *conversationListVC;

@property (nonatomic, weak) MainViewController *mainVC;

+ (instancetype)shareHelper;

- (void)asyncConversationFromDB;

- (void)asyncGroupFromServer;

@end
