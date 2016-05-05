//
//  UIViewController+BackButton.m
//  BaseKit
//
//  Created by Kevin Chou on 15/12/13.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "UIViewController+BackButton.h"

@implementation UIViewController (BackButton)

@end

@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    
    UIViewController* vc = [self topViewController];
    
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
        shouldPop = [vc navigationShouldPopOnBackButton];
    }
    
    if(shouldPop)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    }
    else
    {
        // Workaround for iOS7.1.
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
}

@end