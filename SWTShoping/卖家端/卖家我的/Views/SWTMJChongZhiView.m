//
//  SWTMJChongZhiView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJChongZhiView.h"

@interface SWTMJChongZhiView()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UITextField *TF;
@property(nonatomic , strong)UIButton *confirmBt;
@end

@implementation SWTMJChongZhiView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
 
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 420)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
      
        
        UILabel * lb  = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 150, 20)];
        lb.text = @"充值金额";
        lb.font = kFont(14);
        [self.whiteV addSubview:lb];
        
       UILabel * lb2  = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 20, 20)];
        lb2.text = @"￥";
        lb2.font = kFont(16);
        [self.whiteV addSubview:lb2];
        
        self.TF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), 45, ScreenW - 60, 30)];
        self.TF.placeholder = @"请输入金额";
        self.TF.font = kFont(15);
        self.TF.keyboardType = UIKeyboardTypeDecimalPad;
        [self.whiteV addSubview:self.TF];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 80, ScreenW - 30, 0.5)];
        backV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:backV];
        
        self.confirmBt = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, ScreenW - 200, 40)];
        [self.confirmBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self.confirmBt setTitle:@"确定" forState:UIControlStateNormal];
        self.confirmBt.titleLabel.font = kFont(14);
        self.confirmBt.layer.cornerRadius = 20;
        self.confirmBt.clipsToBounds = YES;
        self.confirmBt.backgroundColor = GreenColor;
        [self.whiteV addSubview:self.confirmBt];
        [self.confirmBt addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
    return self;
}

- (void)confirmAction{
    if (self.TF.text.length == 0 || self.TF.text.floatValue < 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确金额"];
        return;
    }
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:self.TF.text];
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 420;
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
