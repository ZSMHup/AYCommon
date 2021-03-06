//
//  AYQRCodeScanManager.m
//  AYCommon
//
//  Created by 张书孟 on 2018/5/16.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "AYQRCodeScanManager.h"
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

@interface AYQRCodeScanManager() <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation AYQRCodeScanManager 

static AYQRCodeScanManager *_instance;

+ (instancetype)shareQRCodeScanManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark pr
- (void)creatSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController
{
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2、创建设备输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    // 3、创建数据输出流
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 3(1)、创建设备输出流
    _videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围（每一个取值0～1，以屏幕右上角为坐标原点）
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）; 如需限制扫描范围，打开下一句注释代码并进行相应调试
    //    metadataOutput.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 4、创建会话对象
    _session = [[AVCaptureSession alloc] init];
    // 会话采集率: AVCaptureSessionPresetHigh
    _session.sessionPreset = sessionPreset;
    
    // 5、添加设备输出流到会话对象
    [_session addOutput:metadataOutput];
    // 5(1)添加设备输出流到会话对象；与 3(1) 构成识别光线强弱
    [_session addOutput:_videoDataOutput];
    
    // 6、添加设备输入流到会话对象
    [_session addInput:deviceInput];
    
    // 7、设置数据输出类型，需要将数据输出添加到会话后，才能指定元数据类型，否则会报错
    metadataOutput.metadataObjectTypes = metadataObjectTypes;
    
    // 8、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    // 保持纵横比；填充层边界
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    _videoPreviewLayer.frame = CGRectMake(x, y, w, h);
    [currentController.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}

#pragma mark Public
- (void)setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController
{
    
    if (sessionPreset == nil) {
        NSException *excp = [NSException exceptionWithName:@"SGQRCode" reason:@"setupSessionPreset:metadataObjectTypes:currentController: 方法中的 sessionPreset 参数不能为空" userInfo:nil];
        [excp raise];
    }
    
    if (metadataObjectTypes == nil) {
        NSException *excp = [NSException exceptionWithName:@"SGQRCode" reason:@"setupSessionPreset:metadataObjectTypes:currentController: 方法中的 metadataObjectTypes 参数不能为空" userInfo:nil];
        [excp raise];
    }
    
    if (currentController == nil) {
        NSException *excp = [NSException exceptionWithName:@"SGQRCode" reason:@"setupSessionPreset:metadataObjectTypes:currentController: 方法中的 currentController 参数不能为空" userInfo:nil];
        [excp raise];
    }
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self creatSessionPreset:sessionPreset metadataObjectTypes:metadataObjectTypes currentController:currentController];
                    });
                    // 用户第一次同意了访问相机权限
                    //NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                
                } else {
                    // 用户第一次拒绝了访问相机权限
                    // NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [currentController.navigationController popViewControllerAnimated:YES];
                    });
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            
            [self creatSessionPreset:sessionPreset metadataObjectTypes:metadataObjectTypes currentController:currentController];
            
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *executableFile = [infoDictionary objectForKey:(NSString *)kCFBundleExecutableKey];
            
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"相机权限未开启" message:[NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@] 打开访问开关",executableFile] preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [currentController.navigationController popViewControllerAnimated:YES];
            }];
            
            [alertC addAction:alertA];
            [currentController presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [currentController.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertC addAction:alertA];
        [currentController presentViewController:alertC animated:YES completion:nil];
    }
}

//开启会话对象扫描
- (void)startRunning
{
    [_session startRunning];
}

//停止会话对象扫描
- (void)stopRunning
{
    [_session stopRunning];
    //    _session = nil;
}

//移除 videoPreviewLayer 对象
- (void)videoPreviewLayerRemoveFromSuperlayer
{
    [_videoPreviewLayer removeFromSuperlayer];
}

//重置根据光线强弱值打开手电筒的 delegate 方法
- (void)resetSampleBufferDelegate
{
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
}

//取消根据光线强弱值打开手电筒的 delegate 方法
- (void)cancelSampleBufferDelegate
{
    [_videoDataOutput setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];
}

//播放音效文件
- (void)palySoundName:(NSString *)name
{
    if (!name) {
        name = @"sound.caf";
    }
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID); // 播放音效
    
}

//打开手电筒
- (void)openFlashlight
{
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    if ([captureDevice hasTorch]) {
        BOOL locked = [captureDevice lockForConfiguration:&error];
        if (locked) {
            captureDevice.torchMode = AVCaptureTorchModeOn;
            [captureDevice unlockForConfiguration];
        }
    }
}
//关闭手电筒
- (void)closeFlashlight
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeScanManager:didOutputMetadataObjects:)]) {
        [self.delegate QRCodeScanManager:self didOutputMetadataObjects:metadataObjects];
    }
}

#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate的方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeScanManager:brightnessValue:)]) {
        [self.delegate QRCodeScanManager:self brightnessValue:brightnessValue];
    }
}

void soundCompleteCallback(SystemSoundID soundID, void *clientData){}

@end
