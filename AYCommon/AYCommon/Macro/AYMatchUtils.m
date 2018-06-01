//
//  AYMatchUtils.m
//  AYCommon
//
//  Created by 张书孟 on 2018/5/30.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "AYMatchUtils.h"

@implementation AYMatchUtils

/// 手机号校验
+ (BOOL)checkPhoneNumInput:(NSString *)input
{
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:input];
}

/// 根据宽度求高度
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font:(CGFloat)font {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.height;
}

/// 根据高度度求宽度
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font {
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
}

@end
