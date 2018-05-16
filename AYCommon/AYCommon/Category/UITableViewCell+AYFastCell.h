//
//  UITableViewCell+AYFastCell.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UITableViewExpand <NSObject>

@optional

- (void)loadWithComponents;

@end

@interface UITableViewCell (AYFastCell) <UITableViewExpand>

/**
 tableViewCell 代码构建方法 必须使用 loadWithComponents 创建cell内的控件
 
 @param tableView 待处理的tableView
 @return 初始化
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 tableViewCell xib构建方法 必须使用 loadWithComponents 创建cell内的控件
 
 @param tableView tableView 待处理的tableView
 @return 初始化
 */
+ (instancetype)cellWithTableViewFromXIB:(UITableView *)tableView;

/**
 tableViewCell 赋值方法
 
 @param model 待处理的model
 */
- (void)setDataWithModel:(NSObject *)model;

/**
 获取cell高度的方法
 
 @param model 待处理的model
 @return cell的高度
 */
+ (CGFloat)getCellHeightWithModel:(NSObject *)model;

@end
