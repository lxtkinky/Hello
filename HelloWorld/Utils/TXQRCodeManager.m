//
//  TXQRCodeManager.m
//  TestDemo003
//
//  Created by ken on 2018/5/8.
//  Copyright © 2018年 lixt. All rights reserved.
//

#import "TXQRCodeManager.h"
#import <AVFoundation/AVFoundation.h>

@interface TXQRCodeManager()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation TXQRCodeManager

+ (instancetype)qrCodeManager{
    return [[[self class] alloc] init];
}

- (void)scanQRCodeAtView:(UIView *)view{
    if (!_session) {
        //获取摄像设备
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //创建输入流
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        if (!input) return;
        //创建输出流
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        //设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //设置有效扫描区域
        CGRect scanCrop = CGRectMake(0, 0, 1, 1);
        output.rectOfInterest = scanCrop;
        //初始化链接对象
        _session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        [_session addInput:input];
        [_session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    self.previewLayer = layer;
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = view.layer.bounds;
    [view.layer insertSublayer:layer atIndex:0];
    //开始捕获
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    NSLog(@"metadata = %@", metadataObjects);
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *object = [metadataObjects firstObject];
        NSLog(@"string value = %@", object.stringValue);
        [_session stopRunning];
        [self.previewLayer removeFromSuperlayer];
    }
}

- (NSMutableArray *)scanQRCodeFromImage:(UIImage *)image{
    //(CIDetector可用于人脸识别)
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < features.count; i++) {
        CIQRCodeFeature *feature = [features objectAtIndex:i];
        NSString *scanResult = feature.messageString;
        NSLog(@"QRCode Str = %@", scanResult);
        [array addObject:scanResult];
    }
    return array;
}

- (UIImage *)createQRCodeWithString:(NSString *)string{
    CIImage *ciImage = [self creatQRcodeWithString:string];
//    UIImage *image = [UIImage imageWithCIImage:ciImage];  //图片模糊
    UIImage *image = [self changeImageSizeWithCIImage:ciImage andSize:200]; //生成清晰的图片
    return image;
}

- (UIImage *)createQRCodeWithString:(NSString *)string size:(CGFloat)size{
    CIImage *ciImage = [self creatQRcodeWithString:string];
    //    UIImage *image = [UIImage imageWithCIImage:ciImage];  //图片模糊
    UIImage *image = [self changeImageSizeWithCIImage:ciImage andSize:size]; //生成清晰的图片
    return image;
}

- (CIImage *)creatQRcodeWithString:(NSString *)str{
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [str dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}

/**
 *  改变图片大小 (正方形图片)
 *
 *  @param ciImage 需要改变大小的CIImage 对象的图片
 *  @param size    图片大小 (正方形图片 只需要一个数)
 *
 *  @return 生成的目标图片
 */
- (UIImage *)changeImageSizeWithCIImage:(CIImage *)ciImage andSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

@end
