//
//  BBDataUtil.h
//  BBSDK
//
//  Created by Dongjw on 2017/6/14.
//  Copyright © 2017年 sinyee.babybus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBDataUtil : NSObject

/**
 转换为json字符串
 
 @param object 需要转换的数据
 @return json字符串
 */
+ (NSString*)jsonStringForObject:(id)object;

/**
 解析json字符串
 
 @param jsonString json
 @return 字典或数组
 */
+ (id)objectWithJsonString:(NSString *)jsonString;

@end
