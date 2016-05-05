//
//  NCKRefreshHeaderView.m
//  BaseKit
//
//  Created by Nigel Chou on 16/3/21.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

#import "NCKRefreshHeaderView.h"

#define nckHeaderHeight 50

@interface NCKRefreshHeaderView()

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic) UIEdgeInsets scrollViewOriginalInset;

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property(nonatomic) NCKRefreshState state;

@end

@implementation NCKRefreshHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
    
        [self addSubview:self.label];
        
        [self addSubview:self.indicatorView];
        
        [self setRefreshState:NCKRefreshStateIdle];
    }
    
    return self;
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

- (void)setRefreshState:(NCKRefreshState)state
{
    self.state = state;
    
    [self.indicatorView stopAnimating];
    
    if (state == NCKRefreshStateReloading) {
        
        self.label.text = @"加载中...";
        
        UIEdgeInsets insets = UIEdgeInsetsMake(_scrollViewOriginalInset.top + nckHeaderHeight,
                                               _scrollViewOriginalInset.left,
                                               _scrollViewOriginalInset.bottom,
                                               _scrollViewOriginalInset.right);
        
        [UIView animateWithDuration:.25 animations:^{

            self.scrollView.contentInset = insets;
        }];
        
        [self.indicatorView startAnimating];
    }
    else {
        
        self.label.text = @"下拉刷新.....";
        
        [UIView animateWithDuration:.25 animations:^{
            
            self.scrollView.contentInset = self.scrollViewOriginalInset;
        }];
    }
    
    [self setNeedsLayout];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if (self.state != NCKRefreshStateReloading) {
            
            if(nckHeaderHeight < ABS(_scrollView.contentOffset.y))
            {
                if (self.scrollView.isDragging) {
                    
                    self.label.text = @"松开立即刷新.....";
                    
                    [self setNeedsLayout];
                }
                else if(self.reloadBlock)
                {
                    [self setRefreshState:NCKRefreshStateReloading];
                    
                    self.reloadBlock();
                }
            }
        }
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:nil];
    
    
    if (newSuperview) {
        
        [newSuperview addObserver:self
                       forKeyPath:@"contentOffset"
                          options:NSKeyValueObservingOptionNew context:nil];
        
        _scrollView = (UIScrollView *)newSuperview;
        
        _scrollViewOriginalInset = _scrollView.contentInset;
        
        self.frame = CGRectMake(0, 0, _scrollView.frame.size.width, -nckHeaderHeight);
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.label sizeToFit];
    
    CGRect rect = self.label.frame;
    
    rect.size.height = nckHeaderHeight;
    
    self.label.frame = rect;
    
    int x = (self.frame.size.width - rect.size.width - self.indicatorView.frame.size.width) / 2;
    
    rect = self.indicatorView.frame;
    
    rect.origin = CGPointMake(x - 10, (self.frame.size.height - self.indicatorView.frame.size.height) / 2);
    
    self.indicatorView.frame = rect;
    
    rect = self.label.frame;
    
    rect.origin.x = CGRectGetMaxX(self.indicatorView.frame) + 10;
    
    self.label.frame = rect;
}
@end
