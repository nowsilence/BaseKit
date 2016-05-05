//
//  UIViewController+Base.h
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Base)

/**
 *  @breif navigationItem 添加右按钮 对右边距进行处理
 */
- (void)nck_setRightButton:(UIButton *)button;

/**
 *  @breif navigationItem 添加左按钮 对左边距进行处理
 */
- (void)nck_setLeftButton:(UIButton *)button;

/**
 *  @breif 在当前view上显示一个文本信息
 *  @param text 要显示的文本信息
 */
- (void)nck_showToast:(NSString *)text;

/**
 *  @breif 在当前view上显示一个文本信息，延迟消失
 *  @param text  要显示的文本信息
 *  @param delay 延迟消失时间
 */
- (void)nck_showToast:(NSString *)text delay:(float)delay;

/**
 *  @breif 在当前view上显示一个文本信息，消失后执行一个block
 *  @param text  要显示的文本信息
 *  @param completionBlock 消失后执行的block
 */
- (void)nck_showToast:(NSString *)text completionBlock:(void (^)(void))completionBlock;

/**
 *  @breif 隐藏hud指示器
 */
- (void)nck_hideHud;

/**
 *  @breif 显示hud指示器，连接网络时使用
 *  @param text 要显示的信息
 */
- (void)nck_showNetHud:(NSString *)text;

/**
 *  b开头的是使用大视图
 */
- (void)nck_bshowNetHud:(NSString *)text;

- (void)nck_bshowToastErr:(NSString *)text;

- (void)nck_bshowToastInfo:(NSString *)text;

- (void)nck_bshowToastSuc:(NSString *)text completionBlock:(void (^)(void))completionBlock;


/**
 *  @breif 清除所有网络请求，delloc是默认调用
 */
- (void)nck_clearRequest;

@end
