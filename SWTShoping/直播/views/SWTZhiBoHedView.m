//
//  SWTZhiBoHedView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoHedView.h"

@interface SWTZhiBoHedView()

@end

@implementation SWTZhiBoHedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.headBt = [[UIButton alloc] init];
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage  imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
        
        self.nameLB = [[UILabel alloc] init];
        self.nameLB.textColor = WhiteColor;
        self.nameLB.text = @"玉成其美";
        self.nameLB.font = kFont(15);
        [self addSubview:self.nameLB];
        
        self.fanAndSeeLB = [[UILabel alloc] init];
        self.fanAndSeeLB.textColor = WhiteColor;
        self.fanAndSeeLB.text = @"粉丝:1000 1.5万人观看";
        self.fanAndSeeLB.font = kFont(12);
        [self addSubview:self.fanAndSeeLB];
        
        self.guanzhuBt  = [[UIButton alloc] init];
        self.guanzhuBt.titleLabel.font = kFont(13);
//        [self.guanzhuBt setTitle:@"+关注" forState:UIControlStateNormal];
//        [self.guanzhuBt setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
        self.guanzhuBt.layer.cornerRadius = 9;
        self.guanzhuBt.clipsToBounds = YES;
        [self addSubview:self.guanzhuBt];
        
        
        
        
        self.shopV = [[UIView alloc] init];
        self.shopV.layer.cornerRadius = 2;
        self.shopV.clipsToBounds = YES;
        self.shopV.layer.borderColor = WhiteColor.CGColor;
        self.shopV.layer.borderWidth = 1;
        [self addSubview:self.shopV];
        self.shopNameLB = [[UILabel alloc] init];
        self.shopNameLB.backgroundColor = RGB(184, 184, 184);
        self.shopNameLB.textAlignment = NSTextAlignmentCenter;
        self.shopNameLB.text = @"水御堂";
        self.shopNameLB.font = kFont(13);
        [self.shopV addSubview:self.shopNameLB];
        
        self.shopIdLB = [[UILabel alloc] init];
        self.shopIdLB.textColor = WhiteColor;
        self.shopIdLB.backgroundColor = [UIColor blackColor];
        self.shopIdLB.textAlignment = NSTextAlignmentCenter;
        self.shopIdLB.text = @"ID:100029";
        self.shopIdLB.font = kFont(12);
        [self.shopV addSubview:self.shopIdLB];
        
        
        [self.headBt mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self).offset(15);
            make.height.width.equalTo(@45);
            make.top.equalTo(self);
            
            
        }];
        
        [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headBt.mas_right).offset(5);
            make.top.equalTo(self.headBt).offset(4);
            make.height.equalTo(@20);
            
        }];
        
        [self.fanAndSeeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLB);
            make.top.equalTo(self.nameLB.mas_bottom).offset(3);
            make.height.equalTo(@15);
            
        }];
        
        [self.guanzhuBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLB.mas_right).offset(15);
            make.centerY.equalTo(self.nameLB);
            make.height.equalTo(@16);
            make.width.equalTo(@42);
            
        }];
        
        [self.shopV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headBt);
            make.right.equalTo(self);
            make.width.equalTo(@80);
            make.height.equalTo(@34);
        }];
        [self.shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.shopV).offset(1);
            make.right.equalTo(self.shopV).offset(-1);
            make.height.equalTo(@(17));
        }];

        [self.shopIdLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.shopV).offset(-1);
            make.left.equalTo(self.shopV).offset(1);
            make.height.equalTo(@(15));
        }];
        
        
    }
    
    return self;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    self.nameLB.text = model.name;
    [self.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
     if ([model.liveisfollow isEqualToString:@"yes"]) {
           [self.guanzhuBt setBackgroundImage:[UIImage imageNamed:@"dyx24"] forState:UIControlStateNormal];
       }else {
          [self.guanzhuBt setBackgroundImage:[UIImage imageNamed:@"Focus"] forState:UIControlStateNormal];
       }
    
    self.shopNameLB.text = model.livename;
    self.shopIdLB.text =  [NSString stringWithFormat:@"ID:%@",model.liveid];
    NSString * str = @"";
    if (model.focusnum.intValue > 10000) {
        str =  [NSString stringWithFormat:@"%0.2f万",model.focusnum.floatValue];
    }else{
        str = model.focusnum;
    }
    
    NSString * str1 = @"";
       if (model.watchnum.intValue > 10000) {
           str1 =  [NSString stringWithFormat:@"%0.2f万",model.watchnum.floatValue];
       }else{
           str1 = model.watchnum;
       }
    
    self.fanAndSeeLB.text =  [NSString stringWithFormat:@"粉丝:%@  %@人观看",str,str1];
}


@end
