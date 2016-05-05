//
//  NSData+JSON.m
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (id)nck_objectFromJSONData
{
    return [self nck_objectFromJSONDataWithOptions:kNilOptions];
}

- (id)nck_objectFromJSONDataWithOptions:(NSJSONReadingOptions)opt
{
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:self options:opt error:&error];
    
    if (error != nil) return nil;
    
    return result;
}
@end
