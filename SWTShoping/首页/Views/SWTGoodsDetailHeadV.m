//
//  SWTGoodsDetailHeadV.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailHeadV.h"

@interface SWTGoodsDetailHeadV()

@end

@implementation SWTGoodsDetailHeadV

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgV = [[UIImageView alloc] init];

        self.imgV.userInteractionEnabled = YES;
        self.imgV.image = [UIImage imageNamed:@"369"];
        [self addSubview:self.imgV];
        self.imgV.layer.cornerRadius = 5;
        self.imgV.clipsToBounds = YES;
        
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.bottom.equalTo(self);
        }];
        
        
//        self.jinRuBt  =[[UIButton alloc] init];
//        [self.jinRuBt setBackgroundImage:[UIImage imageNamed:@"live_cj_bgleft"] forState:UIControlStateNormal];
//        [self.imgV addSubview:self.jinRuBt];
//        [self.jinRuBt setTitleColor:WhiteColor forState:UIControlStateNormal];
//        [self.jinRuBt setTitle:@" 进入直播间" forState:UIControlStateNormal];
//        self.jinRuBt.titleLabel.font = kFont(9);
//        
//        [self.jinRuBt mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.imgV).offset(-5);
//            make.width.equalTo(@(56));
//            make.height.equalTo(@21);
//            make.right.equalTo(self.imgV);
//        }];
        

        
        
        
        
        
        
        
        
        
    }
    
    return self;
}


//- (void)setvideVWithaudioStr:(NSString *)str {
//
//    self.videoV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW * 9/16)];
//    self.videoV.clipsToBounds = YES;
//
//    NSString *webVideoPath = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
//    NSURL *webVideoUrl = [NSURL URLWithString:webVideoPath];
//    //步骤2：创建AVPlayer
//    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:webVideoUrl];
//    self.avPlayer = avPlayer;
//    self.playVC = [[AVPlayerViewController alloc] init];
//    [self addChildViewController:self.playVC];
//    [self.videoV addSubview:self.playVC.view];
//    self.videoV.mj_h = ScreenW * 9/16;
//    self.playVC.view.frame = CGRectMake(0, 0, ScreenW, ScreenW * 9/16);
//    [self.videoV addSubview:self.playVC.view];
//    self.playVC.player = avPlayer;
//    [self  addSubview: self.videoV];
//
//
//}

@end
