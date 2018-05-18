//
//  AYProgressHUD.m
//  AYProgressHUD
//
//  Created by hsuyelin on 2017/8/31.
//  Copyright © 2017年 adinnet. All rights reserved.
//

#import "AYProgressHUD.h"

#import "MBProgressHUD+AYHUD.h"

@implementation AYProgressHUD

+ (void)show
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showActivityMessageInView];
    });
}

+ (void)showHUDWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showActivityMessageInView:text];
    });
}

+ (void)showHUDWithMask
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showActivityMessageInWindow];
    });
}

+ (void)showHUDWithMask:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showActivityMessageInWindow:text];
    });
}

+ (void)showInfo:(NSString *)info
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showTipMessageInView:info];
    });
}

+ (void)showInfoInWindow:(NSString *)info
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showTipMessageInWindow:info];
    });
}

+ (void)showSuccessWithStatus:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showSuccessMessage:status];
    });
}

+ (void)showErrorWithStatus:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showTipMessageInView:status];
    });
}

+ (void)showNetWorkLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showActivityMessageInView:@"加载中..."];
    });
}

+ (void)showMaskNetWorkLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    });
}

+ (void)showNetworkError
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismiss];
        [MBProgressHUD showErrorMessage:@"网络异常，请检查您的网络设置"];
    });
}

+ (void)dismiss
{
    [MBProgressHUD hideHUD];
}

+ (void)dismissInMainThread
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}

+ (void)dismissWithDelay:(NSTimeInterval)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
}

+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(void(^)(void))completion
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if (completion) {
            completion();
        }
    });
}

@end
