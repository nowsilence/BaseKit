//
//  NSDictionary+JSON.h
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

- (NSData *)nck_JSONData;

- (NSData *)nck_JSONDataPrettyPrinted;

- (NSString *)nck_JSONStringPrettyPrinted;

- (NSString *)nck_JSONString;

/**
 *@brief 如果为null，返回nil
 */
- (id)nck_objectForKey:(id)key;

@end
