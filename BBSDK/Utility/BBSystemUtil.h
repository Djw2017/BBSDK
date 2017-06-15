//
//  BBSystemUtil.h
//  BBSDK
//
//  Created by Dongjw on 17/5/12.
//  Copyright © 2017年 sinyee.babybus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BBSystemUtil : NSObject

#pragma mark - Device
/**
 获取设备总容量

 @return 设备总容量
 */
+ (float)totalDiskSpace;

/**
 获取设备可用容量
 
 @return 设备可用容量
 */
+ (float)freeDiskSpace;

/**
 获取设备型号

 @return 设备型号
 */
+ (NSString *)devicePlatForm;

/**
 获取当前语言

 @return 当前语言
 */
+ (NSString*)getPreferredLanguage;

/**
 获取包名

 @return 包名
 */
+ (NSString *)getBundleID;

/**
 是否安装指定应用

 @param bundleID 包名
 @return 是否安装
 */
+ (BOOL)isAppInstalled:(NSString *)bundleID;

/**
 根据语言获取数字请求服务端

 @param language zh、zht、en、de
 @return 服务端语言数字
 */
+ (int)getLanguageInt:(NSString *)language;


#pragma mark - time
//获取当前日期
+ (NSString *)getCurrentYear;
+ (NSString *)getCurrentMonth;
+ (NSString *)getCurrentDay;
+ (NSString *)getCurrentDate:(NSString *)format;
+ (NSString *)getCurrentHour;

//当前时间戳
+ (NSString *)timestamp;

/// 当前时间戳，长整型
+ (long long)getCurrentTime;

/**
 是否是圣诞节
 
 @return 是圣诞节
 */
+ (BOOL)isChristmas;

/**
 是否是新年
 
 @return 是新年
 */
+ (BOOL)isNewYear;


#pragma mark - App
+ (NSString *)currentVersion;

// 判断用户是否打开通知开关
+ (BOOL)isUIRemoteNotificationTypeNone;

@end