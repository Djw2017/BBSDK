//
//  BBSoundUtil.m
//  bbframework
//
//  Created by book on 17/2/17.
//  Copyright © 2017年 Babybus. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "BBSoundUtil.h"
#import "BBFileUtil.h"

@interface BBSoundUtil ()<AVAudioPlayerDelegate>
{
    NSData *_soundData;
    NSData *_onceData;
}
@property (nonatomic, strong)AVAudioPlayer *soundPlayer;
@property (nonatomic, strong)AVAudioPlayer *oncePlayer;
@property (nonatomic, strong)AVAudioPlayer *avPlayer;
@property (nonatomic, strong)NSMutableArray *avArray;

@end

@implementation BBSoundUtil

SingletonM;

- (AVAudioPlayer *)soundPlayer {
    if (!_soundPlayer) {
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:_soundData error:nil];
        player.numberOfLoops = 0;
        player.delegate = self;
        _soundPlayer = player;
    }
    return _soundPlayer;
}

- (AVAudioPlayer *)oncePlayer {
    if (!_oncePlayer) {
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:_onceData error:nil];
        player.numberOfLoops = 0;
        player.delegate = self;
        _oncePlayer = player;
    }
    return _oncePlayer;
}

// 播放一次
- (void)playOnce:(NSString *)soundPath
{
    NSData *data;
    if ([[soundPath substringToIndex:4] isEqualToString:@"http"]) {
        data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:soundPath]];
    }else{
        if ([BBFileUtil fileExits:soundPath]) {
            data = [[NSData alloc] initWithContentsOfFile:soundPath];
        }else{
            NSString *path = [[NSBundle mainBundle] pathForResource:soundPath ofType:@"mp3"];
            data = [[NSData alloc] initWithContentsOfFile:path];
        }
    }
    if (data) {
        _soundData = data;
//        0x138e2c110
        [self.soundPlayer prepareToPlay];
        [self.soundPlayer play];
    }
}

/**
 *loops 为-1时是循环，最好不要用这个播放循环音频
 */
- (void)playSound:(NSString *)soundDic loops:(NSInteger)loops
{
    if (!self.avArray || self.avArray == nil) {
        self.avArray = [NSMutableArray array];
    }
    NSData *soundData;
    if ([soundDic length] > 4 && [[soundDic substringToIndex:4] isEqualToString:@"http"]) {
        soundData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:soundDic]];
    }else{
        if ([BBFileUtil fileExits:soundDic]) {
            soundData = [[NSData alloc] initWithContentsOfFile:soundDic];
        }else{
            NSString *path = [[NSBundle mainBundle] pathForResource:soundDic ofType:@"mp3"];
            soundData = [[NSData alloc] initWithContentsOfFile:path];
        }
    }
    if (soundData) {
        NSError *error;
        AVAudioPlayer *avPlayer = [[AVAudioPlayer alloc] initWithData:soundData error:&error];
        avPlayer.numberOfLoops = 0;
        [avPlayer prepareToPlay];
        [avPlayer play];
        avPlayer.delegate = self;
        self.avPlayer = avPlayer;
        [self.avArray addObject:avPlayer];
    }
}


/**
 @param path 路径
 */
- (void)playOnceWithPath:(NSString *)soundPath
{
    NSData *data;
    if ([[soundPath substringToIndex:4] isEqualToString:@"http"]) {
        data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:soundPath]];
    }else{
        if ([BBFileUtil fileExits:soundPath]) {
            data = [[NSData alloc] initWithContentsOfFile:soundPath];
        }else{
            NSString *path = [[NSBundle mainBundle] pathForResource:soundPath ofType:@"mp3"];
            data = [[NSData alloc] initWithContentsOfFile:path];
        }
    }
    if (data) {
        _onceData = data;
        [self.oncePlayer prepareToPlay];
        [self.oncePlayer play];
    }
}

- (BOOL)canPlayOnceWithPath
{
    if (self.oncePlayer != nil && [self.oncePlayer isPlaying]) {
        return NO;
    }
    return YES;
}

#pragma mark - 代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        if (self.soundPlayer == player) {
            [self.soundPlayer stop];
            self.soundPlayer = nil;
        }
        if (self.oncePlayer == player) {
            [self.oncePlayer stop];
            self.oncePlayer = nil;
        }
    }else{
        if (self.avArray.count > 0 && [self.avArray containsObject:player]) {
            [player stop];
            player = nil;
        }
    }
}

- (void)stopOnePlay
{
    if (self.soundPlayer) {
        [self.soundPlayer stop];
        self.soundPlayer = nil;
    }
    if (self.oncePlayer) {
        [self.oncePlayer stop];
        self.oncePlayer = nil;
    }
}

@end
