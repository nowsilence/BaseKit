//
//  NetHelper.m
//  SensorApi
//
//  Created by Nigel Chou on 16/1/13.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import "NCKNetwork.h"
#import "objc/runtime.h"
#import "NSURLSession+SynchronousTask.h"
#import "NCKMarco.h"

@interface NCKNetRequest()
{
    NSMutableData *_responseData;
    
}

@property(nonatomic,strong) NSError *err;

- (void)appendResponseData:(NSData *)data;

@end

@interface NSURLSessionTask(NetRequest)

@property(nonatomic,weak) NCKNetRequest *nc_request;

@end

@implementation NSURLSessionTask(Request)

- (id)nck_request {
    return objc_getAssociatedObject(self, @selector(nc_request));
}

- (void)setNck_Request:(id)request{
    objc_setAssociatedObject(self, @selector(nc_request), request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface NCKNetwork()<NSURLSessionDataDelegate>
{
    NSURLSession *_session;
}
@end

@implementation NCKNetwork

+ (NCKNetwork *)shareInstance
{
    static dispatch_once_t once;
    static NCKNetwork *sharedNet;
    
    dispatch_once(&once, ^{
        sharedNet = [[NCKNetwork alloc] init];
    });
    
    return sharedNet;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
        sessionConfig.HTTPMaximumConnectionsPerHost = 4;
        
        _session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    }
    
    return self;
}

- (NSData *)postWithURL:(NSString *)url parameter:(NSDictionary *)param
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
    
    NSURLResponse *response = nil;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];

    NSData *ret = [_session sendSynchronousUploadTaskWithRequest:request fromData:data returningResponse:&response error:nil];
    
    return ret;
}

- (void)postWithURL:(NSString *)url parameter:(NSDictionary *)param target:(id)target selector:(SEL)selector
{
//    NSData *data = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//
//    [request setHTTPMethod:@"POST"];
//
//    [request setHTTPBody:data];
//    
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
//    
//    session.target = target;
//    
//    session.sucSelector = NSStringFromSelector(selector);
//
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
//    
//    [task resume];
}

- (void)postWithRequest:(NCKNetRequest *)request
{
    if (request.url.length == 0) {
        return;
    }
    
    NSMutableURLRequest *urlrequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:request.url]];
    
    [urlrequest setHTTPMethod:@"POST"];
    
    if (request.parameter) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:request.parameter options:0 error:nil];
        
        [urlrequest setHTTPBody:data];
    }
    
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:urlrequest];
    
    task.nc_request = request;
    
    [task resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [dataTask.nc_request appendResponseData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (task.nc_request.target)
    {
        task.nc_request.err = error;
        
        if(error)
        {
            if ([task.nc_request.target respondsToSelector:task.nc_request.failureSelector])
            {
                nckPerformSelectorLeakWarning(
                                              
                [task.nc_request.target performSelector:task.nc_request.failureSelector
                                             withObject:task.nc_request];
                );
            }
        }
        else {
            
            if ([task.nc_request.target respondsToSelector:task.nc_request.finishSelector])
            {
                nckPerformSelectorLeakWarning(
                                              
                [task.nc_request.target performSelector:task.nc_request.finishSelector
                                             withObject:task.nc_request];
                );
            }
        }
    }
}

- (void)cancelWithRequest:(NCKNetRequest *)request
{
    [self cancelWithTarget:request.target];
}

- (void)cancelWithTarget:(id)target
{
    [_session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        
        for (NSURLSessionTask *task in dataTasks)
        {
            if (task.nc_request.target == target) {
                
                [task cancel];
            }
        }
        
        for (NSURLSessionTask *task in uploadTasks)
        {
            if (task.nc_request.target == target) {
                
                [task cancel];
            }
        }
        
        for (NSURLSessionTask *task in downloadTasks)
        {
            if (task.nc_request.target == target) {
                
                [task cancel];
            }
        }
    }];
}
@end

@implementation NCKNetRequest

- (void)appendResponseData:(NSData *)data
{
    if(!_responseData) {
        
        _responseData = [[NSMutableData alloc] init];
    }
    
    [_responseData appendData:data];
}

+ (NCKNetRequest *)requestWithUrl:(NSString *)url
                       target:(id)target
               finishSelector:(SEL)finishSelector
              failureSelector:(SEL)failureSelector
{
    NCKNetRequest *request = [[NCKNetRequest alloc] init];
    
    request.url = url;
    
    request.target = target;
    
    request.finishSelector = finishSelector;
    
    request.failureSelector = failureSelector;
    
    return request;
}
@end