//
//  SWTCateSearchView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTCateSearchView.h"

@implementation SWTCateSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubView];
        
        self.backgroundColor = BackgroundColor;
        
    }
    
    return self;
}

- (void)initSubView {
    self.paiMaiBt  =[[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 30)];
    [self.paiMaiBt setTitle:@"拍卖" forState:UIControlStateNormal];
    self.paiMaiBt.titleLabel.font = kFont(15);
    [self.paiMaiBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.paiMaiBt.tag = 100;
    [self.paiMaiBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.paiMaiBt];
    
    self.yiKouJiaBt  =[[UIButton alloc] initWithFrame:CGRectMake(70 + 40, 5, 70, 30)];
    [self.yiKouJiaBt setTitle:@"一口价" forState:UIControlStateNormal];
    self.yiKouJiaBt.titleLabel.font = kFont(15);
    [self.yiKouJiaBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.yiKouJiaBt.tag = 101;
    [self.yiKouJiaBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.yiKouJiaBt];
    
    self.shaixuanBtn  =[[SWTCateButton alloc] initWithFrame:CGRectMake(ScreenW - 60, 5, 60, 30)];
    self.shaixuanBtn.textLabel.text = @"筛选";
    self.shaixuanBtn.textLabel.font = kFont(15);
    self.shaixuanBtn.textLabel.textColor = [UIColor blackColor];
    self.shaixuanBtn.iconImgView.image = [UIImage imageNamed:@"screening"];
    [self.shaixuanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.shaixuanBtn.tag = 102;
    [self.shaixuanBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shaixuanBtn];
    
    self.redV = [[UIView alloc] init];
    self.redV.mj_size = CGSizeMake(25, 3);
    self.redV.layer.cornerRadius = 1.5;
    self.redV.clipsToBounds = YES;
    self.redV.backgroundColor = RedColor;
    self.redV.mj_y = 33;
    self.redV.centerX = self.paiMaiBt.centerX;
    [self addSubview:self.redV];
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenW, 0.5)];
    backV.backgroundColor = lineBackColor;
    [self addSubview:backV];
    self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, 40, ScreenW, 40)];
    self.whiteV.backgroundColor = WhiteColor;
    [self addSubview:self.whiteV];
    
    self.priceBt = [[SWTCateButton alloc] initWithFrame:CGRectMake(10, 5, 50, 30)];
    self.priceBt.tag = 103;
    [self.priceBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.priceBt.textLabel.text = @"价格";
    self.priceBt.textLabel.font = kFont(13);
    self.priceBt.iconImgView.image = [UIImage imageNamed:@"dyx6"];
    [self.whiteV addSubview:self.priceBt];
    
    self.timeBt = [[SWTCateButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.priceBt.frame) + 5, 5, CGRectGetWidth(self.priceBt.frame), 30)];
    self.timeBt.tag = 104;
    [self.timeBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.timeBt.textLabel.text = @"最新";
    self.timeBt.textLabel.font = kFont(13);
    self.timeBt.iconImgView.image = [UIImage imageNamed:@"dyx6"];
    [self.whiteV addSubview:self.timeBt];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.timeBt.frame) + 5, 10, 0.5, 20)];
    view.backgroundColor = lineBackColor;
    [self.whiteV addSubview:view];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.whiteV addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_right).offset(5);
        make.right.equalTo(self.whiteV).offset(-5);
        make.top.bottom.equalTo(self.whiteV);
    }];
    self.scrollView.backgroundColor =[UIColor redColor];
    
}


- (void)clickAction:(UIButton *)button {
    if (button.tag == 100) {
        [UIView animateWithDuration:0.1 animations:^{
            self.redV.centerX = button.centerX;
        }];
    }else if (button.tag == 101) {
        [UIView animateWithDuration:0.1 animations:^{
            self.redV.centerX = button.centerX;
        }];
    }else if (button.tag == 102){
        
    }
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag -100)];
    }
    
}


@end
