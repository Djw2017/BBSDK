//
//  NSData+BBSDK.h
//  BBSDK
//
//  Created by Dongjw on 2017/6/13.
//  Copyright © 2017年 sinyee.babybus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BBSDK)

- (NSData *)aes256_encrypt:(NSString *)key padding:(NSString *)pad;
- (NSData *)aes256_decrypt:(NSString *)key padding:(NSString *)pad;

@end
