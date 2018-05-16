//
//  UIView+AYView.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AYView)

/**
 虚线边框
 
 @param lineWidth 边框宽度
 @param lineLength 边框长度
 @param lineSpacing 边框间距
 @param lineColor 边框颜色
 @param fillColor 填充颜色
 @param cornerRadius 圆角
 */
- (void)drawLineWidth:(int)lineWidth lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor cornerRadius:(int)cornerRadius;

@end
