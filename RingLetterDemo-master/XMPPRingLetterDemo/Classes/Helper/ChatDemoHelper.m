//
//  ChatDemoHelper.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/11.
//  Copyright © 2016年 李保东. All rights reserved.
// 该类目前是一个注册监听所有的请求如（添加好友，群组的通知等）

#import "ChatDemoHelper.h"


@interface ChatDemoHelper ()



@end

@implementation ChatDemoHelper

#pragma mark - Init

-(instancetype)init {
    if (self =[super init]) {
        [self initHelper];
    }
    return self;
}
+ (instancetype)shareHelper
{
    static ChatDemoHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ChatDemoHelper alloc] init];
    });
    return helper;
}
-(void)dealloc {
    
    [[EMClient sharedClient].contactManager removeDelegate:self];
    [[EMClient sharedClient].contactManager removeDelegate:self];

}

#pragma mark - Private Methods
// 注册监听通知的代理（如有人添加好友，群组等）
-(void)initHelper {
    
//    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
//    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    [[EMClient sharedClient]addDelegate:self];
    [[EMClient sharedClient].contactManager addDelegate:self];
    
}

#pragma mark - Async Frome Local Data

- (void)asyncGroupFromServer
{
//    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient].groupManager getJoinedGroups];
        EMError *error = nil;
        [[EMClient sharedClient].groupManager getMyGroupsFromServerWithError:&error];
//        if (!error) {
//            if (weakself.contactViewVC) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakself.contactViewVC reloadGroupView];
//                });
//            }
//        }
    });
}

- (void)asyncConversationFromDB
{
//    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = [[EMClient sharedClient].chatManager getAllConversations];
        [array enumerateObjectsUsingBlock:^(EMConversation *conversation, NSUInteger idx, BOOL *stop){
            if(conversation.latestMessage == nil){
                [[EMClient sharedClient].chatManager deleteConversation:conversation.conversationId isDeleteMessages:NO completion:nil];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
//            if (weakself.conversationListVC) {
//                [weakself.conversationListVC refreshDataSource];
//            }
//            
//            if (weakself.mainVC) {
//                [weakself.mainVC setupUnreadMessageCount];
//            }
        });
    });
}

#pragma mark -IEMContactManager Delegate

/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage {
    if (!aUsername) {
        return;
    }
    if (!aMessage) {
        aMessage =[NSString stringWithFormat:@"%@ 想添加您为好友!",aMessage];
        return;
    }
    // 添加到个人申请列表中（由专门的类处理）
    
    // 设置为未读消息
    
    // 播放音乐并且响铃
    
    BOOL isAcitivity =[[UIApplication sharedApplication]applicationState] ==UIApplicationStateActive;

    if (!isAcitivity) {// 非活跃状态
        //    发送本地通知
        if (NSClassFromString(@"UNUserNotificationCenter")) {// iOS 10新推出的推送类
//            UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.01 repeats:NO];
//            UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
//            content.sound = [UNNotificationSound defaultSound];
//            content.body =aMessage;
//            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:[[NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate] * 1000] stringValue] content:content trigger:trigger];
//            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
        }else {
            
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [NSDate date]; //触发通知的时间
            notification.alertBody = aMessage;
            notification.alertAction = @"打开";
            notification.timeZone = [NSTimeZone defaultTimeZone];
        }
    }
    // 刷新对应的界面的View
    [self.contactViewVC reloadApplyView];
}
/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B同意后，用户A会收到这个回调
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername {

}

/*!
 *  \~chinese
 *  用户B同意用户A的好友申请后，用户A和用户B都会收到这个回调
 *
 *  @param aUsername   用户好友关系的另一方
 *
 *  \~english
 *  Both user A and B will receive this callback after User B agreed user A's add-friend invitation
 *
 */
- (void)didReceiveAddedFromUsername:(NSString *)aUsername __deprecated_msg("Use -friendshipDidAddByUser:") {

}

/*!
 @method
 @brief 用户A发送加用户B为好友的申请，用户B拒绝后，用户A会收到这个回调
 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername {

}


@end
