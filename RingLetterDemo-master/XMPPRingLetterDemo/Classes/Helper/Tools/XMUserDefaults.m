//
//  XMUserDefaults.m
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/12.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "XMUserDefaults.h"

@implementation XMUserDefaults



+(void)saveBoolToLoacl:(NSString *)key andBool:(BOOL)isYes {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setBool:isYes forKey:key];
    [defaults synchronize];
}

+(BOOL *)getsBoolFromLocal:(NSString *)key {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    return[defaults boolForKey:key];
}

@end
