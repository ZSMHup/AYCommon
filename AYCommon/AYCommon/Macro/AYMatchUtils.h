//
//  AYMatchUtils.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/30.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYMatchUtils : NSObject

/**
 手机号校验
 
 @param input 输入的号码
 @return YES / NO
 */
+ (BOOL)checkPhoneNumInput:(NSString *)input;

@end
