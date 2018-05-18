//
//  AYMacro.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#ifndef AYMacro_h
#define AYMacro_h

// 获取状态栏/导航栏高度
#define kStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavigationBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44.f)
// 获取屏幕宽高
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) { \
            [scrollView performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)]; \
        } else { \
            vc.automaticallyAdjustsScrollViewInsets = NO; \
        } \
    _Pragma("clang diagnostic pop") \
} while (0)

// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
// NSStringFormat
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

// APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
// 获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
// 判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 判断是真机还是模拟器
#if TARGET_OS_IPHONE
// 真机
#endif

#if TARGET_IPHONE_SIMULATOR
// 模拟器
#endif

// 获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// 获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()
// 获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// 开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

// 颜色
#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define kRandomColor           kRGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

// 弱引用/强引用
#define kWeakSelf(type) __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;


#endif /* AYMacro_h */

