//
//  UIButton+AYCountdown.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^countdownCompletionBlock)(void);

@interface UIButton (AYCountdown)

/**
 倒计时，s倒计

 @param second 执行时间
 */
- (void)countdownWithSec:(NSInteger)second;

/**
 倒计时，秒字倒计

 @param second 执行时间
 */
- (void)countdownWithSecond:(NSInteger)second;

/**
 倒计时，s倒计,带有回调

 @param second 执行时间
 @param block 回调
 */
- (void)countdownWithSec:(NSInteger)second completion:(countdownCompletionBlock)block;

/**
 倒计时,秒字倒计，带有回调

 @param second 执行时间
 @param block 回调
 */
- (void)countdownWithSecond:(NSInteger)second completion:(countdownCompletionBlock)block;

@end
