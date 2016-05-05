//
//  UIScrollView+Loading.m
//  BaseKit
//
//  Created by Nigel Chou on 16/3/21.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

#import "UIScrollView+Loading.h"
#import "NCKRefreshFooterView.h"
#import "NCKRefreshHeaderView.h"
#import <objc/runtime.h>

@implementation UIScrollView (Loading)

static char NCKRefreshHeaderViewKey;
static char NCKRefreshFooterViewKey;

- (void)setHeader:(NCKRefreshHeaderView *)header {
    [self willChangeValueForKey:@"NCKRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &NCKRefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"NCKRefreshHeaderViewKey"];
}

- (NCKRefreshHeaderView *)header {
    return objc_getAssociatedObject(self, &NCKRefreshHeaderViewKey);
}

- (void)setFooter:(NCKRefreshFooterView *)footer {
    
    objc_setAssociatedObject(self, &NCKRefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
}

- (NCKRefreshFooterView *)footer {
    return objc_getAssociatedObject(self, &NCKRefreshFooterViewKey);
}

- (void)nck_setRefreshState:(NCKRefreshState)state
{
    NCKRefreshFooterView *footer = [self footer];
    
    NCKRefreshHeaderView *header = [self header];
    
    if(footer) [footer setRefreshState:state];
    
    if (header) {
        
        [header setRefreshState:state];
    }
}

- (void)nck_addFooterPullHandler:(void (^)(void))loadMoreHandler
{
    if (![self footer]) {
        
        NCKRefreshFooterView *footer = [[NCKRefreshFooterView alloc] init];
        
        [self setFooter:footer];
        
        [self addSubview:footer];
    }
    
    [self footer].loadMore = loadMoreHandler;

}

- (void)nck_addHeaderPullHandler:(void (^)(void))reloadBlock
{
    if (![self header]) {
        
        NCKRefreshHeaderView *header = [[NCKRefreshHeaderView alloc] init];
        
        [self setHeader:header];
        
        [self addSubview:header];
    }
    
    [self header].reloadBlock = reloadBlock;

}
@end
