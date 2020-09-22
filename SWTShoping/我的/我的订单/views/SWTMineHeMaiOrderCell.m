//
//  SWTMineHeMaiOrderCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineHeMaiOrderCell.h"

@implementation SWTMineHeMaiOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //        self.leftHeadImgV = [[UIImageView alloc] init];
        //        self.leftHeadImgV.layer.cornerRadius = 15;
        //        self.leftHeadImgV.clipsToBounds = YES;
        //        [self addSubview:self.leftHeadImgV];
        //
        self.shopNameBt = [[UIButton alloc] init];
        [self.shopNameBt setImage:[UIImage imageNamed:@"shop1-1"] forState:UIControlStateNormal];
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
        
        self.youJianV = [[UIImageView alloc] init];
        self.youJianV.image = [UIImage imageNamed:@"yous"];
        [self addSubview:self.youJianV];
        
        self.leftOneLB = [[UILabel alloc] init];
        self.leftOneLB.font = kFont(14);
        self.leftOneLB.textColor = CharacterColor70;
        self.leftOneLB.text = @"式搜救请我而佛";
        self.leftOneLB.numberOfLines = 0;
        [self addSubview:self.leftOneLB];
        
        self.leftTwoLb = [[UILabel alloc] init];
        self.leftTwoLb.font = kFont(12);
        self.leftTwoLb.textColor = CharacterColor70;
        self.leftTwoLb.text = @"尺寸: 250 * 200";
        [self addSubview:self.leftTwoLb];
        
        
        self.leftThreeLB = [[UILabel alloc] init];
        self.leftThreeLB.font = kFont(13);
        self.leftThreeLB.textColor = RedColor;
        self.leftThreeLB.text = @"退款: ￥145";
        [self addSubview:self.leftThreeLB];
        
        self.rightImgV = [[UIImageView alloc] init];
        self.rightImgV.image = [UIImage imageNamed:@"hm_ywc"];
        [self addSubview:self.rightImgV];
        
        //        self.statusLB = [[UILabel alloc] init];
        //        self.statusLB.font = kFont(12);
        //        self.statusLB.textColor = CharacterColor70;
        //        self.statusLB.textAlignment = NSTextAlignmentRight;
        //        [self addSubview:self.statusLB];
        //        self.statusLB.text = @"卖家已发货";
        
        self.numberAndMoneyLB = [[UILabel alloc] init];
        self.numberAndMoneyLB.font = kFont(12);
        self.numberAndMoneyLB.textColor = RedLightColor;
        [self addSubview:self.numberAndMoneyLB];
        self.numberAndMoneyLB.numberOfLines = 2;
        self.numberAndMoneyLB.textAlignment = NSTextAlignmentRight;
        self.numberAndMoneyLB.text = @"￥1500";
        
        self.typeOneLB = [[UILabel alloc] init];
        self.typeOneLB.text = @"直营";
        self.typeOneLB.textColor = RedLightColor;
        self.typeOneLB.font = kFont(10);
        self.typeOneLB.backgroundColor = RedBackColor;
        self.typeOneLB.layer.cornerRadius = 7.5;
        self.typeOneLB.clipsToBounds = YES;
        [self addSubview:self.typeOneLB];
        
        self.typeTwoLB = [[UILabel alloc] init];
        self.typeTwoLB.text = @"包邮";
        self.typeTwoLB.textColor = WhiteColor;
        self.typeTwoLB.font = kFont(10);
        self.typeTwoLB.backgroundColor = RedLightColor;
        self.typeTwoLB.layer.cornerRadius = 7.5;
        self.typeTwoLB.clipsToBounds = YES;
        [self addSubview:self.typeTwoLB];
        self.typeOneLB.textAlignment = self.typeTwoLB.textAlignment = NSTextAlignmentCenter;
        
        self.rightOneBt = [[UIButton alloc] init];
        self.rightOneBt.layer.cornerRadius = 7.5;
        self.rightOneBt.titleLabel.font = kFont(12);
        
        [self.rightOneBt setTitle:@"  联系卖家  " forState:UIControlStateNormal];
        self.rightOneBt.layer.borderColor  = RedLightColor.CGColor;
        self.rightOneBt.layer.borderWidth = 0.5;
        self.rightOneBt.clipsToBounds = YES;
        [self addSubview:self.rightOneBt];
        
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
        
        [self.rightTwoBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        [self.rightOneBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        [self.rightThreeBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        //        [self.leftHeadImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.equalTo(self).offset(8.5);
        //            make.width.height.equalTo(@30);
        //            make.left.equalTo(self).offset(15);
        //        }];
        
        [self.shopNameBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@17);
        }];
        
        
        
        //        [self.statusLB mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.right.equalTo(self).offset(-15);
        //            make.centerY.equalTo(self.shopNameBt);
        //        }];
        //
        
        [self.leftimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopNameBt.mas_bottom).offset(10);
            make.left.equalTo(self).offset(15);
            make.height.width.equalTo(@85);
        }];
        
        [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftimgV);
            make.width.equalTo(@40);
            make.height.equalTo(@35);
            make.right.equalTo(self).offset(-10);
        }];
        
        
        [self.leftOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            //            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftimgV).offset(8);
        }];
        
        [self.leftTwoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self.numberAndMoneyLB.mas_left).offset(-10);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        [self.numberAndMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftTwoLb);
            make.right.equalTo(self).offset(-15);
        }];
        
        [self.leftThreeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        [self.youJianV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.height.width.equalTo(@15);
            make.centerY.equalTo(self.leftThreeLB);
        }];
        
        [self.typeOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftOneLB.mas_right).offset(10);
            make.height.equalTo(@15);
            make.top.equalTo(self.leftOneLB);
        }];
        
        [self.typeTwoLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(8);
            make.height.equalTo(@15);
        }];
        
        [self.rightTwoBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeTwoLB.mas_bottom).offset(10);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@15);
        }];
        
        [self.rightOneBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftThreeLB.mas_bottom).offset(10);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@15);
        }];
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
            make.top.equalTo(self.rightOneBt.mas_bottom).offset(15);
            make.bottom.equalTo(self);
        }];
        
    }
    return self;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.leftimgV sd_setImageWithURL:[model.thumb getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.leftOneLB.text = model.goodname;
    if (self.type == 1) {
        self.rightImgV.hidden =self.typeTwoLB.hidden  =YES;
        self.leftTwoLb.hidden =self.numberAndMoneyLB.hidden = NO;
        self.leftThreeLB.textColor = CharacterColor70;
        self.leftTwoLb.text = @"x1份";
        self.numberAndMoneyLB.text =  [NSString stringWithFormat:@"￥%@",model.goodprice.getPriceAllStr];
    } else {
        self.rightImgV.hidden =self.typeTwoLB.hidden  = NO;
        self.leftTwoLb.hidden =self.numberAndMoneyLB.hidden = YES;
        self.typeTwoLB.text = @" 2号签 ";
        self.leftThreeLB.textColor = RedLightColor;
        self.leftThreeLB.text = [NSString stringWithFormat:@"￥%@",model.goodprice.getPriceAllStr];
        
    }
    
    
    
    
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
