//
//  NCKRefreshFooterView.m
//
//  Created by Nigel Chou on 16/3/21.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

#import "NCKRefreshFooterView.h"
#define nckFooterHeight 50

@interface NCKRefreshFooterView()

@property(nonatomic,weak) UIScrollView *scrollView;

@property(nonatomic) UIEdgeInsets scrollViewOriginalInset;

@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property(nonatomic,strong) UILabel *label;

@property(nonatomic) NCKRefreshState state;

@end

@implementation NCKRefreshFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.label];
        
        [self addSubview:self.indicatorView];
        
        UITapGestureRecognizer *tap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
        
        [self addGestureRecognizer:tap];
        
        [self setRefreshState:NCKRefreshStateIdle];
    }
    
    return self;
}

- (void)handleTap
{
    if (self.state == NCKRefreshStateErr) {
        
        if (self.loadMore) {
            
            [self setRefreshState:NCKRefreshStateLoading];
            
            self.loadMore();
        }
    }
}

- (void)setRefreshState:(NCKRefreshState)state
{
    self.state = state;
    
    if (state == NCKRefreshStateReloading) {
        
        self.hidden = YES;
        
        return;
    }
    
    self.hidden = NO;
    
    if(state == NCKRefreshStateLoading) {
        
        [self.indicatorView startAnimating];
    }
    else {
        
        [self.indicatorView stopAnimating];
    }
    
    NSDictionary *infoDict = [self infoDict];
    
    self.label.text = [infoDict objectForKey:@(state)];
    
    [self setNeedsLayout];
}

- (NSDictionary *)infoDict
{
    return @{@(NCKRefreshStateIdle):@"",
             @(NCKRefreshStateLoading):@"正在加载...",
             @(NCKRefreshStateNothing):@"加载的数据为空！",
             @(NCKRefreshStateNomore):@"没有更多数据！",
             @(NCKRefreshStateErr):@"加载失败，点击重新载入！"};
}

- (UILabel *)label
{
    if (_label) {
        
        return _label;
    }
    
    _label = [[UILabel alloc] init];
    
    _label.shadowColor = [UIColor whiteColor];
    
    _label.shadowOffset = CGSizeMake(0, 1);
    
    _label.font = [UIFont systemFontOfSize:13];
    
    _label.textColor = [UIColor grayColor];
    
    return _label;
}

- (UIActivityIndicatorView *)indicatorView
{
    if (_indicatorView) {
        
        return _indicatorView;
    }
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:2];
    
    return _indicatorView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.label sizeToFit];
    
    CGRect rect = self.label.frame;
    
    rect.size.height = nckFooterHeight;
    
    self.label.frame = rect;
    
    int x = (self.frame.size.width - rect.size.width - self.indicatorView.frame.size.width) / 2;
    
    rect = self.indicatorView.frame;
    
    rect.origin = CGPointMake(x - 10, (self.frame.size.height - self.indicatorView.frame.size.height) / 2);
    
    self.indicatorView.frame = rect;
    
    rect = self.label.frame;
    
    rect.origin.x = CGRectGetMaxX(self.indicatorView.frame) + 10;
    
    self.label.frame = rect;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if (self.state == NCKRefreshStateIdle) {
            
            
            if(self.frame.origin.y < _scrollView.contentOffset.y + _scrollView.frame.size.height)
            {
                if (self.loadMore) {
                    
                    [self setRefreshState:NCKRefreshStateLoading];
                    
                    self.loadMore();
                }
            }
        }
    }
    else if ([keyPath isEqualToString:@"contentSize"])
    {
        self.frame = CGRectMake(0, _scrollView.contentSize.height,
                                _scrollView.frame.size.width,
                                nckFooterHeight);
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    
    [self.superview removeObserver:self forKeyPath:@"contentSize" context:nil];

    if (newSuperview) {
        
        [newSuperview addObserver:self
                       forKeyPath:@"contentOffset"
                          options:NSKeyValueObservingOptionNew context:nil];
        
        [newSuperview addObserver:self
                       forKeyPath:@"contentSize"
                          options:NSKeyValueObservingOptionNew context:nil];
        
        _scrollView = (UIScrollView *)newSuperview;
        
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        int deltaH = _scrollView.contentSize.height - _scrollView.frame.size.height;
        
        self.frame = CGRectMake(0, _scrollView.contentSize.height,
                                _scrollView.frame.size.width,
                                nckFooterHeight);
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        int edgeBottom = nckFooterHeight;
        
        if (deltaH < nckFooterHeight) {
            
            edgeBottom = MAX(0, nckFooterHeight + deltaH);
        }
        
        UIEdgeInsets insets = UIEdgeInsetsMake(_scrollViewOriginalInset.top,
                                               _scrollViewOriginalInset.left,
                                               _scrollViewOriginalInset.bottom + edgeBottom,
                                               _scrollViewOriginalInset.right);
        _scrollView.contentInset = insets;
    }
}
@end
