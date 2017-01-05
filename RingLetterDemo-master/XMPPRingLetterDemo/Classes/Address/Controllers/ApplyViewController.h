//
//  ApplyViewController.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 17/1/5.
//  Copyright © 2017年 李保东. All rights reserved.
//  申请的同意或拒绝的好友或群的通知

#import <UIKit/UIKit.h>

typedef enum{
    ApplyStyleFriend            = 0,
    ApplyStyleGroupInvitation,
    ApplyStyleJoinGroup,
}ApplyStyle;

@interface ApplyViewController : UITableViewController
{
    NSMutableArray *_dataSource;
}
@property (strong, nonatomic, readonly) NSMutableArray *dataSource;

+ (instancetype)shareController;

- (void)loadDataSourceFromLocalDB;


@end
