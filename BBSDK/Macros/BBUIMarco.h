//
//  BBUIMarco.h
//  BBSDK
//
//  Created by Dongjw on 17/5/11.
//  Copyright © 2017年 sinyee.babybus. All rights reserved.
//

#ifndef BBUIMarco_h
#define BBUIMarco_h
#import "Const.h"

#import <UIKit/UIKit.h>

#import "BBUIUtil.h"

//****************************************** 版本判断  ************************************//

#define IOS_SYSTEM_VERSION      [[[UIDevice currentDevice] systemVersion] floatValue]

#define IOS7_OR_LATER           ([[[UIDevice currentDevice] systemVersion] intValue] >= 7.0)
#define IOS8_OR_LATER           ([[[UIDevice currentDevice] systemVersion] intValue] >= 8.0)
#define IOS9_OR_LATER           ([[[UIDevice currentDevice] systemVersion] intValue] >= 9.0)
#define IOS10_OR_LATER          ([[[UIDevice currentDevice] systemVersion] intValue] >= 10.0)
#define IOS11_OR_LATER          ([[[UIDevice currentDevice] systemVersion] intValue] >= 11.0)

#define IOS_IS_7                (IOS7_OR_LATER && !(IOS8_OR_LATER))
#define IOS_IS_8                (IOS8_OR_LATER && !(IOS9_OR_LATER))
#define IOS_IS_9                (IOS9_OR_LATER && !(IOS10_OR_LATER))
#define IOS_IS_10               (IOS10_OR_LATER && !(IOS11_OR_LATER))


// 是否高清设备
#define IS_RETINA   ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)




//*****************************************  设备的 宽高 *************************************************//
#pragma mark - 设备 的 宽高

// 设备全屏宽

#define SCREEN_WIDTH    ((IOS_IS_7&&[UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait)?[[UIScreen mainScreen] bounds].size.height:[[UIScreen mainScreen] bounds].size.width)

// 设备全屏高
#define SCREEN_HEIGHT   ((IOS_IS_7&&[UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait)?[[UIScreen mainScreen] bounds].size.width:[[UIScreen mainScreen] bounds].size.height)

//判断iPhone型号
#define IS_BEGORE_IPHONE_5      [[UIScreen mainScreen] bounds].size.height <= 568.0f
#define IS_IPHONE_5             [[UIScreen mainScreen] bounds].size.height == 568.0f
#define IS_IPHONE_6             ([[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6P            [[UIScreen mainScreen] bounds].size.height == 736.0f
#define IS_iPhoneX              ((SCREEN_WIDTH == 812 && SCREEN_HEIGHT == 375)||(SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812))

#define heightRate    (IS_iPhoneX?715:SCREEN_WIDTH)/736
#define widthRate     SCREEN_HEIGHT/(IS_iPhoneX?320:414)


//设备尺寸比例
#define SCALE_WIDTH    SCREEN_WIDTH/1920

//*****************************************  颜色 *************************************************//
#pragma mark - 颜色

#define COLOR_WITH_HEXSTR(color_hexstr)                     [BBUIUtil colorWithHexString:color_hexstr]

#define COLOR_WIHT_HEXSTR_ALPHA(color_hexstr,alphaValue)    [BBUIUtil colorWithHexString:color_hexstr withAlpha:alphaValue]

#define RGB(r,g,b)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RGBA(r,g,b,a)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#endif /* BBUIMarco_h */
