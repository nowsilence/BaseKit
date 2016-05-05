//
//  UIApplication+Custom.m
//  BaseKit
//
//  Created by Kevin Chou on 16/3/5.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import "UIApplication+Custom.h"

@implementation UIApplication (Custom)

/*
Swizzle([UIApplication class], @selector(sendEvent:), @selector(mySendEvent:))

void Swizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}

- (void)mySendEvent:(UIEvent*)event {
    //handle the event (you will probably just reset a timer)
    
    [self mySendEvent:event];
}
*/
@end
