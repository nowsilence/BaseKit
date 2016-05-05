//
//  NSArray+JSON.h
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JSON)

- (NSString *)nck_JSONString;

- (NSString *)nck_JSONStringPrettyPrinted;

- (NSData *)nck_JSONData;

- (NSData *)nck_JSONDataPrettyPrinted;

@end
