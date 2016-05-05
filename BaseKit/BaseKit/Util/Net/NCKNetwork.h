//
//  NetHelper.h
//  SensorApi
//
//  Created by Nigel Chou on 16/1/13.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetRequest;

@interface NCKNetwork : NSObject

- (void)postWithURL:(NSString *)url parameter:(NSDictionary *)param target:(id)target selector:(SEL)selector;

- (void)postWithRequest:(NetRequest *)request;

- (NSData *)postWithURL:(NSString *)url parameter:(NSDictionary *)param;

- (void)cancelWithRequest:(NetRequest *)request;

- (void)cancelWithTarget:(id)target;

+ (NCKNetwork *)shareInstance;

@end


@interface NCKNetRequest : NSObject

@property(nonatomic) SEL finishSelector;

@property(nonatomic) SEL failureSelector;

@property(nonatomic,weak) id target;

@property(nonatomic,copy) NSString *url;

@property(nonatomic,copy) NSDictionary *parameter;

@property(nonatomic,readonly) NSData *responseData;

@property(nonatomic,readonly) NSError *err;

+ (NCKNetRequest *)requestWithUrl:(NSString *)url
                           target:(id)target
                   finishSelector:(SEL)finishSelector
                  failureSelector:(SEL)failureSelector;
@end