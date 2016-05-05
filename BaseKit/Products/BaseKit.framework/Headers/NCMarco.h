//
//  NCMarco.h
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STRING_INT(int) [NSString stringWithFormat:@"%d",int]

#define NUM_INT(int) [NSNumber numberWithInt:int]

#define NUM_FLOAT(float) [NSNumber numberWithFloat:float]

#define NUM_BOOL(bool) [NSNumber numberWithBool:bool]

#define NCString(string) (string == nil ? @"" : string)

#define NilObject(obj) (obj == nil ? [NSNull null] : obj)

