//
//  SWTMJJingPaiGuanLiCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJJingPaiGuanLiCell.h"

@implementation SWTMJJingPaiGuanLiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //        self.leftHeadImgV = [[UIImageView alloc] init];
        //        self.leftHeadImgV.layer.cornerRadius = 15;
        //        self.leftHeadImgV.clipsToBounds = YES;
        //        [self addSubview:self.leftHeadImgV];
        //
        
        self.headImgV = [[UIImageView alloc] init];
        self.headImgV.layer.cornerRadius = 8.5;
        self.headImgV.clipsToBounds = YES;
        [self addSubview:self.headImgV];
        
        self.shopNameBt = [[UIButton alloc] init];
//        [self.shopNameBt setImage:[UIImage imageNamed:@"shop1-1"] forState:UIControlStateNormal];
        self.shopNameBt.titleLabel.font = kFont(14);
        [self.shopNameBt setTitle:@"水玉堂" forState:UIControlStateNormal];
        [self addSubview:self.shopNameBt];
        [self.shopNameBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        self.shopNameBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.leftimgV = [[UIImageView alloc] init];
        self.leftimgV.image = [UIImage imageNamed:@"369"];
        [self addSubview:self.leftimgV];
        
        self.leftimgV.layer.cornerRadius = 3;
        self.leftimgV.clipsToBounds = YES;
        
        self.leftOneLB = [[UILabel alloc] init];
        self.leftOneLB.font = kFont(13);
        self.leftOneLB.textColor = CharacterColor70;
        self.leftOneLB.text = @"式搜救请我而佛";
        self.leftOneLB.numberOfLines = 0;
        [self addSubview:self.leftOneLB];
        
        
        UILabel * LB1  = [[UILabel alloc] init];
        LB1.text = @"当前价";
        LB1.font = kFont(12);
        [self addSubview:LB1];
        
        
        
        self.leftTwoLb = [[UILabel alloc] init];
        self.leftTwoLb.font = kFont(12);
        self.leftTwoLb.textColor = RedLightColor;
        self.leftTwoLb.text = @"3000";
        [self addSubview:self.leftTwoLb];
        
        
        UILabel * LB2  = [[UILabel alloc] init];
        LB2.text = @"出价次数";
        LB2.font = kFont(12);
        [self addSubview:LB2];
        
        
        
        self.leftThreeLB = [[UILabel alloc] init];
        self.leftThreeLB.font = kFont(12);
        self.leftThreeLB.textColor = RedColor;
        self.leftThreeLB.text = @"￥145";
        [self addSubview:self.leftThreeLB];
        
        self.rightImgV = [[UIImageView alloc] init];
        self.rightImgV.image = [UIImage imageNamed:@"cpjl_yzp"];
        [self addSubview:self.rightImgV];
        
        self.statusLB = [[UILabel alloc] init];
        self.statusLB.font = kFont(12);
        self.statusLB.textColor = CharacterColor70;
        self.statusLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.statusLB];
        self.statusLB.text = @"卖家已发货";
        
        self.xieJiaBt = [[UIButton alloc] init];
        [self.xieJiaBt setTitle:@"下架" forState:UIControlStateNormal];
        self.xieJiaBt.titleLabel.font = kFont(14);
        
        self.xieJiaBt.layer.borderColor = RedLightColor.CGColor;
        self.xieJiaBt.layer.borderWidth = 0.5;
        [self.xieJiaBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        [self addSubview:self.xieJiaBt];
        //        self.numberAndMoneyLB = [[UILabel alloc] init];
        //        self.numberAndMoneyLB.font = kFont(12);
        //        self.numberAndMoneyLB.textColor = CharacterColor70;
        //        [self addSubview:self.numberAndMoneyLB];
        //        self.numberAndMoneyLB.numberOfLines = 2;
        //        self.numberAndMoneyLB.textAlignment = NSTextAlignmentRight;
        //        self.numberAndMoneyLB.text = @"￥1500\nx1";
        
        //        self.typeOneLB = [[UILabel alloc] init];
        //        self.typeOneLB.text = @"  直营  ";
        //        self.typeOneLB.textColor = RedLightColor;
        //        self.typeOneLB.font = kFont(10);
        //        self.typeOneLB.backgroundColor = RedBackColor;
        //        self.typeOneLB.layer.cornerRadius = 7.5;
        //        self.typeOneLB.clipsToBounds = YES;
        //        [self addSubview:self.typeOneLB];
        //
        //        self.typeTwoLB = [[UILabel alloc] init];
        //        self.typeTwoLB.text = @"  包邮  ";
        //        self.typeTwoLB.textColor = RedLightColor;
        //        self.typeTwoLB.font = kFont(10);
        //        self.typeTwoLB.backgroundColor = RedBackColor;
        //        self.typeTwoLB.layer.cornerRadius = 7.5;
        //        self.typeTwoLB.clipsToBounds = YES;
        //        [self addSubview:self.typeTwoLB];
        
        //        self.rightOneBt = [[UIButton alloc] init];
        //        self.rightOneBt.layer.cornerRadius = 7.5;
        //        self.rightOneBt.titleLabel.font = kFont(12);
        //
        //        [self.rightOneBt setTitle:@"  改地址  " forState:UIControlStateNormal];
        //        self.rightOneBt.layer.borderColor  = RedLightColor.CGColor;
        //        self.rightOneBt.layer.borderWidth = 0.5;
        //        self.rightOneBt.clipsToBounds = YES;
        //        [self addSubview:self.rightOneBt];
        //
        //        self.rightTwoBt = [[UIButton alloc] init];
        //        self.rightTwoBt.layer.cornerRadius = 7.5;
        //        self.rightTwoBt.titleLabel.font = kFont(12);
        //
        //        [self.rightTwoBt setTitle:@"  付款  " forState:UIControlStateNormal];
        //        self.rightTwoBt.layer.borderColor  = RedLightColor.CGColor;
        //        self.rightTwoBt.layer.borderWidth = 0.5;
        //        self.rightTwoBt.clipsToBounds = YES;
        //        [self addSubview:self.rightTwoBt];
        //
        //        self.rightThreeBt = [[UIButton alloc] init];
        //        self.rightThreeBt.layer.cornerRadius = 7.5;
        //        self.rightThreeBt.titleLabel.font = kFont(12);
        //        [self.rightThreeBt setTitle:@"  售后  " forState:UIControlStateNormal];
        //        self.rightThreeBt.layer.borderColor  = RedLightColor.CGColor;
        //        self.rightThreeBt.layer.borderWidth = 0.5;
        //        self.rightThreeBt.clipsToBounds = YES;
        //        [self addSubview:self.rightThreeBt];
        
        //        [self.rightTwoBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        //        [self.rightOneBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        //        [self.rightThreeBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        //        [self.leftHeadImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self).offset(8.5);
        //            make.width.height.equalTo(@30);
        //            make.left.equalTo(self).offset(15);
        //        }];
        
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(10);
            make.height.width.equalTo(@17);
        }];
        
        [self.shopNameBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(8);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@17);
        }];
        
        [self.statusLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self.shopNameBt);
        }];
        
        
        [self.leftimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopNameBt.mas_bottom).offset(10);
            make.left.equalTo(self).offset(15);
            make.height.width.equalTo(@85);
        }];
        
        
        //        [self.numberAndMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.leftimgV).offset(8);
        //            make.right.equalTo(self).offset(-15);
        //            make.width.equalTo(@120);
        //        }];
        
        
        
        
        [self.leftOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftimgV).offset(8);
        }];
        
        [LB1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(7);
            make.height.equalTo(@17);
            make.width.equalTo(@60);
        }];
        
        [self.leftTwoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LB1.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(LB1);
            make.height.equalTo(@17);
        }];
        
        [LB2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
             make.width.equalTo(@60);
            make.height.equalTo(@17);
        }];
        
        [self.leftThreeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(LB2.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(LB2);
            make.height.equalTo(@17);
        }];
        
        //        [self.typeOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.leftOneLB);
        //            make.height.equalTo(@15);
        //            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
        //        }];
        //
        //        [self.typeTwoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.typeOneLB.mas_right).offset(10);
        //            make.height.equalTo(@15);
        //            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
        //        }];
        
        //        [self.rightTwoBt mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.typeTwoLB.mas_bottom).offset(10);
        //            make.right.equalTo(self).offset(-15);
        //            make.height.equalTo(@15);
        //        }];
        //
        //        [self.rightOneBt mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.rightTwoBt);
        //            make.right.equalTo(self.rightTwoBt.mas_left).offset(-15);
        //            make.height.equalTo(@15);
        //        }];
        //
        //        [self.rightThreeBt mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self.rightTwoBt);
        //            make.right.equalTo(self.rightOneBt.mas_left).offset(-15);
        //            make.height.equalTo(@15);
        //        }];
        
        UIView * backV =[[UIView alloc] init];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@0.5);
            make.top.equalTo(self.leftimgV.mas_bottom).offset(15);
            
        }];
        
        [self.xieJiaBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backV.mas_bottom).offset(15);
            make.right.equalTo(self).offset(-15);
            make.width.equalTo(@70);
            make.height.equalTo(@30);
            make.bottom.equalTo(self).offset(-10);
        }];
        
        
    }
    return self;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
    [self.headImgV sd_setImageWithURL:[self.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [self.shopNameBt setTitle:self.name forState:UIControlStateNormal];
    [self.leftimgV sd_setImageWithURL:[model.thumb getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.leftOneLB.text = model.title;
    if (model.auction_status == 0) {
        self.statusLB.text = @"竞拍中";
    }else if (model.auction_status == 1) {
        self.statusLB.text = @"截拍";
    }else if (model.auction_status == 2) {
        self.statusLB.text = @"流拍";
    }
    
    if (model.state.intValue == 0) {
        [self.xieJiaBt setTitle:@"上架" forState:UIControlStateNormal];
    }else if (model.state.intValue == 1){
        [self.xieJiaBt setTitle:@"下架" forState:UIControlStateNormal];
    }
    
    self.leftTwoLb.text =  [NSString stringWithFormat:@"￥%@",model.curr_price];
    self.leftTwoLb.textAlignment = NSTextAlignmentLeft;
    self.leftThreeLB.text = model.bidsnum;
    self.leftThreeLB.textAlignment = NSTextAlignmentLeft;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
