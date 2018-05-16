//
//  UIView+AYView.m
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "UIView+AYView.h"

@implementation UIView (AYView)

// 设置虚线边框
- (void)drawLineWidth:(int)lineWidth lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor fillColor:(UIColor *)fillColor cornerRadius:(int)cornerRadius {
    CAShapeLayer *border = [CAShapeLayer layer];
    // 边框颜色
    border.strokeColor = lineColor.CGColor;
    // 填充的颜色
    border.fillColor = fillColor.CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    // 设置路径
    border.path = path.CGPath;
    border.frame = self.bounds;
    // 边框的宽度
    border.lineWidth = lineWidth;
    // 设置线条的样式
    // border.lineCap = @"round";
    //虚线的虚线长度与间隔
    border.lineDashPattern = @[@(lineLength), @(lineSpacing)];
    [self.layer addSublayer:border];
}

@end
