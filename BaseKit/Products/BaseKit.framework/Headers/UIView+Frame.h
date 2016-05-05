//
//  UIView+Frame.h
//  BaseKit
//
//  Created by Nigel on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NCR(x,y,width,height) CGRectMake(x, y, width, height)

#define NCPS(point,size) CGRectMake(point.x, point.y, size.width, size.height)

#define NCXYS(x,y,size) CGRectMake(x,y,size.width,size.height)

#define NCP(x,y) CGPointMake(x,y)

#define NCS(width,height) CGSizeMake(width,height)


@interface UIView (Frame)

@property(nonatomic) CGFloat x;

@property(nonatomic) CGFloat y;

@property(nonatomic) CGFloat width;

@property(nonatomic) CGFloat  height;

@property(nonatomic) CGSize size;

@property(nonatomic) CGFloat maxX;

@property(nonatomic) CGFloat maxY;

/**
 *  像素坐标
 */
@property(nonatomic) CGPoint anchorPoint;

@end
