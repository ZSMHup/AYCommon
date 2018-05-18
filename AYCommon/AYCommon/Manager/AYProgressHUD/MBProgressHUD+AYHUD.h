//
//  MBProgressHUD+AYHUD.h
//  AYProgressHUD
//
//  Created by hsuyelin on 2017/8/31.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (AYHUD)

#pragma mark - tip hud
+ (void)showTipMessageInWindow:(NSString *)message;
+ (void)showTipMessageInView:(NSString *)message;
+ (void)showTipMessageInWindow:(NSString *)message timer:(NSTimeInterval)aTimer;
+ (void)showTipMessageInView:(NSString *)message timer:(NSTimeInterval)aTimer;

#pragma mark - activity hud
+ (void)showActivityMessageInWindow;
+ (void)showActivityMessageInWindow:(NSString *)message;
+ (void)showActivityMessageInView;
+ (void)showActivityMessageInView:(NSString *)message;
+ (void)showActivityMessageInWindow:(NSString *)message timer:(NSTimeInterval)aTimer;
+ (void)showActivityMessageInView:(NSString *)message timer:(NSTimeInterval)aTimer;

#pragma mark - image hud
+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;

#pragma mark - hide hud
+ (void)hideHUD;

@end
