//
//  AYTextField.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AYTextField;
typedef void(^AYTextFieldHandler)(AYTextField *textField);

@interface AYTextField : UITextField

/** 能否被复制 默认为NO */
@property (nonatomic, assign) BOOL canBeCopied;
/** 能否被粘贴 默认为NO */
@property (nonatomic, assign) BOOL canBePasted;
/** 能否被剪切 默认为NO */
@property (nonatomic, assign) BOOL canBeCut;
/** 能否被选择 默认为YES */
@property (nonatomic, assign) BOOL canBeSelected;
/** 能否被全选 默认为NO */
@property (nonatomic, assign) BOOL canBeAllSelected;

/** 最大限制文本长度, 默认不限制长度 */
@property (nonatomic, assign) NSUInteger maxLength;

/**
 设定文本改变Block回调
 
 @param eventHandler 回调
 */
- (void)addTextDidChangeHandler:(AYTextFieldHandler)eventHandler;

/**
 设定文本达到最大长度的回调
 
 @param maxHandler 回调
 */
- (void)addTextLengthDidMaxHandler:(AYTextFieldHandler)maxHandler;

@end
