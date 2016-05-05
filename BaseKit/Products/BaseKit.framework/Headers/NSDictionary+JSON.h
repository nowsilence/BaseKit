//
//  NSDictionary+JSON.h
//  BaseKit
//
//  Created by Nigel Chou on 15/11/8.
//  Copyright (c) 2015年 BeautyFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)

- (NSData *)JSONData;

- (NSData *)JSONDataPrettyPrinted;

- (NSString *)JSONStringPrettyPrinted;

- (NSString *)JSONString;

@end
