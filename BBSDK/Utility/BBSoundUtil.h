//
//  BBSoundUtil.h
//  bbframework
//
//  Created by book on 17/2/17.
//  Copyright © 2017年 Babybus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MethodMacro.h"

@interface BBSoundUtil : NSObject

SingletonH;

/**
 播放音频，一次

 @param soundPath 播放地址：本地、网络、下载
 */
- (void)playOnce:(NSString *)soundPath;

/**
 *loops 为-1时是循环，最好不要用这个播放循环音频
 */
- (void)playOnceWithPath:(NSString *)path;
- (void)playSound:(NSString *)soundPath loops:(NSInteger)loops;
- (BOOL)canPlayOnceWithPath;
- (void)stopOnePlay;

@end
