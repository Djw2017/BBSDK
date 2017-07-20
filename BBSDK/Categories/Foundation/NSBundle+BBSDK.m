//
//  NSBundle+BBSDK.m
//  bbframework
//
//  Created by Dongjw on 2017/6/17.
//  Copyright © 2017年 Babybus. All rights reserved.
//

#import "NSBundle+BBSDK.h"

@implementation NSBundle (BBSDK)

/**
 通过lua的资源路径返回应用下资源的绝对路径
 
 @param luaPath lua资源路径
 @return 应用资源绝对路径
 */
- (NSString *)getAppPathForLuaPath:(NSString *)luaPath {
    NSString *path = [NSString stringWithFormat:@"%@/%@",self.bundlePath,luaPath];
    return path;
}

@end
