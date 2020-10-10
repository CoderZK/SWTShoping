//
//  SWTZhiBoYiKouJiaFootView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/10/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoYiKouJiaFootView.h"

@interface SWTZhiBoYiKouJiaFootView()
@property(nonatomic,strong)UIView *wihteV,*redV;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLB,*jiaJiaLB,*numberLB,*typeOneLB,*typeTwoLB;
@property(nonatomic,strong)UIButton *timeBt,*rightBt;



@end

@implementation SWTZhiBoYiKouJiaFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.wihteV = [[UIView alloc] init];
        self.wihteV.backgroundColor = WhiteColor;
        [self addSubview:self.wihteV];
        self.wihteV.layer.cornerRadius = 5;
        self.wihteV.clipsToBounds = YES;
        
        [self.wihteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-20);
        }];
        
        
        self.redV = [[UIView alloc] init];
        [self.wihteV addSubview:self.redV];
        self.redV.backgroundColor = RedColor;
        [self.redV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.wihteV);
            make.height.equalTo(@15);
        }];
        
        
        UILabel * lb = [[UILabel alloc] init];
        lb.textColor = WhiteColor;
        lb.text = @"秒杀";
        lb.font = kFont(12);
        [self.redV addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.redV).offset(10);
            make.bottom.top.right.equalTo(self.redV);
            
        }];
        
        self.imgV = [[UIImageView alloc] init];
        self.imgV.image = [UIImage imageNamed:@"369"];
        [self.wihteV addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wihteV).offset(5);
            make.top.equalTo(self.wihteV).offset(20);
            make.width.height.equalTo(@65);
            
        }];
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(13);
        self.titleLB.textColor = CharacterColor50;
        [self.wihteV addSubview:self.titleLB];
        self.titleLB.text = @"瓷器花瓶";
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgV);
            make.height.equalTo(@16);
            make.left.equalTo(self.imgV.mas_right).offset(5);
            make.right.equalTo(self.wihteV).offset(-5);
        }];
        

        
        self.jiaJiaLB = [[UILabel alloc] init];
        self.jiaJiaLB.font = kFont(13);
        self.jiaJiaLB.textColor = RedColor;
        [self.wihteV addSubview:self.jiaJiaLB];
        self.jiaJiaLB.text = @"3456";
        [self.jiaJiaLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB);
            make.top.equalTo(self.titleLB.mas_bottom).offset(10);
            make.height.equalTo(@16);
        }];
        
        [self.timeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB);
            make.bottom.equalTo(self.jiaJiaLB.mas_top);
            make.height.equalTo(@14);
            
        }];
        
        self.rightBt = [[UIButton alloc] init];
        self.rightBt.backgroundColor = RedColor;
        [self.rightBt setTitle:@"马上抢" forState:UIControlStateNormal];;
        [self.rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.rightBt.titleLabel.font = kFont(13);
        [self.wihteV addSubview:self.rightBt];
        [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.wihteV).offset(-10);
            make.bottom.equalTo(self.wihteV).offset(-8);
            make.height.equalTo(@18);
            make.width.equalTo(@70);
        }];
        
        UIImageView * sanJianImgV  =[[UIImageView alloc] init];
        sanJianImgV.image = [UIImage imageNamed:@"sanjian"];
        [self addSubview:sanJianImgV];
        [sanJianImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.wihteV.mas_bottom).offset(-8);
            make.height.width.equalTo(@20);
            make.left.equalTo(self).offset(20);
        }];
        
     
        [self.rightBt addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}




- (void)setModel:(SWTModel *)model {
    _model = model;
    
    
    [self.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.name;
    self.jiaJiaLB.text =  [NSString stringWithFormat:@"￥%@",model.price];
    self.rightBt.hidden = self.isOrder;
}

- (void)rightAction:(UIButton *)button {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@""];
    }
}
@end
