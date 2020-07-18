//
//  SWTVideoDetailHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTVideoDetailHeadView.h"

@implementation SWTVideoDetailHeadView

//https://vedio.hkymr.com/2020032720464113343034051783.MP4

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.videoV = [[UIView alloc] init];
        self.videoV.clipsToBounds = YES;

        NSString *webVideoPath = [@"" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
        //步骤2：创建AVPlayer
        AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
        self.avPlayer = avPlayer;
        self.playVC = [[AVPlayerViewController alloc] init];
        [self.videoV addSubview:self.playVC.view];
        self.videoV.mj_h = ScreenW * 9/16;
        [self.videoV addSubview:self.playVC.view];
        self.playVC.player = avPlayer;
        [self  addSubview: self.videoV];
        
        [self.videoV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.right.bottom.equalTo(self).offset(-10);
        }];
        
        [self.playVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.videoV);
        }];

        
    }
    
    return self;
}

- (void)setvideVWithaudioStr:(NSString *)str {

    NSString *webVideoPath = [@"https://vedio.hkymr.com/2020032720464113343034051783.MP4" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
           NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];

    self.avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
}

- (void)setVideoStr:(NSString *)videoStr {
    _videoStr = videoStr;
    
    NSString *webVideoPath = [@"https://vedio.hkymr.com/2020032720464113343034051783.MP4" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
           NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];

    self.avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
    
}

@end
