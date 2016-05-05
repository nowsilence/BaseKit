//
//  UIView+Frame.m
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    
    rect.origin.x = x;
    
    self.frame = rect;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}


- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    
    rect.origin.y = y;
    
    self.frame = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}


- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    
    rect.size.width = width;
}

- (CGFloat)width
{
    return self.frame.size.width;
}


- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    
    rect.size.height = height;
    
    self.frame = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


- (void)setMaxX:(CGFloat)maxX
{
    CGRect rect = self.frame;
    
    rect.origin.x = maxX - rect.size.width;
    
    self.frame = rect;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    CGRect rect = self.frame;
    
    rect.origin.y = maxY - rect.size.height;
    
    self.frame = rect;
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    
    rect.size = size;
    
    self.frame = rect;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setX:(float)x y:(float)y
{
    CGRect rect = self.frame;

    rect.origin.x = x;
    
    rect.origin.y = y;
}

- (void)setAnchorPoint:(CGPoint)anchorPoint
{
    CGPoint anchor = CGPointMake(anchorPoint.x / self.frame.size.width,
                                 anchorPoint.y / self.frame.size.height);
    
    CGPoint oldOrigin = self.frame.origin;
    
    self.layer.anchorPoint = anchor;
    
    CGPoint newOrigin = self.frame.origin;
    
    CGPoint transition;
    
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    self.center = CGPointMake (self.center.x - transition.x,
                               self.center.y - transition.y);

}

- (CGPoint)anchorPoint
{
    CGPoint anchor = self.layer.anchorPoint;
    
    return CGPointMake(anchor.x * self.frame.size.width, anchor.y * self.frame.size.height);
}
@end
