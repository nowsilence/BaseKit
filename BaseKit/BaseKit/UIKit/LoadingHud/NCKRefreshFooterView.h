//
//  NCKRefreshFooterView.h
//  BaseKit
//
//  Created by Nigel Chou on 16/3/21.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+Loading.h"

@interface NCKRefreshFooterView : UIView

@property(nonatomic,copy) void(^loadMore)(void);

- (void)setRefreshState:(NCKRefreshState)state;

@end
