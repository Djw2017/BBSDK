//
//  BBSystemUtility.m
//  BBSDK
//
//  Created by Dongjw on 17/5/12.
//  Copyright © 2017年 sinyee.babybus. All rights reserved.
//

#import <sys/utsname.h>

#import "NSString+BBSDK.h"
#import "NSArray+BBSDK.h"

#import "BBSystemUtil.h"

@implementation BBSystemUtil

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - Device
/**
 获取设备总容量
 
 @return 设备总容量
 */
+ (float)totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    float total=[[fattributes objectForKey:NSFileSystemSize] floatValue];
    float totalSpace=total/(1024.0*1024*1024);
    return totalSpace;
}

/**
 获取设备可用容量
 
 @return 设备可用容量
 */
+ (float)freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    float free=[[fattributes objectForKey:NSFileSystemFreeSize] floatValue];
    float freeSpace=free/(1024.0*1024*1024);
    return freeSpace;
}

/**
 获取设备型号
 
 @return 设备型号
 */
+ (NSString *)devicePlatForm{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {
        return @"iPhone 4";
    } else if ([platform isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4S";
    } else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    } else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5c";
    } else if ([platform isEqualToString:@"iPhone6,1"]||[platform isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5s";
    } else if ([platform isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus";
    } else if ([platform isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    } else if ([platform isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    } else if ([platform isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus";
    } else if ([platform isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    } else if ([platform isEqualToString:@"iPhone9,1"]) {
        return @"iPhone 7";
    } else if ([platform isEqualToString:@"iPhone9,2"]) {
        return @"iPhone 7 Plus";
    }
    
    
    //iPod
    else if ([platform isEqualToString:@"iPod1,1"]||[platform isEqualToString:@"iPod2,1"]||[platform isEqualToString:@"iPod3,1"]||[platform isEqualToString:@"iPod4,1"]||[platform isEqualToString:@"iPod5,1"]||[platform isEqualToString:@"iPod7,1"]) {
        return @"iPod Touch";
    }
    
    
    //iPad
    else if ([platform isEqualToString:@"iPad1,1"]) {
        return @"iPad 1";
    } else if ([platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {
        return @"iPad 2";
    } else if ([platform isEqualToString:@"iPad3,1"]||[platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,3"]) {
        return @"iPad 3";
    } else if ([platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {
        return @"iPad 4";
    } else if ([platform isEqualToString:@"iPad4,1"]||[platform isEqualToString:@"iPad4,2"]||[platform isEqualToString:@"iPad4,3"]) {
        return @"iPad Air 1";
    } else if ([platform isEqualToString:@"iPad5,3"]||[platform isEqualToString:@"iPad5,4"]) {
        return @"iPad Air 2";
    } else if ([platform isEqualToString:@"iPad6,7"]||[platform isEqualToString:@"iPad6,8"]||[platform isEqualToString:@"iPad6,3"]||[platform isEqualToString:@"iPad6,4"]) {
        return @"iPad Pro";
    }
    
    else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]) {
        return @"iPad Mini 1";
    } else if ([platform isEqualToString:@"iPad4,4"]||[platform isEqualToString:@"iPad4,5"]||[platform isEqualToString:@"iPad4,6"]) {
        return @"iPad mini 2";
    } else if ([platform isEqualToString:@"iPad4,7"]||[platform isEqualToString:@"iPad4,8"]||[platform isEqualToString:@"iPad4,9"]) {
        return @"iPad mini 3";
    } else if ([platform isEqualToString:@"iPad5,1"]||[platform isEqualToString:@"iPad5,2"]) {
        return @"iPad mini 4";
    }
    
    //Watch
    else if ([platform isEqualToString:@"Watch1,1"]||[platform isEqualToString:@"Watch1,2"]) {
        return @"Apple Watch";
    }
    else if ([platform isEqualToString:@"i386"]) {
        return @"iPhone Simulator";
    } else if ([platform isEqualToString:@"x86_64"]) {
        return @"iPad Simulator";
    }
    
    
    return platform;
}

/**
 获取系统版本号
 
 @return 系统版本
 */
+ (NSString *)getSystemVersion {
    float version = [[UIDevice currentDevice].systemVersion floatValue];
    NSString *versionStr = [NSString stringWithFormat:@"%.2f", version];
    return versionStr;
}

/**
 获取当前语言
 
 @return 当前语言
 */
+ (NSString*)getPreferredLanguage {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    
    NSString *preferredLang = [allLanguages safeObjectAtIndex:0];
    
    //NSLog(@"当前语言:%@", preferredLang);
    NSRange range = [preferredLang rangeOfString:@"zh-Hant" options:NSCaseInsensitiveSearch];
    if([preferredLang isEqualToString:@"en-US"]){
        preferredLang = @"zh";
    }else if(range.length > 0){
        preferredLang = @"zh";
    }else{
        preferredLang = @"zh";
    }
    
    return preferredLang;
}

/**
 判断当前地区是不是中国大陆
 
 @return 是中国大陆
 */
+ (BOOL)isMainlandChina {
    
    NSString *identifier = [[NSLocale currentLocale] localeIdentifier];
    if ([identifier hasContain:@"_"]) {
        NSArray *ary = [identifier componentsSeparatedByString:@"_"];
        if (ary.count > 1) {
            if ([ary[1] isEqualToString:@"CN"]) {
                return YES;
            }
        }
    }
    return NO;
}

/**
 判断当前语言是中文还是外国语言
 
 @return 中文
 */
+ (BOOL)isChinese {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSRange range = [currentLanguage rangeOfString:@"zh"];
    
    if (range.location == NSNotFound) {
        return NO;
    }else{
        return YES;
    }
}

/**
 判断当前环境是否是繁体中文
 
 @return 是繁体中文
 */
+ (BOOL)isTraditionalChinese {
    // get the current language and country config
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    return [currentLanguage hasContain:@"zh-Hant"] || [currentLanguage isEqualToString:@"zh-HK"] || [currentLanguage isEqualToString:@"zh-TW"];
}

/**
 判断当前语言是否是简体中文
 
 @return 中文
 */
+ (BOOL)isSimpleChinese {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSRange range = [currentLanguage rangeOfString:@"zh"];
    
    if (range.location != NSNotFound && ![BBSystemUtil isTraditionalChinese]) {
        return YES;
    }else{
        return NO;
    }
}

/**
 获取包名
 
 @return 包名
 */
+ (NSString *)getBundleID {
    return [[NSBundle mainBundle] bundleIdentifier];
}

/**
 * 获得应用程序的版本
 *
 * @return 应用程序的版本
 *
 */
+ (NSString *)getVersion {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return version;
}

/**
 是否安装指定应用
 
 @param bundleID 包名
 @return 是否安装
 */
+ (BOOL)isAppInstalled:(NSString *)bundleID {
    NSString *appKey = bundleID;
    NSRange range = [appKey rangeOfString:@"://"];
    
    if(range.location == NSNotFound){
        appKey = [appKey stringByAppendingString:@"://"];
    }
    
    if ([@"com.sinyee.babybus.recommandApp2://" isEqualToString:appKey] || [@"com.sinyee.babybus.recommendapp://" isEqualToString:appKey]) {
        BOOL install_1  = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"com.sinyee.babybus.recommandApp2://"]];
        BOOL install_2  = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"com.sinyee.babybus.recommendapp://"]];
        if (install_1||install_2) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appKey]];
    }
    return NO;
}

/**
 获取app名称
 
 @return DisplayName
 */
+ (NSString *)getAppName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

/**
 根据语言获取数字请求服务端
 
 @param language zh、zht、en、de
 @return 服务端语言数字
 */
+ (int)getLanguageInt:(NSString *)lang {
    int result = 0;
    
    NSString *language = lang;
    if ([language isEqualToString:@"zh"]) {
        result = 1;
    } else if ([language isEqualToString:@"zht"]) {
        result = 2;
    } else if ([language isEqualToString:@"en"]) {
        result = 3;
    } else if ([language isEqualToString:@"de"]) {
        result = 4;
    } else if ([language isEqualToString:@"ja"]) {
        result = 5;
    } else if ([language isEqualToString:@"fr"]) {
        result = 6;
    } else if ([language isEqualToString:@"ru"]) {
        result = 7;
    } else if ([language isEqualToString:@"ko"]) {
        result = 8;
    } else if ([language isEqualToString:@"ar"]) {
        result = 9;
    } else if ([language isEqualToString:@"pt"]) {
        result = 10;
    } else if ([language isEqualToString:@"es"]) {
        result = 11;
    }else if ([language isEqualToString:@"vi"]) {
        result = 12;
    }else if ([language isEqualToString:@"hi"]) {
        result = 13;
    }else if ([language isEqualToString:@"id"]) {
        result = 14;
    }else if ([language isEqualToString:@"th"]) {
        result = 15;
    } else {
        result = 3;
    }
    
    return result;
}

#pragma mark - time
//年
+ (NSString *)getCurrentYear {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatterY = [[NSDateFormatter alloc] init];
    [dateformatterY setDateFormat:@"YYYY"];
    return [dateformatterY stringFromDate:currentDate];//当前年份
}
//月
+ (NSString *)getCurrentMonth {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatterM = [[NSDateFormatter alloc] init];
    [dateformatterM setDateFormat:@"MM"];
    return [dateformatterM stringFromDate:currentDate];//当前月份
}
//日
+ (NSString *)getCurrentDay {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatterD = [[NSDateFormatter alloc] init];
    [dateformatterD setDateFormat:@"dd"];
    return [dateformatterD stringFromDate:currentDate];
}

//时
+ (NSString *)getCurrentHour {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatterD = [[NSDateFormatter alloc] init];
    [dateformatterD setDateFormat:@"hh"];
    return [dateformatterD stringFromDate:currentDate];
}

//时
+ (NSString *)getCurrentMinute {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatterD = [[NSDateFormatter alloc] init];
    [dateformatterD setDateFormat:@"mm"];
    return [dateformatterD stringFromDate:currentDate];
}

//秒
+ (NSString *)getCurrentSecond {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatterD = [[NSDateFormatter alloc] init];
    [dateformatterD setDateFormat:@"ss"];
    return [dateformatterD stringFromDate:currentDate];
}

+ (NSString *)getCurrentDate:(NSString *)format{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatterD = [[NSDateFormatter alloc] init];
    [dateformatterD setDateFormat:format];
    return [dateformatterD stringFromDate:currentDate];
}

//当前时间戳
+ (NSString *)timestamp{

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f", a];
}

/// 当前时间戳，长整型
+ (long long)getCurrentTime {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long date = (long long)time;
    return date;
}

+ (int)getAgeWithTimestamp:(long long)birthTime
{
    NSDate *date  = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:birthTime];
    [formatter setDateFormat:@"YYYY"];
    NSString *currentYear = [formatter stringFromDate:date];
    NSString *birthYear   = [formatter stringFromDate:stampDate2];
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth = [formatter stringFromDate:date];
    NSString *birthMonth   = [formatter stringFromDate:stampDate2];
    if (birthMonth.intValue < currentMonth.intValue) {
        return currentYear.intValue - birthYear.intValue;
    } else if (birthMonth.intValue > currentMonth.intValue) {
        return currentYear.intValue - birthYear.intValue - 1;
    }else if (birthMonth.intValue == currentMonth.intValue) {
        [formatter setDateFormat:@"dd"];
        NSString *currentday = [formatter stringFromDate:date];
        NSString *birthday   = [formatter stringFromDate:stampDate2];
        if (birthday.intValue <= currentday.intValue) {
            return currentYear.intValue - birthYear.intValue;
        } else {
            return currentYear.intValue - birthYear.intValue - 1;
        }
    }
    
    return 0;
}

/**
 是否是圣诞节

 @return 是圣诞节
 */
+ (BOOL)isChristmas{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    if (month == 12) {
        if (day>=22 && day<=27) {
            return YES;
        }
    }
    
    return NO;
}

/**
 是否是新年

 @return 是新年
 */
+ (BOOL)isNewYear{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    if (month == 12) {
        if (day==31) {
            return YES;
        }
    }
    if (month == 2) {
        if (day>=7 && day<=8) {
            return YES;
        }
    }
    return NO;
}

/**
 指定时间是否为当天
 
 @param timeStamp 时间戳
 @return 当天
 */
+ (BOOL)isToday:(NSTimeInterval)timeStamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    
    NSString *selfDay = [formatter stringFromDate:date];
    NSString *nowDay = [formatter stringFromDate:[NSDate date]];
    
    if ([selfDay isEqualToString:nowDay]) {
        
        return YES;
        
    } else {
        return NO;
        
    }
}

#pragma mark - App
+ (NSString *)currentVersion {
    NSString *verStr=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *version = [verStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    return version;
}

// 判断用户是否打开通知开关
+ (BOOL)isUIRemoteNotificationTypeNone {
    if (!([[[UIDevice currentDevice] systemVersion] intValue] == 7.0)) { //iOS8以上包含iOS8
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) { //判断用户是否打开通知开关
            return YES;
        }else {
            return NO;
        }
    }else{ // ios7 一下
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (type  == UIRemoteNotificationTypeNone) { //判断用户是否打开通知开关
            return YES;
        }else {
            return NO;
        }
    }
}

@end

#pragma clang diagnostic pop
