//
//  AYMatchUtils.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/30.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AYMatchUtils : NSObject

/**
 手机号校验
 
 @param input 输入的号码
 @return YES / NO
 */
+ (BOOL)checkPhoneNumInput:(NSString *)input;

#pragma mark - 尺寸计算
/**
 根据宽度求高度

 @param text 计算的内容
 @param width 最大宽度
 @param font 字体大小
 @return 高度
 */
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font:(CGFloat)font;

/**
 根据高度度求宽度

 @param text 计算的内容
 @param height 最大高度
 @param font 字体大小
 @return 宽度
 */
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;

@end
