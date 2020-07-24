//
//  SWTGoodsDetailChuJiaView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailChuJiaView.h"

@interface SWTGoodsDetailChuJiaView()
@property(nonatomic , strong)UIView *whiteV;

@end

@implementation SWTGoodsDetailChuJiaView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
       
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 250)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 40, 0, 40, 40)];
               [button1 setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
               [button1 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
               [self.whiteV addSubview:button1];
        
        
        
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, ScreenW, 17)];
        lb.font = kFont(14);
        lb.textColor = CharacterColor50;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"宝贝很抢手, 尽快出价哦";
        [self.whiteV addSubview:lb];
        
        
        self.moneyLB = [[UILabel alloc] init];
        self.moneyLB.font = kFont(15);
        self.moneyLB.textColor = RedLightColor;
        self.moneyLB.text = @"3300";
        [self.whiteV addSubview:lb];
        
        UIView * moenyV  =[[UIView alloc] init];
        [self.whiteV addSubview:moenyV];
        
        [moenyV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.whiteV);
            make.height.equalTo(@20);
            make.top.equalTo(lb.mas_bottom).offset(5);
            
        }];
        
        UILabel * lb2 = [[UILabel alloc] init];
        lb2.font = kFont(15);
        lb2.textColor = CharacterColor50;
        lb2.textAlignment = NSTextAlignmentCenter;
        lb2.text = @"最新价格: ";
        [moenyV addSubview:lb2];
        [moenyV addSubview:self.moneyLB];
        
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(moenyV);
        }];
        
        [self.moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.top.equalTo(moenyV);
            make.left.equalTo(lb2.mas_right);
        }];
        
        self.moneyBt = [[UIButton alloc] init];
        [self.moneyBt setBackgroundImage:[UIImage imageNamed:@"price3"] forState:UIControlStateNormal];
        [self.moneyBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        [self.moneyBt setTitle:@"   222334  " forState:UIControlStateNormal];
        [self.whiteV addSubview:self.moneyBt];
        self.moneyBt.titleLabel.font = kFont(15);
        
        [self.moneyBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(moenyV.mas_bottom).offset(30);
            make.height.equalTo(@45);
            make.width.equalTo(@120);
            make.centerX.equalTo(self.whiteV);
            
        }];
        
        
        self.chujiaBt = [[UIButton alloc] init];
        self.chujiaBt.tag = 102;
        [self.chujiaBt setTitle:@"加一手" forState:UIControlStateNormal];
        self.chujiaBt.titleLabel.font = kFont(14);
        [self.chujiaBt setBackgroundImage:[UIImage imageNamed:@"rbg"] forState:UIControlStateNormal];
        [self.whiteV addSubview:self.chujiaBt];
        
        [self.chujiaBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.moneyBt.mas_bottom).offset(20);
            make.left.equalTo(self.whiteV).offset(20);
            make.right.equalTo(self.whiteV).offset(-20);
            make.height.equalTo(@35);
        }];
        
        
        
    }
    
    return self;
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 250;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
