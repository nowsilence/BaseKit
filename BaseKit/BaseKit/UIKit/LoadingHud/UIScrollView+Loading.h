//
//  UIScrollView+Loading.h
//  BaseKit
//
//  Created by Nigel Chou on 16/3/21.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NCKRefreshState) {
    
    NCKRefreshStateIdle          = 0,    /// 等待加载
    NCKRefreshStateLoading       = 1,    /// 加载中
    NCKRefreshStateReloading     = 2,    /// 重载重
    NCKRefreshStateNothing       = 3,    /// 没有数据
    NCKRefreshStateNomore        = 4,    /// 没有更多数据
    NCKRefreshStateErr           = 5     /// 加载错误
    
};

@interface UIScrollView (Loading)

- (void)nck_setRefreshState:(NCKRefreshState)state;

- (void)nck_addFooterPullHandler:(void (^)(void))loadMoreHandler;

- (void)nck_addHeaderPullHandler:(void (^)(void))reloadBlock;

@end
