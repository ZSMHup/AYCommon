//
//  AYTextHelper.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/17.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AYTextHelper : NSObject

/**
 获取UILabel点击的字符

 @param location 点击label的位置
 @param label 点击的label
 @param selectedBlock 点击返回
 */
- (void)selectorLocation:(CGPoint)location label:(UILabel *)label selectedBlock:(void (^)(NSInteger index, NSAttributedString *charAttributedString))selectedBlock;

@end
