//
//  AYFileDownloadManager.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AYFileSessionModel.h"

@interface AYFileDownloadManager : NSObject

/**
 单例
 
 @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 开启任务下载资源
 
 @param url 下载地址
 @param attribute 需要存储的属性
 @param fileName 存储的目录 默认：Default
 @param progressBlock 回调下载进度
 @param stateBlock 下载状态
 */
- (void)downloadWithURL:(NSString *)url attribute:(NSDictionary *)attribute fileName:(NSString *)fileName  progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock state:(void(^)(DownloadState state))stateBlock;

/**
 开始多个任务
 
 @param attribute 传入的文件信息(注意：传入的URL attribute[i][@"url"])
 @param fileName 文件存放路径的目录名称 默认：Default
 @param progressBlock 回调下载进度
 @param stateBlock 下载状态
 */
- (void)startTaskWithAttribute:(NSArray *)attribute fileName:(NSString *)fileName progress:(void(^)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress))progressBlock state:(void(^)(DownloadState state))stateBlock;

/**
 开始下载
 
 @param url 下载地址
 */
- (void)start:(NSString *)url;

/**
 暂停下载
 
 @param url 下载地址
 */
- (void)pause:(NSString *)url;

/**
 查询该资源的下载进度值
 
 @param url 下载地址
 @param fileName 文件存放的目录 默认：Default
 @return 返回下载进度值
 */
- (CGFloat)progress:(NSString *)url fileName:(NSString *)fileName;

/**
 获取该资源总大小
 
 @param url 下载地址
 @param fileName 该资源的存放目录 默认：Default
 @return 资源总大小
 */
- (NSInteger)fileTotalLength:(NSString *)url fileName:(NSString *)fileName;

/**
 获取总缓存大小
 
 @return 缓存大小 单位: MB
 */
- (CGFloat)getCacheSize;

/**
 判断该资源是否下载完成
 
 @param url 下载地址
 @param fileName 该资源的存放目录 默认：Default
 @return YES: 完成
 */
- (BOOL)isCompletion:(NSString *)url fileName:(NSString *)fileName;

/**
 判断该文件是否存在
 
 @param url 下载地址
 @param fileName 该资源的存放目录 默认：Default
 @return YES: 存在
 */
- (BOOL)isExistence:(NSString *)url fileName:(NSString *)fileName;

/**
 删除该资源
 
 @param url 下载地址
 @param fileName 存放的文件夹
 */
- (void)deleteFile:(NSString *)url fileName:(NSString *)fileName;

/**
 清空所有下载资源
 */
- (void)deleteAllFile;

/**
 获取文件存放路径（Documents）
 
 @return 沙盒路径
 */
- (NSString *)getFileRoute;

/**
 获取下载文件路径
 
 @param url 下载地址
 @param fileName 文件存放路径的目录名称 默认：Default
 @return 下载文件路径
 */
- (NSString *)getFileWithURL:(NSString *)url fileName:(NSString *)fileName;

/**
 获取下载文件的信息
 
 @param fileName 文件存放路径的目录名称 默认：Default
 @return 文件属性
 */
- (NSArray *)getAttribute:(NSString *)fileName;

/**
 暂停所有任务
 */
- (void)suspendAllTasks;

/**
 取消所有任务(非删除)
 */
- (void)cancelAllTasks;

@end
