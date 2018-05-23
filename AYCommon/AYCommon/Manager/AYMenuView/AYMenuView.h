//
//  AYMenuView.h
//  Tools
//
//  Created by 张书孟 on 2018/5/23.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AYMenuViewArrowDirection) {
    // top
    AYMenuViewArrowDirectionTopLeft, // 左上
    AYMenuViewArrowDirectionTopCenter, // 中上
    AYMenuViewArrowDirectionTopRight, // 右上
    // bottom
    AYMenuViewArrowDirectionBottomLeft, // 左下
    AYMenuViewArrowDirectionBottomCenter, // 中下
    AYMenuViewArrowDirectionBottomRight, // 右下
    
};


@class AYMenuView;

@protocol AYMenuViewDelegate <NSObject>

@optional

- (void)menuView:(AYMenuView *)menuView didSelectRowAtIndex:(NSInteger )index;

@end


@interface AYMenuView : UIView

@property (nonatomic, weak) id<AYMenuViewDelegate> delegate;

+ (void)menuWithTitles:(NSArray *)titles images:(NSArray *)images frame:(CGRect)frame direction:(AYMenuViewArrowDirection)direction delegate:(id<AYMenuViewDelegate>)delegate;

@end

@interface AYMenuCell : UITableViewCell

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;

@end
