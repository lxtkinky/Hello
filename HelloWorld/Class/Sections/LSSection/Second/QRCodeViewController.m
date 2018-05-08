//
//  QRCodeViewController.m
//  HelloWorld
//
//  Created by ken on 2018/5/7.
//  Copyright © 2018年 Sheng Yuan Technology. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TXQRCodeManager.h"

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
//
//@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
//@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) TXQRCodeManager *manager;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"识别二维码" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self testQRCode];
    }];
    
}

- (void)testQRCode{
    UIView *qrView = [[UIView alloc] init];
    qrView.frame = CGRectMake(100, 200, 200, 200);
    [self.view addSubview:qrView];
    
    
    TXQRCodeManager *manager = [TXQRCodeManager qrCodeManager];
    self.manager = manager;
    //扫码二维码
    [manager scanQRCodeAtView:qrView];

//    //识别图片
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"timg" ofType:@"jpeg"];
//    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//    NSArray *array = [manager scanQRCodeFromImage:image];
//    NSLog(@"array = %@", array);
//
//    //生成二维码图片
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = qrView.frame;
//    [self.view addSubview:imageView];
//    imageView.image = [manager createQRCodeWithString:@"http://www.baidu.com"];
}

//- (void)distQRCode{
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
//    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
//    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
//    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//    AVCaptureSession *session = [[AVCaptureSession alloc] init];
//    [session addInput:input];
//    [session addOutput:output];
//    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
//    self.session = session;
//
//    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
//    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    layer.frame = CGRectMake(100, 100, 100, 100);
//    [self.view.layer insertSublayer:layer atIndex:100];
//    [session startRunning];
//    self.previewLayer = layer;
//}
//
////解析图片二维码
//- (void)scanQRCodeFromPhoto:(UIImage *)image{
//    //(CIDetector可用于人脸识别)
//    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
//    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
//    for (int i = 0; i < features.count; i++) {
//        CIQRCodeFeature *feature = [features objectAtIndex:i];
//        NSString *scanResult = feature.messageString;
//        NSLog(@"QRCode Str = %@", scanResult);
//    }
//
//}
//
//- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
//    NSLog(@"metadata = %@", metadataObjects);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
