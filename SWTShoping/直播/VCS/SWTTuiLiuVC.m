//
//  SWTTuiLiuVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiLiuVC.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
@interface SWTTuiLiuVC ()
@property (nonatomic, strong) PLMediaStreamingSession *session;
@end

@implementation SWTTuiLiuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    button.backgroundColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    
    videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    

    
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
 
    
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];
    
    
    [self.view addSubview:self.session.previewView];
}

- (void)action {
    
    NSURL *pushURL = [NSURL URLWithString:@"rtmp://pili-publish.xunshun.net/diyuxuan6188/11598953718395A?e=1599021506&token=KHCzbpIL_mUAG8Dh5MZxFb9ahViYoMiSnVbTqwvx:C9R_CsByspLsHedPDXRoCa0OeAw="];
    [self.session startStreamingWithPushURL:pushURL feedback:^(PLStreamStartStateFeedback feedback) {
           if (feedback == PLStreamStartStateSuccess) {
               NSLog(@"Streaming started.");
           }
           else {
               NSLog(@"Oops.");
           }
    }];
    
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
