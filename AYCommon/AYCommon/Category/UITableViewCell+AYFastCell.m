//
//  UITableViewCell+AYFastCell.m
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "UITableViewCell+AYFastCell.h"

#define kCellIdentifier NSStringFromClass(self)

@implementation UITableViewCell (AYFastCell)

#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadWithComponents];
    }
    return cell;
}

+ (instancetype)cellWithTableViewFromXIB:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(!cell){
        cell = [self viewFromXIB];
    }
    return cell;
}

+ (instancetype)viewFromXIB
{
    UITableViewCell *xibCell = [[[NSBundle mainBundle] loadNibNamed:kCellIdentifier owner:nil options:nil] firstObject];
    
    if(!xibCell){
        NSLog(@"CoreXibView：从xib创建视图失败，当前类是：%@", kCellIdentifier);
    }
    return xibCell;
}

#pragma mark - private
- (void)loadWithComponents
{
    
}

- (void)setDataWithModel:(NSObject *)model
{
    
}

+ (CGFloat)getCellHeightWithModel:(NSObject *)model
{
    return 0;
}

@end
