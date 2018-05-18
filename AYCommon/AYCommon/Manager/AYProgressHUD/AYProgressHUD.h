//
//  AYProgressHUD.h
//  AYProgressHUD
//
//  Created by hsuyelin on 2017/8/31.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AYProgressHUD : NSObject

/**
 显示菊花加载视图，周围可点击
 */
+ (void)show;

/**
 显示带文字的菊花加载视图，周围可点击

 @param text 加载文字
 */
+ (void)showHUDWithText:(NSString *)text;

/**
 显示菊花加载视图，周围不可点击
 */
+ (void)showHUDWithMask;

/**
 显示带文字的菊花加载视图，周围不可点击

 @param text 加载文字
 */
+ (void)showHUDWithMask:(NSString *)text;

/**
 显示 info 信息, 1.25秒后消失, 可配置

 @param info info 信息
 */
+ (void)showInfo:(NSString *)info;

/**
 显示 info 信息 在 window上, 1.25秒后消失, 可配置

 @param info info 信息
 */
+ (void)showInfoInWindow:(NSString *)info;

/**
 显示 success 信息, 1.25秒后消失, 可配置
 
 @param status status
 */
+ (void)showSuccessWithStatus:(NSString *)status;

/**
 显示 error 信息, 1.25秒后消失, 可配置
 
 @param status status
 */
+ (void)showErrorWithStatus:(NSString *)status;

/**
 显示网络加载框，周围可点击，默认文字为 加载中... 可修改
 */
+ (void)showNetWorkLoading;

/**
 显示网络加载框，周围不可点击，默认文字为 加载中... 可修改
 */
+ (void)showMaskNetWorkLoading;

/**
 网络加载失败, 1.25秒后消失, 可配置
 */
+ (void)showNetworkError;

/**
 隐藏加载视图
 */
+ (void)dismiss;

+ (void)dismissInMainThread;

/**
 delay 秒后隐藏加载视图

 @param delay delay 秒
 */
+ (void)dismissWithDelay:(NSTimeInterval)delay;

/**
 delay 秒后隐藏加载视图, 带回调

 @param delay delay 秒
 @param completion 回调
 */
+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(void(^)(void))completion;

@end
