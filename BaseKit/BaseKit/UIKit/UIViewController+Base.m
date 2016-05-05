//
//  UIViewController+Base.m
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "UIViewController+Base.h"

@implementation UIViewController (Base)
/*
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidLoad:);
        SEL swizzledSelector = @selector(nc_viewDidLoad:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
       
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)nc_viewDidLoad:(BOOL)animated {
    [self nc_viewDidLoad:animated];
}
*/
- (void)nck_setLeftButton:(UIButton *)button
{
    if (!button)
    {
        self.navigationItem.leftBarButtonItems = nil;
        self.navigationItem.leftBarButtonItem = nil;
        
        return;
    }
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        negativeSeperator.width = -16;
        
        [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, leftBarButtonItem]];
    }
    else
    {
        [self.navigationItem setLeftBarButtonItem:leftBarButtonItem animated:NO];
    }
}

- (void)nck_setRightButton:(UIButton *)button
{
    if (!button)
    {
        self.navigationItem.rightBarButtonItems = nil;
        self.navigationItem.rightBarButtonItem = nil;
        
        return;
    }
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        negativeSeperator.width = -16;
        
        [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightBarButtonItem]];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:rightBarButtonItem animated:NO];
    }
}


/**
 *  不可覆盖，会crash，
 *
- (void)dealloc
{
    if(kBaseDebug) NSLog(@"%@ dealloc",[self class]);

    [self clearRequest];
}
*/
@end
