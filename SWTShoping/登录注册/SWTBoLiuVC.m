//
//  SWTBoLiuVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/1.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTBoLiuVC.h"
#import <PLPlayerKit/PLPlayerKit.h>
@interface SWTBoLiuVC ()<PLPlayerDelegate>
@property (nonatomic, strong) PLPlayer  *player;
@end

@implementation SWTBoLiuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    [option setOptionValue:@2000 forKey:PLPlayerOptionKeyMaxL1BufferDuration];
    [option setOptionValue:@1000 forKey:PLPlayerOptionKeyMaxL2BufferDuration];
    [option setOptionValue:@(NO) forKey:PLPlayerOptionKeyVideoToolbox];
    [option setOptionValue:@(kPLLogInfo) forKey:PLPlayerOptionKeyLogLevel];
    NSURL *url = [NSURL URLWithString:@"http://pili-live-hls.xunshun.net/diyuxuan6188/2.m3u8?sign=403319a2d779adde70abdc50ddf79a2d&t=5f4f125d"];
    
   
    
    self.player = [PLPlayer playerWithURL:url option:option];
    
    self.player.delegate = self;
    
    [self.view addSubview:self.player.playerView];
    
    [self.player play];
  
}

/**
 告知代理对象 PLPlayer 即将开始进入后台播放任务
 
 @param player 调用该代理方法的 PLPlayer 对象
 
 @since v1.0.0
 */
- (void)playerWillBeginBackgroundTask:(nonnull PLPlayer *)player{
    NSLog(@"%@",@"00002334");
}

/**
 告知代理对象 PLPlayer 即将结束后台播放状态任务
 
 @param player 调用该方法的 PLPlayer 对象
 
 @since v2.1.1
 */
- (void)playerWillEndBackgroundTask:(nonnull PLPlayer *)player{
    NSLog(@"%@",@"11112334");
}

/**
 告知代理对象播放器状态变更
 
 @param player 调用该方法的 PLPlayer 对象
 @param state  变更之后的 PLPlayer 状态
 
 @since v1.0.0
 */
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state{
    NSLog(@"%@",@"2334");
}

/**
 告知代理对象播放器因错误停止播放
 
 @param player 调用该方法的 PLPlayer 对象
 @param error  携带播放器停止播放错误信息的 NSError 对象
 
 @since v1.0.0
 */
- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error{
    NSLog(@"%@",error);
    
    
}

/**
 点播已缓冲区域
 
 @param player 调用该方法的 PLPlayer 对象
 @param timeRange  CMTime , 表示从0时开始至当前缓冲区域，单位秒。
 
 @warning 仅对点播有效
 
 @since v2.4.1
 */
- (void)player:(nonnull PLPlayer *)player loadedTimeRange:(CMTime)timeRange{
    NSLog(@"%@",@"44442334");
}

/**
 回调将要渲染的帧数据
 该功能只支持直播
 
 @param player 调用该方法的 PLPlayer 对象
 @param frame 将要渲染帧 YUV 数据。
 CVPixelBufferGetPixelFormatType 获取 YUV 的类型。
 软解为 kCVPixelFormatType_420YpCbCr8Planar.
 硬解为 kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange.
 @param pts 显示时间戳 单位ms
 @param sarNumerator
 @param sarDenominator
 其中sar 表示 storage aspect ratio
 视频流的显示比例 sarNumerator sarDenominator
 @discussion sarNumerator = 0 表示该参数无效
 
 @since v2.4.3
 */
- (void)player:(nonnull PLPlayer *)player willRenderFrame:(nullable CVPixelBufferRef)frame pts:(int64_t)pts sarNumerator:(int)sarNumerator sarDenominator:(int)sarDenominator{
    NSLog(@"%@",@"55552334");
}



@end
