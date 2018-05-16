//
//  AYFileSessionModel.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    DownloadStateStart = 0,     /** 下载中 */
    DownloadStateSuspended,     /** 下载暂停 */
    DownloadStateCompleted,     /** 下载完成 */
    DownloadStateFailed         /** 下载失败 */
}DownloadState;

@interface AYFileSessionModel : NSObject

/** 流 */
@property (nonatomic, strong) NSOutputStream *stream;
/** 下载地址 */
@property (nonatomic, copy) NSString *url;
/** 获得服务器这次请求 返回数据的总长度 */
@property (nonatomic, assign) NSInteger totalLength;
/** 可以存储一些文件属性 */
@property (nonatomic, copy) NSDictionary *attribute;
/** 下载进度 */
@property (nonatomic, copy) void(^progressBlock)(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress);
/** 下载状态 */
@property (nonatomic, copy) void(^stateBlock)(DownloadState state);

@end
