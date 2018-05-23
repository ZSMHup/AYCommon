//
//  AYScrollView.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/23.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AYScrollView : UIView

/**
 初始化方法
 
 @param frame frame
 @param titleArray 标题
 @param controllersArray 控制器
 @return SwitchVCContentView
 */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray controllersArray:(NSArray *)controllersArray;

@end
