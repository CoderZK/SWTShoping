//
//  SWTShopIntorduceHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopIntorduceHeadView.h"

@interface SWTShopIntorduceHeadView()
@property(nonatomic , strong)UIImageView *headImgV;
@property(nonatomic , strong)UIButton *leveBt,*gaunFangBt,*baoZhengJinBt,*lianxieBt,*gaunZhuBt,*lebftBt,*rightBt;;
@property(nonatomic , strong)UIView *redView;
@property(nonatomic , strong)UILabel *shopNameLB;


@end

@implementation SWTShopIntorduceHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.headImgV = [[UIImageView alloc] init];
        self.headImgV.layer.cornerRadius = 22.5;
        self.headImgV.clipsToBounds = YES;
        self.headImgV.image =[UIImage imageNamed:@"369"];
        [self addSubview:self.headImgV];
        
        
        self.shopNameLB = [[UILabel alloc] init];
        self.shopNameLB.text = @"优选好物";
        self.shopNameLB.font = kFont(14);
        [self addSubview:self.shopNameLB];
        
        self.leveBt = [[UIButton alloc] init];
        [self.leveBt setImage:[UIImage imageNamed:@"vip"] forState:UIControlStateNormal];
        self.leveBt.layer.cornerRadius = 8;
        self.leveBt.clipsToBounds = YES;
        [self.lebftBt setTitle:@"6" forState:UIControlStateNormal];
        [self.leveBt setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
        [self addSubview:self.leveBt];
        
        self.gaunFangBt = [[UIButton alloc] init];
        [self.gaunFangBt setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateNormal];
        [self.gaunFangBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        self.gaunFangBt.titleLabel.font = kFont(12);
        [self.gaunFangBt setTitle:@" 官方认证" forState:UIControlStateNormal];
        [self addSubview:self.gaunFangBt];
        
        self.baoZhengJinBt = [[UIButton alloc] init];
        [self.baoZhengJinBt setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateNormal];
        [self.baoZhengJinBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        self.baoZhengJinBt.titleLabel.font = kFont(12);
        [self.baoZhengJinBt setTitle:@" 资金保证" forState:UIControlStateNormal];
        [self addSubview:self.baoZhengJinBt];
        
        UIView * lineOneV  =[[UIView alloc] init];
        lineOneV.backgroundColor = lineBackColor;
        [self addSubview:lineOneV];
        
        self.lianxieBt = [[UIButton alloc] init];
        [self.lianxieBt setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateNormal];
        [self.lianxieBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        self.lianxieBt.titleLabel.font = kFont(12);
        [self.lianxieBt setTitle:@" 联系卖家" forState:UIControlStateNormal];
        self.lianxieBt.layer.cornerRadius = 8;
        self.lianxieBt.clipsToBounds = YES;
//        self.lianxieBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.lianxieBt.layer.borderColor = CharacterColor70.CGColor;
        self.lianxieBt.layer.borderWidth = 0.5;
        [self addSubview:self.lianxieBt];
        
        self.gaunZhuBt = [[UIButton alloc] init];
        [self.gaunZhuBt setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateNormal];
        [self.gaunZhuBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        self.gaunZhuBt.titleLabel.font = kFont(12);
        [self.gaunZhuBt setTitle:@" 关注卖家" forState:UIControlStateNormal];
        self.gaunZhuBt.layer.cornerRadius = 8;
        self.gaunZhuBt.clipsToBounds = YES;
        self.gaunZhuBt.layer.borderColor = CharacterColor70.CGColor;
        self.gaunZhuBt.layer.borderWidth = 0.5;
//        self.gaunZhuBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:self.gaunZhuBt];
        
        UIView * lineTwoV  = [[UIView alloc] initWithFrame:CGRectMake(0, 120, ScreenW, 5)];
        lineTwoV.backgroundColor = BackgroundColor;
        [self addSubview:lineTwoV];
        
        
        UIView * lineThreeV  =[[UIView alloc] init];
               lineThreeV.backgroundColor = lineBackColor;
               [self addSubview:lineThreeV];
        
        
        self.lebftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, ScreenW/2, 30)];
        self.lebftBt.titleLabel.font = kFont(15);
        [self.lebftBt setTitleColor:RedColor forState:UIControlStateNormal];
        [self.lebftBt setTitle:@"店铺简介" forState:UIControlStateNormal];
        self.lebftBt.tag = 102;
        [self.lebftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.lebftBt];
        
        self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW/2, CGRectGetMinY(self.lebftBt.frame), ScreenW/2, 30)];
        self.rightBt.titleLabel.font = kFont(15);
        [self.rightBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        [self.rightBt setTitle:@"店铺评价" forState:UIControlStateNormal];
        self.rightBt.tag = 103;
        [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBt];
        
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(0, 155, 30, 2)];
        self.redView.backgroundColor = RedColor;
        self.redView.centerX = self.lebftBt.centerX;
        [self addSubview:self.redView];
        
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(15);
            make.height.width.equalTo(@45);
        }];
        
        [self.shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.height.equalTo(@17);
            make.top.equalTo(self.headImgV).offset(5);
        }];
        
        [self.leveBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shopNameLB);
            make.left.equalTo(self.shopNameLB.mas_right).offset(10);
            make.height.equalTo(@16);
            make.width.equalTo(@70);
        }];
        
        
        [self.gaunFangBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shopNameLB);
            make.top.equalTo(self.shopNameLB.mas_bottom).offset(3);
            make.height.equalTo(@16);
            make.width.equalTo(@80);
        }];
        [self.baoZhengJinBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.gaunFangBt.mas_right).offset(10);
                   make.top.equalTo(self.shopNameLB.mas_bottom).offset(3);
                   make.height.equalTo(@16);
                   make.width.equalTo(@80);
               }];
        
     
        [self.lianxieBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(-50);
               make.top.equalTo(lineOneV.mas_bottom).offset(14);
               make.height.equalTo(@16);
               make.width.equalTo(@80);
           }];
        
        [self.gaunZhuBt mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self).offset(50);
            make.top.height.width.equalTo(self.lianxieBt);
        }];
        
        
        
        [lineOneV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@0.5);
            make.top.equalTo(self.headImgV.mas_bottom).offset(15);
        }];
        
        [lineThreeV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self);
            make.height.equalTo(@0.5);
        }];
        
    }
    self.backgroundColor = WhiteColor;
    return self;
}


- (void)clickAction:(UIButton *)button {
    
    if (button.tag == 100) {
        
    }else if (button.tag == 101) {
        
    }else if (button.tag == 102) {
       [self.rightBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        self.redView.centerX = self.lebftBt.centerX;
        [self.lebftBt setTitleColor:RedColor forState:UIControlStateNormal];
    }else if (button.tag == 103) {
        [self.lebftBt setTitleColor:CharacterColor70 forState:UIControlStateNormal];
        [self.rightBt setTitleColor:RedColor forState:UIControlStateNormal];
        self.redView.centerX = self.rightBt.centerX;
    }
    
//    if (self.delegateSignal) {
//        [self.delegateSignal sendNext:@(button.tag)];
//       }
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.headImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.shopNameLB.text = model.name;
    NSArray * arr  =[model getTypeLBArr];
    self.baoZhengJinBt.hidden = self.gaunFangBt.hidden = YES;
    if (arr.count > 0) {
        self.gaunFangBt.hidden = NO;
        [self.gaunFangBt setTitle:arr[0] forState:UIControlStateNormal];
        
    }
    
    if (arr.count > 1) {
        self.baoZhengJinBt.hidden = NO;
        [self.baoZhengJinBt setTitle:arr[1] forState:UIControlStateNormal];
    }
    
    
}

@end
