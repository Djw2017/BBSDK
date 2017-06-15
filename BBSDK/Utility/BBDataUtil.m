//
//  BBDataUtil.m
//  BBSDK
//
//  Created by Dongjw on 2017/6/14.
//  Copyright © 2017年 sinyee.babybus. All rights reserved.
//

#import "BBDataUtil.h"

@implementation BBDataUtil

/**
 转换为json字符串
 
 @param object 需要转换的数据
 @return json字符串
 */
+ (NSString*)jsonStringForObject:(id)object {
    
    NSString *jsonString = nil;
    if (object && object != nil) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        if (!jsonData && error) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    
    return jsonString;
}

/**
 解析json字符串

 @param jsonString json
 @return 字典或数组
 */
+ (id)objectWithJsonString:(NSString *)jsonString {
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (data != nil) {
        NSError *error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
        if (object != nil && error == nil) {
            return object;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

@end
