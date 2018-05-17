//
//  UILabel+AYLabelTextHelper.m
//  AYCommon
//
//  Created by 张书孟 on 2018/5/17.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "UILabel+AYLabelTextHelper.h"
#import "AYTextHelper.h"
#import <objc/runtime.h>

NSString const *AY_TapBlock = @"AY_TapBlock";
NSString const *AY_TextHelper = @"AY_TextHelper";

@interface UILabel ()

@property (nonatomic,strong) AYTextHelper *ay_textHelper;

@end

@implementation UILabel (AYLabelTextHelper)

- (void)setAy_tapBlock:(void (^)(NSInteger, NSAttributedString *))ay_tapBlock
{
    objc_setAssociatedObject(self, &AY_TapBlock, ay_tapBlock, OBJC_ASSOCIATION_COPY);
    self.userInteractionEnabled = YES;
    AYTextHelper *textHelper = [[AYTextHelper alloc] init];
    self.ay_textHelper = textHelper;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ay_tapAction:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void (^)(NSInteger, NSAttributedString *))ay_tapBlock
{
    return objc_getAssociatedObject(self, &AY_TapBlock);
}

- (void)setAy_textHelper:(AYTextHelper *)ay_textHelper
{
    objc_setAssociatedObject(self, &AY_TextHelper, ay_textHelper, OBJC_ASSOCIATION_RETAIN);
}

- (AYTextHelper *)ay_textHelper {
    return objc_getAssociatedObject(self, &AY_TextHelper);
}
#pragma mark -Event
- (void)ay_tapAction:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    __weak UILabel *weakSelf = self;
    [self.ay_textHelper selectorLocation:location label:(UILabel *)recognizer.view selectedBlock:^(NSInteger index, NSAttributedString *charAttributedString) {
        if (weakSelf.ay_tapBlock) {
            weakSelf.ay_tapBlock(index, charAttributedString);
        }
    }];
}

@end
