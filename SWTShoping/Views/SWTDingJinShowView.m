//
//  SWTDingJinShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTDingJinShowView.h"

@interface SWTDingJinShowView()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIButton *moneyBt;

@end

@implementation SWTDingJinShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(30, (ScreenH -230)/2-30, ScreenW - 60, 250)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.clipsToBounds = YES;
        
        
        UIButton * closeBt  =[[UIButton alloc] init];
        [closeBt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [closeBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:closeBt];
        
        
        UILabel * titleLB  =[[UILabel alloc] init];
        titleLB.font = kFont(15);
        titleLB.text = @"定金说明";
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self.whiteV addSubview:titleLB];
        
        UILabel * lb1  =[[UILabel alloc] init];
        lb1.font = kFont(14);
        lb1.text = @"1. 支付定金为货款30%";
        lb1.textColor = CharacterColor50;
//        lb1.textAlignment = NSTextAlignmentCenter;
        [self.whiteV addSubview:lb1];
        
        UILabel * lb2  =[[UILabel alloc] init];
        lb2.font = kFont(14);
        lb2.text = @"2. 尾款需要再48小时内支付";
        lb2.textColor = CharacterColor50;
//        lb2.textAlignment = NSTextAlignmentCenter;
        [self.whiteV addSubview:lb2];
        
        UIButton * confirmBt  =[[UIButton alloc] init];
        [confirmBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [confirmBt setBackgroundColor:RedColor];
        confirmBt.titleLabel.font = kFont(15);
        confirmBt.layer.cornerRadius = 22.5;
        confirmBt.clipsToBounds = YES;
        [confirmBt setTitle:@"确认" forState:UIControlStateNormal];
        [self.whiteV addSubview:confirmBt];
        
         
        
        
        
        
        [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.right.equalTo(self.whiteV).offset(-5);
            make.top.equalTo(self.whiteV).offset(5);
        }];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(closeBt.mas_bottom).offset(10);
            make.left.right.equalTo(self.whiteV);
            make.height.equalTo(@20);
        }];
        
        [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLB.mas_bottom).offset(30);
            make.left.right.equalTo(self.whiteV).offset(40);
            make.height.equalTo(@20);
        }];
        
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lb1.mas_bottom).offset(10);
            make.left.right.equalTo(self.whiteV).offset(40);
            make.height.equalTo(@20);
        }];
        
        [confirmBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(20);
            make.right.equalTo(self.whiteV).offset(-20);
            make.bottom.equalTo(self.whiteV).offset(-30);
            make.height.equalTo(@45);
        }];
        
        
    }
    
    return self;
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
