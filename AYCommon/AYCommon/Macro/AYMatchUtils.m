//
//  AYMatchUtils.m
//  AYCommon
//
//  Created by 张书孟 on 2018/5/30.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "AYMatchUtils.h"

@implementation AYMatchUtils

+ (BOOL)checkPhoneNumInput:(NSString *)input
{
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:input];
}

@end
