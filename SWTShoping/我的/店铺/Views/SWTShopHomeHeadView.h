//
//  SWTShopHomeHeadView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTShopHomeHeadView : UIView

@property(nonatomic , strong)UIView *whiteView;
@property(nonatomic , strong)UIButton *headBt,*guanZhuBt,*lebftBt,*rightBt,*typeOneBt,*typeTwoBt;
@property(nonatomic , strong)UILabel *shopNameLB,*typeLB,*moenyLB,*scoreLB,*guanZhuNumberLB,*pingjiascoreLB,*chengJiaoLB,*tuiHuoLB;
@property(nonatomic , strong)SDCycleScrollView *sdView;

@property (nonatomic, strong) RACSubject *delegateSignal;
@property(nonatomic , strong)SWTModel *model;


@end

NS_ASSUME_NONNULL_END
