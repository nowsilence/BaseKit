//
//  UIWindow+Crash.m
//  BaseKit
//
//  Created by Kevin Chou on 16/3/5.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import "UIWindow+Crash.h"

@implementation UIWindow (Crash)
/*
- (void)makeKeyAndVisible{
   
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    
    BOOL exit=FALSE;
    
    if (keywindow!=Nil) {
    
        exit=TRUE;
    }
    
    [self makeKeyWindow];
    
    self.hidden=FALSE;
    
    if (!exit) {
        
        NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    }
}
*/

void UncaughtExceptionHandler(NSException *exception) {
    /**
     *  获取异常崩溃信息
     */
    NSArray *callStack = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *content = [NSString stringWithFormat:@"========异常错误报告========\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",name,reason,[callStack componentsJoinedByString:@"\n"]];
    
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:test@qq.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", content];
    // 打开地址
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
}
@end
