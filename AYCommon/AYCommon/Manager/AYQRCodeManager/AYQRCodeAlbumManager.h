//
//  AYQRCodeAlbumManager.h
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AYQRCodeAlbumManager;

@protocol AYQRCodeAlbumManagerDelegate <NSObject>

@required

/**
 图片选择控制器取消按钮的点击回调方法
 
 @param albumManager QRCodeAlbumManager
 */
- (void)QRCodeAlbumManagerDidCancelWithImagePickerController:(AYQRCodeAlbumManager *)albumManager;

/**
 图片选择控制器选取图片完成之后的回调方法
 
 @param albumManager QRCodeAlbumManager
 @param result 获取的二维码数据
 */
- (void)QRCodeAlbumManager:(AYQRCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result;

@end

@interface AYQRCodeAlbumManager : NSObject

@property (nonatomic, weak) id<AYQRCodeAlbumManagerDelegate> delegate;
/** 判断相册访问权限是否授权 */
@property (nonatomic, assign) BOOL isPHAuthorization;

+ (instancetype)shareQRCodeAlbumManager;

/**
 从相册中读取二维码
 
 @param currentController 当前控制器
 */
- (void)readQRCodeFromAlbumWithCurrentController:(UIViewController *)currentController;

@end
