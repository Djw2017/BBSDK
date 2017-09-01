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

#pragma mark - 实例化音频播放
- (AVAudioPlayer *)soundPlayer {
    if (!_soundPlayer) {
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:_soundData error:nil];
        player.numberOfLoops = 0;
        player.delegate = self;
        _soundPlayer = player;
    }
    return _soundPlayer;
}

#pragma mark - 实例化播放一次的
- (AVAudioPlayer *)oncePlayer {
    if (!_oncePlayer) {
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:_onceData error:nil];
        player.numberOfLoops = 0;
        player.delegate = self;
        _oncePlayer = player;
    }
    return _oncePlayer;
}

#pragma mark - 播放声音一次
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
        [self.soundPlayer prepareToPlay];
        [self.soundPlayer play];
    }
}

#pragma mark - 播放音频音效（loops 为-1时是循环，最好不要用这个播放循环音频）
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

#pragma mark - 音频播放（播放完整，不被打断）
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

#pragma mark - 是否可以播放
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

#pragma maark - 停止播放
- (void)stopOnePlay
{
    if (self.oncePlayer) {
        [self.oncePlayer stop];
        self.oncePlayer = nil;
    }
}

@end
