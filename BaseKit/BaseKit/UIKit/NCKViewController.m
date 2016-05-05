//
//  NCKViewController.m
//  BaseKit
//
//  Created by Kevin Chou on 16/3/14.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import "NCKViewController.h"

@implementation NCKViewController


#pragma mark 旋转控制

-(NSUInteger)supportedInterfaceOrientations
{
    //    [self setMyLayout];
    return UIInterfaceOrientationMaskPortrait;
}

/**
 *  这个方法在写在viewcontroller中，在视图出现之前调用。需要注意一个地方，
 *  如果这个viewcontroller是navigationcontroller容器中的，它将永远不会被调用，
 *  只会调用navigationcontroller中的-(BOOL)shouldAutorotate。
 */
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    //    [self setMyLayout];//检测到旋转时就会被调用
}

/**
 *  为了兼容IOS6以前的版本而保留的方法
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIDeviceOrientationPortrait);
    //    return YES;//即在IOS6.0以下版本，支持所用方向的旋屏
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma clang diagnostic pop


- (void)dealloc
{
#ifdef NCKDegbug
    NSLog(@"%@ dealloc",[self class]);
#endif
}
 
@end
