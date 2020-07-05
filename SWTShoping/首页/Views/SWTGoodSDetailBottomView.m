//
//  SWTGoodSDetailBottomView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodSDetailBottomView.h"


@interface SWTGoodSDetailBottomView()

@end

@implementation SWTGoodSDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.5)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        
        self.dianPuBt = [[SWTBottomBt alloc] initWithFrame:CGRectMake(0, 10, 60, 40)];
        self.dianPuBt.tag = 100;
        self.dianPuBt.textLabel.text = @"店铺";
        [self addSubview:self.dianPuBt];
        self.dianPuBt.iconImgView.image = [UIImage imageNamed:@"shop"];
        
        self.siXinBt = [[SWTBottomBt alloc] initWithFrame:CGRectMake(60, 10, 60, 40)];
        self.siXinBt.tag = 101;
        self.siXinBt.textLabel.text = @"私信";
        [self addSubview:self.siXinBt];
        self.siXinBt.iconImgView.image = [UIImage imageNamed:@"message"];
        
        self.chujiaBt = [[UIButton alloc] initWithFrame:CGRectMake(150 , 15, ScreenW - 170, 30)];
        self.chujiaBt.tag = 102;
        [self.chujiaBt setTitle:@"出个价" forState:UIControlStateNormal];
        self.chujiaBt.titleLabel.font = kFont(14);
        [self.chujiaBt setBackgroundImage:[UIImage imageNamed:@"rbg"] forState:UIControlStateNormal];
        [self addSubview:self.chujiaBt];
        
        [self.dianPuBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.siXinBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.chujiaBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = WhiteColor;
        self.clipsToBounds = YES;
    }
    
    return self;
}


- (void)clickAction:(UIButton *)button {
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag)];
    }
    
    
}

@end
