//
//  SWTTuiHuiOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuiOneCell.h"

@implementation SWTTuiHuiOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
//        self.shopNameBt = [[UIButton alloc] init];
//        [self.shopNameBt setImage:[UIImage imageNamed:@"shop1-1"] forState:UIControlStateNormal];
//        self.shopNameBt.titleLabel.font = kFont(14);
//        [self.shopNameBt setTitle:@"水玉堂" forState:UIControlStateNormal];
//        [self addSubview:self.shopNameBt];
//        [self.shopNameBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
//        self.shopNameBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//
        self.leftimgV = [[UIImageView alloc] init];
        self.leftimgV.image = [UIImage imageNamed:@"369"];
        [self addSubview:self.leftimgV];
        
        self.leftimgV.layer.cornerRadius = 3;
        self.leftimgV.clipsToBounds = YES;
        
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
        
        
//        self.leftThreeLB = [[UILabel alloc] init];
//        self.leftThreeLB.font = kFont(13);
//        self.leftThreeLB.textColor = RedColor;
//        self.leftThreeLB.text = @"退款: ￥145";
//        [self addSubview:self.leftThreeLB];
        
//        self.rightImgV = [[UIImageView alloc] init];
//        self.rightImgV.image = [UIImage imageNamed:@"cpjl_yzp"];
//        [self addSubview:self.rightImgV];
        
//        self.statusLB = [[UILabel alloc] init];
//        self.statusLB.font = kFont(12);
//        self.statusLB.textColor = CharacterColor70;
//        self.statusLB.textAlignment = NSTextAlignmentRight;
//        [self addSubview:self.statusLB];
//        self.statusLB.text = @"卖家已发货";
        
        self.numberAndMoneyLB = [[UILabel alloc] init];
        self.numberAndMoneyLB.font = kFont(12);
        self.numberAndMoneyLB.textColor = CharacterColor70;
        [self addSubview:self.numberAndMoneyLB];
        self.numberAndMoneyLB.numberOfLines = 2;
        self.numberAndMoneyLB.textAlignment = NSTextAlignmentRight;
        self.numberAndMoneyLB.text = @"￥1500\nx1";
        
//        self.typeOneLB = [[UILabel alloc] init];
//        self.typeOneLB.text = @"  直营  ";
//        self.typeOneLB.textColor = RedLightColor;
//        self.typeOneLB.font = kFont(10);
//        self.typeOneLB.backgroundColor = RedBackColor;
//        self.typeOneLB.layer.cornerRadius = 7.5;
//        self.typeOneLB.clipsToBounds = YES;
//        [self addSubview:self.typeOneLB];
        
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
//        [self.rightTwoBt setTitleColor:RedLightColor forState:UIControlStateNormal];
//        [self.rightOneBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        
        
//        [self.shopNameBt mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(15);
//            make.top.equalTo(self).offset(10);
//            make.height.equalTo(@17);
//        }];
        
//        [self.statusLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self).offset(-15);
//            make.centerY.equalTo(self.shopNameBt);
//        }];
        
        
        [self.leftimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self).offset(10);
            make.height.width.equalTo(@85);
        }];
        
        
        [self.numberAndMoneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftimgV).offset(8);
            make.right.equalTo(self).offset(-15);
            make.width.equalTo(@120);
        }];
        
        [self.leftOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self.numberAndMoneyLB.mas_left).offset(-10);
            make.top.equalTo(self.leftimgV).offset(8);
        }];
        
        [self.leftTwoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self.numberAndMoneyLB.mas_left).offset(-10);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        
//        [self.leftThreeLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.leftimgV.mas_right).offset(5);
//            make.right.equalTo(self).offset(-10);
//            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
//            make.height.equalTo(@17);
//        }];
//
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
//
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
        
        
        UIView * backV =[[UIView alloc] init];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        self.lineV = backV;
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@0.5);
            make.top.equalTo(self.leftimgV.mas_bottom).offset(15);
        }];
        
    }
    return self;
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
