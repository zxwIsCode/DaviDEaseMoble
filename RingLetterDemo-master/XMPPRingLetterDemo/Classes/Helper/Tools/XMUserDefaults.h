//
//  XMUserDefaults.h
//  XMPPRingLetterDemo
//
//  Created by 李保东 on 16/11/12.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMUserDefaults : NSUserDefaults

+(void)saveBoolToLoacl:(NSString *)key andBool:(BOOL)isYes;

+(BOOL *)getsBoolFromLocal:(NSString *)key;



@end
