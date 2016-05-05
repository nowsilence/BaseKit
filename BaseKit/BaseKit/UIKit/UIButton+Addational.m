//
//  UIButton+Addational.m
//  BaseKit
//
//  Created by Nigel Chou on 15/11/9.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "UIButton+Addational.h"
#import "objc/runtime.h"

@implementation UIButton (Addational)

- (id)nck_additional {
    return objc_getAssociatedObject(self, @selector(nck_additional));
}

- (void)setNck_additional:(id)value {
    objc_setAssociatedObject(self, @selector(nck_additional), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
