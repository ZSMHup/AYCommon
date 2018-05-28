//
//  AYMenuView.m
//  Tools
//
//  Created by 张书孟 on 2018/5/23.
//  Copyright © 2018年 张书孟. All rights reserved.
//

#import "AYMenuView.h"

#define kCellHeight 40
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kWindows [[UIApplication sharedApplication].delegate window]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

@interface AYMenuView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *menuBgView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) AYMenuViewArrowDirection direction;
@property (nonatomic, assign) CGFloat maxHeight;

@end

@implementation AYMenuView

#pragma mark - public
+ (void)menuWithTitles:(NSArray *)titles images:(NSArray *)images frame:(CGRect)frame direction:(AYMenuViewArrowDirection)direction delegate:(id<AYMenuViewDelegate>)delegate {
    AYMenuView *menu = [[AYMenuView alloc] initWithFrame:frame];
    menu.titles = titles;
    menu.images = images;
    menu.direction = direction;
    menu.delegate = delegate;
    menu.maxHeight = frame.size.height;
    [kWindows addSubview:menu];
}

- (instancetype)initMenuWithTitles:(NSArray *)titles images:(NSArray *)images frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.images = images;
        self.maxHeight = frame.size.height;
        [self addSubViews];
    }
    return self;
}

#pragma mark - overwrite
- (void)drawRect:(CGRect)rect {
    CGFloat Width  = self.frame.size.width;
    CGFloat Height = self.frame.size.height;
    CGFloat arrowW = 14;
    CGFloat arrowH = (1.5 * arrowW) / 2;
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    
    switch (self.direction) {
        case AYMenuViewArrowDirectionTopLeft:
            point1 = CGPointMake(arrowW / 2, 0);
            point2 = CGPointMake(arrowW, -arrowH);
            point3 = CGPointMake(arrowW * 1.5, 0);
            break;
        case AYMenuViewArrowDirectionTopCenter:
            point1 = CGPointMake((Width / 2) - (arrowW / 2), 0);
            point2 = CGPointMake((Width / 2), -arrowH);
            point3 = CGPointMake((Width / 2) + (arrowW / 2), 0);
            break;
        case AYMenuViewArrowDirectionTopRight:
            point1 = CGPointMake(Width - arrowW - arrowW / 2, 0);
            point2 = CGPointMake(Width - arrowW, -arrowH);
            point3 = CGPointMake(Width - arrowW / 2, 0);
            break;
        case AYMenuViewArrowDirectionBottomLeft:
            point1 = CGPointMake(arrowW / 2, Height);
            point2 = CGPointMake(arrowW, Height + arrowH);
            point3 = CGPointMake(arrowW * 1.5, Height);
            break;
        case AYMenuViewArrowDirectionBottomCenter:
            point1 = CGPointMake((Width / 2) - (arrowW / 2), Height);
            point2 = CGPointMake((Width / 2), Height + arrowH);
            point3 = CGPointMake((Width / 2) + (arrowW / 2), Height);
            break;
        case AYMenuViewArrowDirectionBottomRight:
            point1 = CGPointMake(Width - arrowW - arrowW/2, Height);
            point2 = CGPointMake(Width - arrowW, Height + arrowH);
            point3 = CGPointMake(Width - arrowW/2, Height);
            break;
        default:
            break;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path closePath];

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = RGBAColor(33, 33, 33, 1).CGColor;
    layer.fillColor = RGBAColor(33, 33, 33, 1).CGColor;
    [self.layer addSublayer:layer];
    [self addSubViews];
}

#pragma mark - private
- (void)addSubViews {
    [kWindows addSubview:self.menuBgView];
    [kWindows addSubview:self.tableView];
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.menuBgView.alpha = 1;
        self.tableView.alpha = 1;
        self.alpha = 1;
    }];
}

#pragma mark - event response
- (void)hidMenu {
    [UIView animateWithDuration:0.25 animations:^{
        self.menuBgView.alpha = 0;
        self.alpha = 0;
        self.tableView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.tableView removeFromSuperview];
        [self removeFromSuperview];
        [self.menuBgView removeFromSuperview];
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AYMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AYMenuCell"];
    if (self.images.count > 0 && self.images.count == self.titles.count) {
        [cell setImageName:self.images[indexPath.row]];
    }
    [cell setTitle:self.titles[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuView:didSelectRowAtIndex:)]) {
        [self hidMenu];
        [self.delegate menuView:self didSelectRowAtIndex:indexPath.row];
    }
}

#pragma mark - 懒加载
- (UIButton *)menuBgView {
    if (!_menuBgView) {
        _menuBgView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _menuBgView.backgroundColor = RGBAColor(0, 0, 0, 0.1);
        _menuBgView.alpha = 0;
        [_menuBgView addTarget:self action:@selector(hidMenu) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _menuBgView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.alpha = 0;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = kCellHeight;
        _tableView.scrollEnabled = self.maxHeight <= kCellHeight * self.titles.count;
        [_tableView registerClass:[AYMenuCell class] forCellReuseIdentifier:@"AYMenuCell"];
    }
    return _tableView;
}

@end

@interface AYMenuCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation AYMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.backgroundColor = [UIColor clearColor];
        [self addSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_imageName) {
        self.imgView.frame = CGRectMake(10, (kCellHeight - 20) / 2, 20, 20);
        self.contentLabel.frame = CGRectMake(40, (kCellHeight - 20) / 2, self.contentView.frame.size.width - 50, 20);
    } else {
        self.contentLabel.frame = CGRectMake(10, (kCellHeight - 20) / 2, self.contentView.frame.size.width - 20, 20);
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)addSubViews {
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.contentLabel];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.contentLabel.text = title;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imgView.image = [UIImage imageNamed:imageName];
}

@end

