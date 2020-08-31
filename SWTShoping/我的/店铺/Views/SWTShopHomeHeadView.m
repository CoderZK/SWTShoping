//
//  SWTShopHomeHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopHomeHeadView.h"

@interface SWTShopHomeHeadView()<SDCycleScrollViewDelegate>


@end

@implementation SWTShopHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor clearColor];
        [self addsubViews];
        
    }
    
    return self;
}

- (void)addsubViews {
    
    self.headBt  =[[UIButton alloc] init];
    self.headBt.layer.cornerRadius = 22.5;
    self.headBt.clipsToBounds = YES;
    [self.headBt setBackgroundImage: [UIImage imageNamed:@"369"] forState:UIControlStateNormal];
    self.headBt.tag = 100;
    [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shopNameLB = [[UILabel alloc] init];
    self.shopNameLB.font = kFont(15);
    self.shopNameLB.textColor = WhiteColor;
    self.shopNameLB.text = @"货物优选";
    
//    self.typeLB = [[UILabel alloc] init];
//    self.typeLB.font = kFont(13);
//    self.typeLB.textColor = WhiteColor;
//    self.typeLB.text = @"好店";
    
    self.typeOneBt =[[UIButton alloc] init];
    [self.typeOneBt setImage:[UIImage imageNamed:@"kkrenzheng"] forState:UIControlStateNormal];
    self.typeOneBt.titleLabel.font = kFont(13);
    [self.typeOneBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    
    self.typeTwoBt =[[UIButton alloc] init];
    [self.typeTwoBt setImage:[UIImage imageNamed:@"kkrenzheng"] forState:UIControlStateNormal];
    self.typeTwoBt.titleLabel.font = kFont(13);
    [self.typeTwoBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    
    
    self.guanZhuBt  = [[UIButton alloc] init];
    self.guanZhuBt.layer.cornerRadius = 8;
    self.guanZhuBt.backgroundColor = RedColor;
    self.guanZhuBt.clipsToBounds = YES;
    self.guanZhuBt.tag = 101;
    [self.guanZhuBt setBackgroundImage:[UIImage imageNamed:@"Focus"] forState:UIControlStateNormal];
    [self.guanZhuBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.moenyLB = [[UILabel alloc] init];
    self.moenyLB.textColor = WhiteColor;
    self.moenyLB.font = kFont(14);
    self.moenyLB.textAlignment = NSTextAlignmentCenter;
    self.moenyLB.text = @"5000";
    
    UILabel * mmLB = [[UILabel alloc] init];
    mmLB.textColor = WhiteColor;
    mmLB.font = kFont(12);
    mmLB.textAlignment = NSTextAlignmentCenter;
    mmLB.text = @"店铺保证金";
    
    
    self.scoreLB = [[UILabel alloc] init];
    self.scoreLB.textColor = WhiteColor;
    self.scoreLB.font = kFont(14);
    self.scoreLB.textAlignment = NSTextAlignmentCenter;
    self.scoreLB.text = @"5.0";
    
    UILabel * ssLB = [[UILabel alloc] init];
    ssLB.textColor = WhiteColor;
    ssLB.font = kFont(12);
    ssLB.textAlignment = NSTextAlignmentCenter;
    ssLB.text = @"店铺评分";
    
    self.guanZhuNumberLB = [[UILabel alloc] init];
    self.guanZhuNumberLB.textColor = WhiteColor;
    self.guanZhuNumberLB.font = kFont(14);
    self.guanZhuNumberLB.textAlignment = NSTextAlignmentCenter;
    self.guanZhuNumberLB.text = @"5.0";
    
    UILabel * ggLB = [[UILabel alloc] init];
    ggLB.textColor = WhiteColor;
    ggLB.font = kFont(12);
    ggLB.textAlignment = NSTextAlignmentCenter;
    ggLB.text = @"关注";
    
    self.whiteView = [[UIView alloc] init];
    self.whiteView.backgroundColor = WhiteColor;
    
    UIImageView * imgV1  =[[UIImageView alloc] init];
    imgV1.image = [UIImage imageNamed:@"evaluation"];
    
    UIImageView * imgV2  =[[UIImageView alloc] init];
    imgV2.image = [UIImage imageNamed:@"sell"];
    
    UIImageView * imgV3  =[[UIImageView alloc] init];
    imgV3.image = [UIImage imageNamed:@"return"];
    
    self.pingjiascoreLB = [[UILabel alloc] init];
    self.pingjiascoreLB.textColor = CharacterColor70;
    self.pingjiascoreLB.font = kFont(12);
    self.pingjiascoreLB.textAlignment = NSTextAlignmentCenter;
    self.pingjiascoreLB.text = @"好评:99%";
    
    self.chengJiaoLB = [[UILabel alloc] init];
    self.chengJiaoLB.textColor = CharacterColor70;
    self.chengJiaoLB.font = kFont(12);
    self.chengJiaoLB.textAlignment = NSTextAlignmentCenter;
    self.chengJiaoLB.text = @"成交:99%";
    
    self.tuiHuoLB = [[UILabel alloc] init];
    self.tuiHuoLB.textColor = CharacterColor70;
    self.tuiHuoLB.font = kFont(12);
    self.tuiHuoLB.textAlignment = NSTextAlignmentCenter;
    self.tuiHuoLB.text = @"退货:0.01%";
    
    //WithFrame:CGRectMake(15 ,sstatusHeight + 44 + 10 , ScreenW - 30 , (ScreenW - 30) / 345 * 150)
    
    self.sdView = [[SDCycleScrollView alloc] init];
    self.sdView.delegate = self;
    self.sdView.layer.cornerRadius = 5;
    self.sdView.clipsToBounds = YES;
    self.sdView.pageControlDotSize = CGSizeMake(3, 3);
    self.sdView.currentPageDotColor = [UIColor orangeColor];
    self.sdView.pageDotColor = WhiteColor;
    self.sdView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593448860435&di=a67c99cb53194ed3a46b4440eb9b4a6f&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F14%2F75%2F01300000164186121366756803686.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593448860434&di=db4599d36d08cc02085266fac51d8518&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F56%2F12%2F01300000164151121576126282411.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593448860434&di=24fd23062bf7fecdf5d4068abdded977&imgtype=0&src=http%3A%2F%2Fa0.att.hudong.com%2F64%2F76%2F20300001349415131407760417677.jpg"];
    
    self.lebftBt = [[UIButton alloc] init];
    self.lebftBt.titleLabel.font = kFont(15);
    [self.lebftBt setTitleColor:RedColor forState:UIControlStateNormal];
    [self.lebftBt setTitle:@"竞拍 (18)" forState:UIControlStateNormal];
    self.lebftBt.tag = 102;
    [self.lebftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.rightBt = [[UIButton alloc] init];
    self.rightBt.titleLabel.font = kFont(15);
    [self.rightBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
    [self.rightBt setTitle:@"一口价 (98)" forState:UIControlStateNormal];
    self.rightBt.tag = 103;
    [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.headBt];
    [self addSubview:self.shopNameLB];
//    [self addSubview:self.typeLB];
    [self addSubview:self.guanZhuBt];
    [self addSubview:self.moenyLB];
    [self addSubview:self.scoreLB];
    [self addSubview:self.guanZhuNumberLB];
    
    [self addSubview:self.typeTwoBt];
    [self addSubview:self.typeOneBt];
    
    [self addSubview:mmLB];
    [self addSubview:ssLB];
    [self addSubview:ggLB];
    
  
    
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:imgV1];
    [self.whiteView addSubview:imgV2];
    [self.whiteView addSubview:imgV3];
    [self.whiteView addSubview:self.pingjiascoreLB];
    [self.whiteView addSubview:self.chengJiaoLB];
    [self.whiteView addSubview:self.tuiHuoLB];
    
    [self.whiteView addSubview:self.sdView];
    [self.whiteView addSubview:self.lebftBt];
    [self.whiteView addSubview:self.rightBt];
    
    [self.headBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@45);
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.equalTo(self.headBt.mas_right).offset(5);
        make.top.equalTo(self.headBt.mas_top).offset(2);
    }];
    
    [self.typeOneBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopNameLB.mas_left);
        make.height.equalTo(@17);
        make.top.equalTo(self.shopNameLB.mas_bottom).offset(5);

    }];
    
    [self.typeTwoBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeOneBt.mas_right).offset(10);
        make.height.equalTo(@17);
        make.top.equalTo(self.shopNameLB.mas_bottom).offset(5);

    }];

    [self.guanZhuBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@16);
        make.centerY.equalTo(self.shopNameLB.mas_centerY);
        make.width.equalTo(@42);
        make.right.equalTo(self).offset(-15);
    }];
    
    [self.moenyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenW/3));
        make.height.equalTo(@20);
        make.top.equalTo(self.headBt.mas_bottom).offset(10);
        make.left.equalTo(self);
    }];
    
    [mmLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenW/3));
        make.height.equalTo(@20);
        make.top.equalTo(self.moenyLB.mas_bottom).offset(0);
        make.left.equalTo(self);
    }];
    
    
    
    [self.scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenW/3));
        make.height.equalTo(@20);
        make.top.equalTo(self.headBt.mas_bottom).offset(10);
        make.left.equalTo(self.moenyLB.mas_right);
    }];
    
    [ssLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenW/3));
        make.height.equalTo(@20);
        make.top.equalTo(self.moenyLB.mas_bottom).offset(0);
        make.left.equalTo(self.scoreLB.mas_left);
    }];
    
    
    
    [self.guanZhuNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.equalTo(@(ScreenW/3));
           make.height.equalTo(@20);
           make.top.equalTo(self.headBt.mas_bottom).offset(10);
           make.left.equalTo(self.scoreLB.mas_right);
       }];
       
       [ggLB mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.equalTo(@(ScreenW/3));
           make.height.equalTo(@20);
           make.top.equalTo(self.moenyLB.mas_bottom).offset(0);
           make.left.equalTo(self.guanZhuNumberLB.mas_left);
       }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).offset(115);
    }];

   
    
    [imgV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView).offset(10);
        make.width.height.equalTo(@16);
        make.centerX.equalTo(self.pingjiascoreLB.mas_centerX);
    }];
    
    [self.pingjiascoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView);
        make.height.equalTo(@19);
        make.width.equalTo(@(ScreenW/3));
        make.top.equalTo(imgV1.mas_bottom);
    }];
    
    
    [imgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView).offset(10);
        make.width.height.equalTo(@16);
        make.centerX.equalTo(self.chengJiaoLB.mas_centerX);
    }];
    
    [self.chengJiaoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pingjiascoreLB.mas_right);
        make.height.equalTo(@19);
        make.width.equalTo(@(ScreenW/3));
        make.top.equalTo(imgV2.mas_bottom);
    }];
    
    [imgV3 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.whiteView).offset(10);
           make.width.height.equalTo(@16);
           make.centerX.equalTo(self.tuiHuoLB.mas_centerX);
       }];
       
       [self.tuiHuoLB mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.chengJiaoLB.mas_right);
           make.height.equalTo(@19);
           make.width.equalTo(@(ScreenW/3));
           make.top.equalTo(imgV3.mas_bottom);
       }];
    
    [self.sdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenW - 30));
        make.height.equalTo(@((ScreenW - 30) / 345 * 150));
        make.left.equalTo(self.whiteView).offset(15);
        make.top.equalTo(self.pingjiascoreLB.mas_bottom).offset(10);
    }];
    
    [self.lebftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sdView.mas_bottom).offset(5);
        make.height.equalTo(@40);
        make.right.equalTo(self.whiteView).offset(-(ScreenW/2+15));
        
    }];
    
    [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sdView.mas_bottom).offset(5);
        make.height.equalTo(@40);
        make.left.equalTo(self.whiteView).offset((ScreenW/2+15));
        
    }];
    
}

- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        
    }else if (button.tag == 101) {
        
    }else if (button.tag == 102) {
       [self.rightBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        [self.lebftBt setTitleColor:RedColor forState:UIControlStateNormal];
    }else if (button.tag == 103) {
        [self.lebftBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        [self.rightBt setTitleColor:RedColor forState:UIControlStateNormal];
    }
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag)];
       }
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(index)];
    }
    
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
    [self.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.shopNameLB.text = model.store_name;
    
    self.typeOneBt.hidden = self.typeTwoBt.hidden = YES;
    NSArray * arr = [model getTypeLBArr];
    if (arr.count > 0) {
        self.typeOneBt.hidden = NO;
        [self.typeOneBt setTitle: [NSString stringWithFormat:@" %@",arr[0]] forState:UIControlStateNormal];
        
    }
    if (arr.count > 1) {
        self.typeTwoBt.hidden = NO;
        [self.typeTwoBt setTitle: [NSString stringWithFormat:@" %@",arr[1]] forState:UIControlStateNormal];
    }
    self.scoreLB.text = model.merchscore;
    self.guanZhuNumberLB.text = [model.focusnum getPriceStr];
    self.moenyLB.text = [model.margin getPriceStr];
    
    self.pingjiascoreLB.text =  [NSString stringWithFormat:@"好评:%@%%",model.goodper];
    self.chengJiaoLB.text = [NSString stringWithFormat:@"成交:%@%%",model.successper];
    self.chengJiaoLB.text = [NSString stringWithFormat:@"退货:%@%%",model.backper];
    
    NSMutableArray * imgGroupArr = @[].mutableCopy;
    for (SWTModel *neiM  in model.lideshowlist) {
        [imgGroupArr addObject:neiM.pic];
    }
    self.sdView.imageURLStringsGroup = imgGroupArr;
     if ([model.isfollow isEqualToString:@"yes"]) {
           [self.guanZhuBt setBackgroundImage:[UIImage imageNamed:@"dyx24"] forState:UIControlStateNormal];
       }else {
          [self.guanZhuBt setBackgroundImage:[UIImage imageNamed:@"Focus"] forState:UIControlStateNormal];
       }
    
    [self.lebftBt setTitle: [NSString stringWithFormat:@"竞拍(%ld)",(long)model.auctiongoodnum] forState:UIControlStateNormal];
    [self.rightBt setTitle: [NSString stringWithFormat:@"一口价(%ld)",(long)model.pricegoodnum] forState:UIControlStateNormal];
}


@end
