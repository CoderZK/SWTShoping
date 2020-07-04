//
//  SWTGoodsDetailHeadV.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SWTGoodsDetailHeadV : UIView
@property(nonatomic , strong)UIImageView *imgV;
@property(nonatomic , strong)UIButton *jinRuBt;

@property(nonatomic,strong)UIView *videoV;
@property(nonatomic,strong)AVPlayerViewController *playVC;
@property(nonatomic,strong)AVPlayer * avPlayer;


@end

NS_ASSUME_NONNULL_END
