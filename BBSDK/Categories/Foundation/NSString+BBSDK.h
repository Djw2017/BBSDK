//
//  NSString+BBSDK.h
//  BBSDK
//
//  Created by Dongjw on 17/5/11.
//  Copyright © 2017年 sinyee.babybus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (BBSDK)

#pragma mark - Emoji
/**
 *  将带有emoji表情的字符串分割，判断是否是emoji 是改成表情
 *
 *  @param mutableString 字符串
 *
 */
+ (NSString *)stringWithUnicodeToEmoji:(NSString *)mutableString;

/**
 *  将带有emoji表情的字符串分割，判断是否是emoji 是生成unicode
 *
 *  @param string 字符串
 *
 */
+ (NSString *)stringWithEmojiToUnicode:(NSString *)string;




#pragma mark - 正则表达式
//验证手机号合法性
- (BOOL)isValidateTelephoneNumber;

//验证手机号合法性 --最新
- (BOOL)isMobileNumber;

//获取字符长度 中文=2个字符
- (int)convertToInt;




#pragma mark - Size
/**
 *  计算UILable高度,包含Emoji及多属性string
 *
 *  @param textFont 字体大小
 *  @param textWidth    lable宽度
 *
 */
- (CGFloat)getHeightOfFont:(UIFont *)textFont width:(CGFloat)textWidth;

/**
 *  计算UILable宽度,包含Emoji及多属性string
 *
 *  @param textFont 字体大小
 *  @param textHeight    lable高度
 *
 */
- (CGFloat)getWidthOfFont:(UIFont *)textFont height:(CGFloat)textHeight;

/**
 *  计算UILable高度,包含Emoji及多属性string
 *
 *  @param textFont 字体大小
 *  @param textWidth    lable宽度
 *  @param lineSpacing    lable的行间距
 *
 */
- (CGFloat)getHeightOfFont:(UIFont *)textFont width:(CGFloat)textWidth LineSpacing:(CGFloat)lineSpacing;

/**
 计算字符串大小
 
 @param font 字体
 @param maxSize 宽高限制，用于计算文本绘制时占据的矩形块
 @return 文本绘制所占据的矩形空间
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;




#pragma mark - NONil
/**
 *  返回一个不为空的字符串
 *
 *  @param string 字符串
 *
 */
+ (NSString *)noNilWithString:(NSString *)string;

/**
 *  字符串转NSInteger值
 *
 *  @param string 字符串
 *
 */
+ (NSInteger)noIntegerWithString:(NSString *)string;

/**
 *  字符串转CGFloat值
 *
 *  @param string 字符串
 *
 */
+ (CGFloat)noFloatWithString:(NSString *)string;

/**
 *  获取字典对应key值的字符串
 *
 *  @param objDic 字典
 *  @param objKey_ 关键字
 *
 */
+ (NSString *)isObjectDic:(NSDictionary*)objDic contentTheKey:(NSString*)objKey_;

/**
 *  获取银行卡号显示后四位数字(字符串)
 *
 *  @param string 字符串
 *
 */
+ (NSString *)cardNumWithString:(NSString *)string;

/**
 *  获取日期(字符串)
 *
 *  @param strTime 字符串日期
 *
 */
+ (NSString*)dateToObj:(NSString*)strTime;

/**
 *  获取时间(字符串)
 *
 *  @param strTime 字符串日期
 *
 */
+ (NSString*)timeToObj:(NSString*)strTime;

/**
 *  时间戳转日期(字符串)php
 *
 *  @param strTime 字符串日期
 *
 */
+ (NSString*)phpDateToObj:(NSString*)strTime;

/**
 *  时间戳转时间(字符串)php
 *
 *  @param strTime 字符串日期
 *
 */
+ (NSString*)phpTimeToObj:(NSString*)strTime;

/**
 *  时间戳转日期或者(当天)时间(字符串)
 *
 *  @param strTime 字符串日期
 *
 */
+ (NSString*)currentTimeToObj:(NSString*)strTime;

/**
 *  时间戳转日期或者(当天)时间(字符串)php
 *
 *  @param strTime 字符串日期
 *
 */
+ (NSString*)currentPhpTimeToObj:(NSString*)strTime;

/**
 *  转金钱格式的字符串
 *
 *  @param string 字符串
 *
 */
+ (NSString *)moneyWithString:(NSString *)string;

/**
 *  浮点数处理并去掉多余的0
 *
 *  @param floatValue 浮点数
 *
 */
+ (NSString *)stringDisposeWithFloat:(float)floatValue;

/**
 *  时间前后(与当前时间比较)
 *
 *  @param strTime 传入时间串
 *
 */
+ (NSString *)prettyDateWithReference:(NSString *)strTime;

/**
 *  输出当前日期或者当天某个时间点
 *
 *  @param strTime 时间戳
 *  @param timer 时间点的标记
 *
 */
+ (NSString *)prettyDateWithReference:(NSString *)strTime withTime:(NSInteger)timer;




#pragma mark - Securit
/**
 MD5加密

 @return 返回加密后字符串
 */
- (NSString *)MD5;

-(NSString *)aes256_decrypt:(NSString *)key padding:(NSString *)pad;
-(NSString *)aes256_encrypt:(NSString *)key padding:(NSString *)pad;




#pragma mark - Babybus
/**
 不区分阿语包名，假如是阿语包名则进行处理，否则返回自身包名
 
 @return 不区分语言的包名
 */
- (NSString *)notDistinguishARBundleId;




#pragma mark - Srting
/**
 *  返回YES,则此字符串是否包含这个字符串
 *
 *  @param SubStr 包含的字符串
 *
 *  @return YES 则为包含
 */
- (BOOL)hasContain:(NSString *)SubStr;

/**
 判断字符串是否为nil或者为空字符

 @return 可用
 */
- (BOOL)isValidate;

- (id)jsonValue;
@end
