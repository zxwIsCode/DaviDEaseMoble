//
//  ContactViewController.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/12.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactViewController : EaseUsersListViewController

// 好友的请求变化，更新好友处理数目（给ChatDemoHelper等通知协调类调用）
-(void)reloadApplyView;
@end
