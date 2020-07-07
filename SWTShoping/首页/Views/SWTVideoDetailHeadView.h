//
//  SWTVideoDetailHeadView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SWTVideoDetailHeadView : UIView
@property(nonatomic,strong)UIView *videoV;
@property(nonatomic,strong)AVPlayerViewController *playVC;
@property(nonatomic,strong)AVPlayer * avPlayer;

@end

NS_ASSUME_NONNULL_END
