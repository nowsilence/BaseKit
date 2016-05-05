//
//  NSDictionary+JSON.m
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)

- (NSString *)nck_JSONString
{
    NSData *jsonData = [self nck_JSONData];
    
    if (!jsonData) return @"";
    
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return json;
}

- (NSString *)nck_JSONStringPrettyPrinted
{
    NSData *jsonData = [self nck_JSONDataWithOptions:NSJSONWritingPrettyPrinted];
    
    if (!jsonData) return @"";
    
    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return json;
}

- (NSData *)nck_JSONDataPrettyPrinted
{
    return [self nck_JSONDataWithOptions:NSJSONWritingPrettyPrinted];
}

- (NSData *)nck_JSONData
{
    return [self nck_JSONDataWithOptions:0];
}

- (NSData *)nck_JSONDataWithOptions:(NSJSONWritingOptions)option
{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:option
                                                         error:&error];
    if (error) return nil;
    
    return jsonData;
}

- (id)nck_objectForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == [NSNull null]) return nil;
    
    return object;
}


@end
