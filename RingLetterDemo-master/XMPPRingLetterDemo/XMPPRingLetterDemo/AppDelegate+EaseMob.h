//
//  AppDelegate+EaseMob.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 17/1/5.
//  Copyright © 2017年 李保东. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (EaseMob)

/**
 *  本类中做了EaseMob初始化和推送等操作
 */

- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
               otherConfig:(NSDictionary *)otherConfig;

- (void)easemobApplication:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end
