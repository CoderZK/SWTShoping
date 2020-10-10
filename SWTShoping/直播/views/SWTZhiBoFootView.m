//
//  SWTZhiBoFootView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/10/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoFootView.h"

@interface SWTZhiBoFootView()
@property(nonatomic,strong)UIView *wihteV,*redV;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLB,*jiaJiaLB,*numberLB,*typeOneLB,*typeTwoLB;
@property(nonatomic,strong)UIButton *timeBt,*rightBt;



@end

@implementation SWTZhiBoFootView

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
        lb.text = @"合买定制 合而共赢";
        lb.font = kFont(13);
        [self.redV addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.redV).offset(10);
            make.bottom.top.right.equalTo(self.redV);
            
        }];
        
        self.imgV = [[UIImageView alloc] init];
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
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgV);
            make.height.equalTo(@16);
            make.left.equalTo(self.imgV.mas_right).offset(5);
        }];
        
        self.typeOneLB = [[UILabel alloc] init];
        self.typeOneLB.font = kFont(12);
        self.typeOneLB.backgroundColor = RGB(253, 216, 217);
        self.typeOneLB.textColor = RedColor;
        [self.wihteV addSubview:self.typeOneLB];
        self.typeOneLB.text = @"标签";
        [self.typeOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB.mas_right).offset(5);
            make.top.height.equalTo(self.titleLB);
            
        }];
        
        self.typeTwoLB = [[UILabel alloc] init];
        self.typeTwoLB.font = kFont(12);
        self.typeTwoLB.backgroundColor = RGB(253, 216, 217);
        self.typeTwoLB.textColor = RedColor;
        [self.wihteV addSubview:self.typeTwoLB];
        self.typeTwoLB.text = @"标签";
        [self.typeTwoLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeOneLB.mas_right).offset(5);
            make.top.height.equalTo(self.titleLB);
            
        }];
        
        self.numberLB = [[UILabel alloc] init];
        self.numberLB.text = @"0/1";
        self.numberLB.font = kFont(10);
        [self.wihteV addSubview:self.numberLB];
        [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgV.mas_right).offset(80);
            make.height.equalTo(@14);
            make.top.equalTo(self.titleLB.mas_bottom);
        }];
        
        UIView * view = [[UIView alloc] init];
        [self.wihteV addSubview:view];
        view.backgroundColor = [UIColor orangeColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.numberLB);
            make.height.equalTo(@2);
            make.width.equalTo(@70);
            make.left.equalTo(self.imgV.mas_right).offset(5);
        }];
        self.timeBt = [[UIButton alloc] init];
        [self.timeBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        self.timeBt.titleLabel.font  = kFont(12);
        self.timeBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.timeBt setImage:[UIImage imageNamed:@"naozhong"] forState:UIControlStateNormal];
        [self.wihteV addSubview:self.timeBt];
        
        self.jiaJiaLB = [[UILabel alloc] init];
        self.jiaJiaLB.font = kFont(13);
        self.jiaJiaLB.textColor = RedColor;
        [self.wihteV addSubview:self.jiaJiaLB];
        [self.jiaJiaLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB);
            make.bottom.equalTo(self.imgV);
            make.height.equalTo(@16);
        }];
        
        [self.timeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB);
            make.bottom.equalTo(self.jiaJiaLB.mas_top);
            make.height.equalTo(@14);
            
        }];
        
        self.rightBt = [[UIButton alloc] init];
        self.rightBt.backgroundColor = RedColor;
        [self.rightBt setTitle:@"参与合买" forState:UIControlStateNormal];;
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
    self.numberLB.text =  [NSString stringWithFormat:@"%@/%@",model.isbuynum,model.num];
    [LSTTimer removeAllTimer];
    Weak(weakSelf);
    [LSTTimer addTimerForTime:model.resttimes.intValue /1000 handle:^(NSString * _Nonnull day, NSString * _Nonnull hour, NSString * _Nonnull minute, NSString * _Nonnull second, NSString * _Nonnull ms) {
        if (day.intValue + hour.intValue + minute.intValue + second.intValue <= 0) {
            [weakSelf.timeBt setTitle:@"已结束" forState:UIControlStateNormal];
        }else {
            [weakSelf.timeBt setTitle:[NSString stringWithFormat:@"%@天%@小时%@分%@秒",day,hour,minute,second] forState:UIControlStateNormal];
        }
        
    }];

    self.rightBt.hidden = self.isOrder;
}

- (void)rightAction:(UIButton *)button {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@""];
    }
}

@end
