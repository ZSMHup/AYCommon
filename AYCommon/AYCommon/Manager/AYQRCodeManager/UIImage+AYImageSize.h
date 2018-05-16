//
//  UIImage+AYImageSize.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AYImageSize)

/**
 设置一张不超过屏幕尺寸的 image
 
 @param image 传入一张image
 @return 返回一张不超过屏幕尺寸的 image
 */
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;

@end
