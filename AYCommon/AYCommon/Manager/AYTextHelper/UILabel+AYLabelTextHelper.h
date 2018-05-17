//
//  UILabel+AYLabelTextHelper.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/17.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AYLabelTextHelper)

@property (nonatomic, copy) void (^ay_tapBlock)(NSInteger index, NSAttributedString *charAttributedString);
@end
