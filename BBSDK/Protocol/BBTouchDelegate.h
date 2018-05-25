//
//  BBtouchDelegate.h
//  bbframework
//
//  Created by Warrior on 2017/10/10.
//  Copyright © 2017年 Babybus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BBTouchDelegate <NSObject>

@optional
- (void)touchBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
- (void)touchEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end
