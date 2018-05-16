//
//  AYKeychain.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface AYKeychain : NSObject

/**
 本方法是得到 UDID 后存入系统中的 keychain 的方法
 不用添加 plist 文件
 程序删除后重装,仍可以得到相同的唯一标示
 但是当系统升级或者刷机后,系统中的钥匙串会被清空,此时本方法失效
 */
+ (NSString *)getDeviceIDInKeychain;

@end
