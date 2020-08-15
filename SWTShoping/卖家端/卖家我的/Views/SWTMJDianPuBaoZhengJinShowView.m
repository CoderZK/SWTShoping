//
//  SWTMJDianPuBaoZhengJinShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJDianPuBaoZhengJinShowView.h"

@interface SWTMJDianPuBaoZhengJinShowView()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIScrollView *scrollView;
@end

@implementation SWTMJDianPuBaoZhengJinShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 450)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        
        
        UIButton * closeBt  =[[UIButton alloc] init];
        [closeBt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [closeBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:closeBt];
        
        [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@30);
            make.right.equalTo(self.whiteV).offset(-10);
            make.top.equalTo(self.whiteV).offset(10);
        }];
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, ScreenW, 17)];
        lb.font = kFont(15);
        lb.textColor = CharacterColor50;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"缴纳店铺保证金";
        [self.whiteV addSubview:lb];
        
        UIView * lineV = [[UIView alloc] init];
        lineV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:lineV];
        
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteV).offset(-15);
            make.left.equalTo(self.whiteV).offset(15);
            make.top.equalTo(self.whiteV).offset(50);
            make.height.equalTo(@0.5);
        }];
        
        
        UILabel * lb2 = [[UILabel alloc] init];
        lb2.font = kFont(15);
        lb2.textColor = CharacterColor50;
        lb2.textAlignment = NSTextAlignmentCenter;
        lb2.text = @"缴纳金额";
        [self.whiteV addSubview:lb2];
        
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(15);
            make.top.equalTo(lineV.mas_bottom).offset(15);
            make.height.equalTo(@17);
        }];
        
        UIButton * wentiBt =[[UIButton alloc] init];
        [wentiBt setImage:[UIImage imageNamed:@"wenti"] forState:UIControlStateNormal];
        [self.whiteV addSubview:wentiBt];
        [wentiBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lb2.mas_right);
            make.height.width.equalTo(@40);
            make.centerY.equalTo(lb2);
        }];
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsVerticalScrollIndicator = self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.whiteV addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(15);
            make.right.bottom.equalTo(self.whiteV).offset(-15);
            make.top.equalTo(lb2.mas_bottom).offset(15);
        }];
        
        
        
    }
    
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeResponderFromView:)];
    CGFloat space = 15;
    CGFloat ww = (ScreenW - 30 - 30)/3;
    CGFloat hh = 35;
    for (int i = 0 ; i < dataArray.count; i++) {
        UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake((i % 3)*(space + ww), (i/3) * (space + hh), ww, hh)];
        button.titleLabel.font = kFont(14);
        [button setBackgroundImage:[UIImage imageNamed:@"gkuang"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"rkuang"] forState:UIControlStateSelected];
        [button setTitleColor:CharacterColor102 forState:UIControlStateNormal];
        [button setTitleColor:RedColor forState:UIControlStateSelected];
        
        [self.scrollView addSubview:button];
        
        if (i + 1 == dataArray.count) {
            self.scrollView.contentSize = CGSizeMake(ScreenW - 30, CGRectGetMaxY(button.frame));
        }
        
        button.tag = i;
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
    }
}

- (void)action:(UIButton *)button {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag)];
    }
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 450;
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
