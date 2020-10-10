//
//  SWTZhiBoGeRenShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/10/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoGeRenShowView.h"


@interface SWTZhiBoGeRenShowView()
@property(nonatomic,strong)UIView *wihteV,*redV;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UIButton *leftBt,*rightBt,*levelBt;
@end

@implementation SWTZhiBoGeRenShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.wihteV = [[UIView alloc] init];
        self.wihteV.backgroundColor = WhiteColor;
        [self addSubview:self.wihteV];
        self.wihteV.layer.cornerRadius = 5;
        self.wihteV.clipsToBounds = YES;
        
        [self.wihteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.right.equalTo(self).offset(-30);
            make.height.equalTo(@200);
            make.centerY.equalTo(self);
        }];
        
        
        UIButton * closeBt  =[[UIButton alloc] init];
        [closeBt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [closeBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.wihteV addSubview:closeBt];
        
        [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.width.equalTo(@30);
            make.right.equalTo(self.wihteV).offset(-5);
            make.top.equalTo(self.wihteV).offset(5);
        }];
        
        
        
        self.imgV = [[UIImageView alloc] init];
        [self.wihteV addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.wihteV).offset(30);
            make.width.height.equalTo(@50);
            make.centerX.equalTo(self.wihteV);
            
        }];
        self.nameLB = [[UILabel alloc] init];
        self.nameLB.font = kFont(13);
        self.nameLB.textColor = CharacterColor50;
        [self.wihteV addSubview:self.nameLB];
        
        [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgV.mas_bottom).offset(15);
            make.height.equalTo(@16);
            make.centerX.equalTo(self.wihteV).offset(20);
        }];
        self.nameLB.text = @"12345678998";
        
        
        
        self.levelBt = [[UIButton alloc] init];
        self.levelBt.titleLabel.font = kFont(13);
        [self.levelBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.levelBt.layer.cornerRadius = 8;
        self.levelBt.clipsToBounds = YES;
        [self.levelBt setImage:[UIImage imageNamed:@"vip"] forState:UIControlStateNormal];
        [self.levelBt setTitle:@"6" forState:UIControlStateNormal];
        [self.levelBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@16);
            make.width.equalTo(@60);
            make.centerY.equalTo(self.nameLB);
            make.right.equalTo(self.nameLB.mas_left);
        }];
        
        self.leftBt = [[UIButton alloc] init];
        [self.leftBt setTitle:@"禁言" forState:UIControlStateNormal];
        [self.leftBt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.leftBt.layer.cornerRadius = 10;
        self.leftBt.clipsToBounds = YES;
        self.leftBt.titleLabel.font = kFont(13);
        self.leftBt.layer.borderColor = [UIColor orangeColor].CGColor;
        self.leftBt.layer.borderWidth= 0.5;
        
        
        [self.leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLB.mas_bottom).offset(15);
            make.height.equalTo(@20);
            make.width.equalTo(@60);
            make.centerX.equalTo(self.wihteV).offset(-40);
            
        }];
        
        self.rightBt = [[UIButton alloc] init];
        [self.rightBt setTitle:@"创建订单" forState:UIControlStateNormal];
        [self.rightBt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.rightBt.layer.cornerRadius = 10;
        self.rightBt.clipsToBounds = YES;
        self.rightBt.titleLabel.font = kFont(13);
        self.rightBt.layer.borderColor = [UIColor orangeColor].CGColor;
        self.rightBt.layer.borderWidth= 0.5;
        
        
        [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLB.mas_bottom).offset(15);
            make.height.equalTo(@20);
            make.width.equalTo(@60);
            make.centerX.equalTo(self.wihteV).offset(40);
            
        }];
        
        
        [self.leftBt addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBt addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
//禁言
- (void)leftAction:(UIButton *)button {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:livesetlivesend_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 1) {
            
            
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
   
        
    }];
}

- (void)rightAction:(UIButton *)button {
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    self.nameLB.text = model.nickname;
    [self.leftBt setTitle:model.levelcode forState:UIControlStateNormal];
    
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
