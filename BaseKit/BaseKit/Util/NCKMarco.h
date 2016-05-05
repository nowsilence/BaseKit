//
//  NCKMarco.h
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NCKDegbug //如果不需要调试信息，注释本行

#define STRING_INT(int) [NSString stringWithFormat:@"%d",int]

#define NCString(string) (string == nil ? @"" : string)

#define NilObject(obj) (obj == nil ? [NSNull null] : obj)




#define nckPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)