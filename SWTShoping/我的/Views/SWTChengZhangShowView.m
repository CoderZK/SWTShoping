//
//  SWTChengZhangShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTChengZhangShowView.h"

@interface SWTChengZhangShowView()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIScrollView *scrollView;
@property(nonatomic , strong)UIView *whiteTwo;


@end


@implementation SWTChengZhangShowView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.1];
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(20, 40, ScreenW - 40, ScreenH - 80)];
        [self addSubview:self.whiteV];
        
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.clipsToBounds = YES;
        self.whiteV.backgroundColor = [UIColor whiteColor];
        
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.whiteV addSubview:self.scrollView];
        self.scrollView.frame = CGRectMake(10, 15, ScreenW - 40 -20, ScreenH - 80 - 30 - 50);
        
        [self addSubV];
        
        UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) + 5 , ScreenW - 40, 40)];
        [button setTitle:@"我知道了" forState:UIControlStateNormal];
        [self.whiteV addSubview:button];
        [button setTitleColor:RedColor forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];

        
        
    }
    return self;
}

- (void)addSubV {
    CGFloat ww = ScreenW - 60;
    UILabel * titleLB  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ww, 20)];
    titleLB.textAlignment = NSTextAlignmentCenter;
    titleLB.font = [UIFont systemFontOfSize:16 weight:0.3];
    titleLB.text = @"成长值规则";
    [self.scrollView addSubview:titleLB];
    
    UILabel * LB1  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLB.frame)+ 10, ww, 20)];
    LB1.font = [UIFont systemFontOfSize:15 weight:0.2];
    LB1.text = @"·成长值获取规则";
    [self.scrollView addSubview:LB1];
    
    
    UILabel * LB2  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB1.frame)+ 10, ww, 20)];
    LB2.font = [UIFont systemFontOfSize:14 ];
    LB2.text = @"确认收货后次日可以获取成长值";
    LB2.mj_h = [LB2.text getHeigtWithFontSize:14 lineSpace:0 width:ww];
    LB2.textColor = RedLightColor;
    LB2.numberOfLines = 0;
    [self.scrollView addSubview:LB2];
    
    
    UILabel * LB3  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB2.frame)+5, ww, 20)];
    LB3.font = [UIFont systemFontOfSize:14];
    LB3.text = @"确认收货:获取成长值=拍品线上支付金额/12,取整。单笔订单线上支付金额≥10元可获取成长值，且最少获取1成长值。";
    LB3.mj_h = [LB3.text getHeigtWithFontSize:14 lineSpace:0 width:ww];
    LB3.textColor = CharacterColor70;
    LB3.numberOfLines = 0;
    [self.scrollView addSubview:LB3];
    
    
    UILabel * LB4  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB3.frame)+ 15, ww, 20)];
    LB4.font = [UIFont systemFontOfSize:15 weight:0.2];
    LB4.text = @"·成长值扣减规则";
    [self.scrollView addSubview:LB4];
    
    UILabel * LB5  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB4.frame)+10, ww, 20)];
    LB5.font = [UIFont systemFontOfSize:14];
    LB5.text = @"违约:扣减成长值=拍品成交金额/12，取整后乘以2(单笔订单最少扣减2成长若当前成长值≤-100分，则不再扣成长值过期:将扣减相应成长值。退货:若订单退货，将扣减相应成长值。";
    LB5.mj_h = [LB3.text getHeigtWithFontSize:14 lineSpace:0 width:ww];
    LB5.textColor = CharacterColor70;
    LB5.numberOfLines = 0;
    [self.scrollView addSubview:LB5];
    
    UILabel * LB6  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB5.frame)+ 15, ww, 20)];
    LB6.font = [UIFont systemFontOfSize:15 weight:0.2];
    LB6.text = @"·成长值有效期";
    [self.scrollView addSubview:LB6];
    
    
    UILabel * LB7  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB6.frame)+10, ww, 20)];
    LB7.font = [UIFont systemFontOfSize:14];
    LB7.text = @"365天";
    LB7.mj_h = [LB7.text getHeigtWithFontSize:14 lineSpace:0 width:ww];
    LB7.textColor = CharacterColor70;
    LB7.numberOfLines = 0;
    [self.scrollView addSubview:LB7];
    
    UILabel * LB8  = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB7.frame)+ 15, ww, 20)];
    LB8.font = [UIFont systemFontOfSize:15 weight:0.2];
    LB8.text = @"·会员等级与成长值";
    [self.scrollView addSubview:LB8];
    
    
    self.whiteTwo = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(LB8.frame) + 15, ww, 20)];
    [self.scrollView addSubview:self.whiteTwo];
    
    
    
}

- (void)setLeverArr:(NSMutableArray<SWTModel *> *)leverArr {
    _leverArr = leverArr;
    
    CGFloat ww = ScreenW - 60;
    [self.whiteTwo.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.whiteTwo.mj_h = 50 * leverArr.count + 50;
    
    self.scrollView.contentSize = CGSizeMake(ww, CGRectGetMaxY(self.whiteTwo.frame) + 10);
    
    
    for (int i = 0 ; i < 4; i++) {
        UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.3,50 * leverArr.count + 50)];
        lineV.backgroundColor = lineBackColor;
        [self.whiteTwo addSubview:lineV];
        if (i == 0) {
            lineV.mj_x = 0;
        }else if (i == 1) {
            lineV.mj_x = ww/9.0 * 3;
        }else if (i == 2) {
            lineV.mj_x = ww/9.0 * 5;
        }else {
            lineV.mj_x = ww-0.3;
        }
    }
    NSString * str = @"0";
    NSString * str2 = @"0";
    for (int i = 0 ; i <= leverArr.count + 1; i++) {
        UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(0, i*50, ww, 0.3)];
        lineV.backgroundColor = lineBackColor;
        [self.whiteTwo addSubview:lineV];
        UILabel * centerLB = [[UILabel alloc]  initWithFrame:CGRectMake(ww/9.0* 3 + 2, 10+i*50, ww/9.0* 2 -4, 30)];
        centerLB.textColor = [UIColor blackColor];
        centerLB.textAlignment = NSTextAlignmentCenter;
        centerLB.font = kFont(15);
        centerLB.text = @"称号";
        [self.whiteTwo addSubview:centerLB];

        UILabel * rightLB = [[UILabel alloc]  initWithFrame:CGRectMake(ww/9.0* 5 + 2, 10+i*50, ww/9.0* 4 -4, 30)];
        rightLB.textColor = [UIColor blackColor];
        rightLB.textAlignment = NSTextAlignmentCenter;
        rightLB.font = kFont(15);
        rightLB.text = @"对应成长值";
        [self.whiteTwo addSubview:rightLB];

        if (i == 0) {
            UILabel * centerLB = [[UILabel alloc]  initWithFrame:CGRectMake(2, 10+i*50, ww/9.0*3 -4, 30)];
            centerLB.textColor = [UIColor blackColor];
            centerLB.textAlignment = NSTextAlignmentCenter;
            centerLB.font = kFont(15);
            centerLB.text = @"会员等级";
            [self.whiteTwo addSubview:centerLB];
        }else if (i < leverArr.count + 1){

            UIButton * leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 16+i*50, 40, 18)];
            leftBt.clipsToBounds = YES;
            leftBt.layer.cornerRadius = 9;
            leftBt.titleLabel.font = kFont(13);
            [leftBt setTitleColor:WhiteColor forState:UIControlStateNormal];
            [leftBt setTitle: [NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            [leftBt setImage:[UIImage imageNamed:@"vip"] forState:UIControlStateNormal];
            [leftBt setBackgroundImage:[UIImage imageNamed:@"rbg"] forState:UIControlStateNormal];
            [self.whiteTwo addSubview:leftBt];
            leftBt.width = [[NSString stringWithFormat:@"%d",i] getWidhtWithFontSize:13] + 30;
            leftBt.centerX = ww/9.0 *1.5;

            centerLB.font = rightLB.font = kFont(14);
            centerLB.textColor = rightLB.textColor = CharacterColor70;
            str2 = leverArr[i-1].growth_value;

            rightLB.text =  [NSString stringWithFormat:@"%@ ~ %@",str,str2];
            str = leverArr[i-1].growth_value;

            centerLB.text = leverArr[i-1].name;


        }else {
            rightLB.hidden = centerLB.hidden = YES;
        }
    }
    
    
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
