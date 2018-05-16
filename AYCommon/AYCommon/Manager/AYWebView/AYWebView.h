//
//  AYWebView.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class AYWebView;
@protocol AYWebViewDelegate <NSObject>

@optional
/**
 页面开始加载时调用
 
 @param webView AYWebView
 */
- (void)webViewDidStartLoad:(AYWebView *)webView;

/**
 内容开始返回时调用
 
 @param webView AYWebView
 @param url url
 */
- (void)webView:(AYWebView *)webView didCommitWithURL:(NSURL *)url;

/**
 页面加载完成之后调用
 
 @param webView AYWebView
 @param url url
 */
- (void)webView:(AYWebView *)webView didFinishLoadWithURL:(NSURL *)url;

/**
 页面加载失败时调用
 
 @param webView AYWebView
 @param error 返回错误信息
 */
- (void)webView:(AYWebView *)webView didFailLoadWithError:(NSError *)error;

/**
 在js端调用alert函数时，会触发此方法
 js端调用alert时所传的数据可以通过message拿到
 在原生得到结果后，需要回调js，是通过completionHandler回调
 */
- (void)webView:(AYWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;

/**
 在js端调用Confirm函数时，会触发此方法
 通过message可以拿到js端所传的数据
 在iOS端显示原生alert得到YES／NO
 在原生得到结果后，需要回调js，是通过completionHandler回调
 */
- (void)webView:(AYWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler;

/**
 在js端调用Prompt函数时，会触发此方法
 要求输入一段文本
 在原生输入得到内容后，通过completionHandler回调给js
 */
- (void)webView:(AYWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler;
@end

@interface AYWebView : UIView

/** CommonWebViewDelegate */
@property (nonatomic, weak) id<AYWebViewDelegate> delegate;
/** 进度条颜色(默认蓝色) */
@property (nonatomic, strong) UIColor *progressViewColor;
/** 导航栏标题 */
@property (nonatomic, copy) NSString *navigationItemTitle;
/** 导航栏存在且有穿透效果(默认导航栏存在且有穿透效果) */
@property (nonatomic, assign) BOOL isNavigationBarOrTranslucent;

/**
 类方法创建 CommonWebView
 
 @param frame frame
 @return CommonWebView
 */
+ (instancetype)webViewWithFrame:(CGRect)frame;
+ (instancetype)webViewWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration;

/**
 加载 web
 
 @param urlString 地址
 */
- (void)loadRequestWithUrlString:(NSString *)urlString;

/**
 加载本地资源
 
 @param fileName 该资源的名称（一定要加后缀）
 */
- (void)loadFileName:(NSString *)fileName;

/**
 加载本地资源
 
 @param filePath 本地资源路径
 */
- (void)loadFileWithFilePath:(NSString *)filePath;

/**
 刷新数据
 */
- (void)reloadData;

/**
 返回上一页
 */
- (void)goBack;

/**
 进入下一页
 */
- (void)goForward;

/**
 清除WKWebView的所有缓存（只能 iOS9 以后使用）
 
 @param completion 清除成功之后的回调
 */
- (void)removeAllCached:(void(^)(void))completion;

@end
