//
//  BCMScanViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/3/12.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMScanViewController.h"
#import <AVFoundation/AVFoundation.h>

static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";

@interface BCMScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIView *ui_sanFrameView;

@property (nonatomic) AVCaptureSession *m_captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *m_videoPreviewLayer;

- (IBAction)backButtonAction:(id)sender;

@end

@implementation BCMScanViewController

- (void)startScan
{
    // 获取 AVCaptureDevice 实例
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
//        return NO;
    }
    // 创建会话
    self.m_captureSession = [[AVCaptureSession alloc] init];
    // 添加输入流
    [self.m_captureSession addInput:input];
    // 初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // 添加输出流
    [self.m_captureSession addOutput:captureMetadataOutput];
    
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // 创建输出对象
    self.m_videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.m_captureSession];
    [self.m_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.m_videoPreviewLayer setFrame:self.ui_sanFrameView.layer.bounds];
    [self.ui_sanFrameView.layer addSublayer:self.m_videoPreviewLayer];
    // 开始会话
    [self.m_captureSession startRunning];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startScan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)stopReading
{
    [self.m_captureSession stopRunning];
    self.m_captureSession = nil;
}

- (void)reportScanResult:(NSString *)result
{
//    [self stopReading];
//    if (!_lastResut) {
//        return;
//    }
//    _lastResut = NO;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"二维码扫描"
//                                                    message:result
//                                                   delegate:nil
//                                          cancelButtonTitle:@"取消"
//                                          otherButtonTitles: nil];
//    [alert show];
//    // 以及处理了结果，下次扫描
//    _lastResut = YES;
}

#pragma AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
        } else {
            NSLog(@"不是二维码");
        }
        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO];
    }
}

@end
