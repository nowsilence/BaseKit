//
//  NSString+JSON.m
//  BaseKit
//
//  Created by Nigel on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

- (id)nck_objectFromJSONString
{
    return [self nck_objectFromJSONStringWithOptions:kNilOptions];
}

- (id)nck_objectFromJSONStringWithOptions:(NSJSONReadingOptions)opt
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:opt error:&error];
    
    if (error != nil) return nil;
    
    return result;
}
@end
