//
//  NSString+App.m
//  BaseKit
//
//  Created by Nigel Chou on 16/4/7.
//  Copyright © 2016年 BeautyFuture. All rights reserved.
//

#import "NSString+App.h"
#import <UIKit/UIKit.h>

@implementation NSString (App)

+ (NSString *)nck_appVersion
{
    return [[[NSBundle mainBundle]infoDictionary] valueForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)nck_appBuild
{
    return [[[NSBundle mainBundle]infoDictionary] valueForKey:@"CFBundleVersion"];
}

+ (NSString *)nck_launchImageName
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
   
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        NSString *orientation = dict[@"UILaunchImageOrientation"];
        
        if ([orientation isEqualToString:@"Landscape"]) {
            
            float tmp = imageSize.width;
            
            imageSize.width = imageSize.height;
            
            imageSize.height = tmp;
        }
        
        if (CGSizeEqualToSize(imageSize, viewSize))
        {
            return dict[@"UILaunchImageName"];
        }
    }
   
    return @"";
}
@end
