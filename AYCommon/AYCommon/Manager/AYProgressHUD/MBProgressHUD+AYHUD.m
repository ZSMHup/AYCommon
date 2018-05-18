//
//  MBProgressHUD+AYHUD.m
//  AYProgressHUD
//
//  Created by hsuyelin on 2017/8/31.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "MBProgressHUD+AYHUD.h"

#define kProgressHUDDuration 1.0f

#define IS_IPHONE_HUD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kHUDScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kIS_IPHONE_5 (IS_IPHONE_HUD && kHUDScreenHeight == 568.0f)

@implementation MBProgressHUD (AYHUD)

#pragma mark - public tip hud
+ (void)showTipMessageInWindow:(NSString *)message
{
    [self showTipMessage:message isWindow:YES timer:kProgressHUDDuration];
}

+ (void)showTipMessageInView:(NSString *)message
{
    if (!message) {
        return;
    }
    [self showTipMessage:message isWindow:NO timer:kProgressHUDDuration];
}

+ (void)showTipMessageInWindow:(NSString *)message timer:(NSTimeInterval)aTimer
{
    [self showTipMessage:message isWindow:YES timer:aTimer];
}

+ (void)showTipMessageInView:(NSString *)message timer:(NSTimeInterval)aTimer
{
    [self showTipMessage:message isWindow:NO timer:aTimer];
}

#pragma mark - public activity hud
+ (void)showActivityMessageInWindow
{
    [self showActivityMessageInWindow:@""];
}

+ (void)showActivityMessageInView
{
    [self showActivityMessageInView:@""];
}

+ (void)showActivityMessageInWindow:(NSString *)message
{
    [self showActivityMessage:message isWindow:YES timer:0];
}

+ (void)showActivityMessageInView:(NSString *)message
{
    [self showActivityMessage:message isWindow:NO timer:0];
}

+ (void)showActivityMessageInWindow:(NSString *)message timer:(NSTimeInterval)aTimer
{
    [self showActivityMessage:message isWindow:YES timer:aTimer];
}

+ (void)showActivityMessageInView:(NSString *)message timer:(NSTimeInterval)aTimer
{
    [self showActivityMessage:message isWindow:NO timer:aTimer];
}

+ (void)showActivityMessage:(NSString *)message isWindow:(BOOL)isWindow timer:(NSTimeInterval)aTimer
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindow:isWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (aTimer > 0.f) {
        [hud hide:YES afterDelay:aTimer];
    }
}

#pragma mark - public image hud
+ (void)showSuccessMessage:(NSString *)Message
{
    NSString *name = @"success";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showErrorMessage:(NSString *)Message
{
    NSString *name = @"error";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showInfoMessage:(NSString *)Message
{
    NSString *name = @"info";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showWarnMessage:(NSString *)Message
{
    NSString *name = @"info";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:YES];
}

+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:NO];
}

#pragma mark - public hide
+ (void)hideHUD
{
    UIView *winView = (UIView *)[UIApplication sharedApplication].delegate.window;
    [self hideAllHUDsForView:winView animated:YES];
    [self hideAllHUDsForView:[self getCurrentUIVC].view animated:YES];
}

#pragma mark - private
+ (MBProgressHUD *)createMBProgressHUDviewWithMessage:(NSString *)message isWindow:(BOOL)isWindow
{
    UIView *view = isWindow ? (UIView *)[UIApplication sharedApplication].delegate.window : [self getCurrentUIVC].view;
    if (!view) {
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = isWindow ? YES : NO;
    hud.labelText = message ? message : @"加载中...";
    if (kIS_IPHONE_5) {
        hud.labelFont = [UIFont systemFontOfSize:14];
    } else {
        hud.labelFont = [UIFont systemFontOfSize:15];
    }

    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
    return hud;
}

+ (void)showTipMessage:(NSString *)message isWindow:(BOOL)isWindow timer:(NSTimeInterval)aTimer
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindow:isWindow];
    hud.customView = nil;
    hud.mode = MBProgressHUDModeCustomView;
    [hud hide:YES afterDelay:kProgressHUDDuration];
}

+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindow:isWindow];
    NSString *resBundle = [[NSBundle mainBundle] pathForResource:@"AYProgressHUD" ofType:@"bundle"];
    NSString *img_path = [[NSBundle bundleWithPath:resBundle] pathForResource:iconName ofType:@"png" inDirectory:nil];;
    if (img_path) {
        UIImage *resImage = [UIImage imageWithContentsOfFile:img_path];
        UIImage *hudImage = [self changeImageColorWithColor:[UIColor whiteColor] image:resImage];
        
        hud.customView = [[UIImageView alloc] initWithImage:hudImage];
    } else {
        hud.customView = nil;
    }

    hud.mode = MBProgressHUDModeCustomView;
    [hud hide:YES afterDelay:kProgressHUDDuration];
}

#pragma mark - utils
+ (UIViewController *)getCurrentUIVC
{
    UIViewController *resultVC;
    resultVC = [self ay_topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self ay_topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)ay_topViewController:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self ay_topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self ay_topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (UIImage *)changeImageColorWithColor:(UIColor *)color image:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
