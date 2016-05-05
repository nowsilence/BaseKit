//
//  UIViewController+BackButton.h
//  BaseKit
//
//  Created by Nigel Chou on 15/12/13.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BackButtonProtocol <NSObject>
@optional

-(BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (BackButton) <BackButtonProtocol>

@end
