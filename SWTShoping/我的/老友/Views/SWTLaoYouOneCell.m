//
//  SWTLaoYouOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouOneCell.h"



@implementation SWTLaoYouOneCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.shopNameBt = [[UIButton alloc] init];
        [self.shopNameBt setImage:[UIImage imageNamed:@"shop1-1"] forState:UIControlStateNormal];
        self.shopNameBt.titleLabel.font = kFont(14);
        [self.shopNameBt setTitle:@"水御堂" forState:UIControlStateNormal];
        [self addSubview:self.shopNameBt];
        [self.shopNameBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        self.shopNameBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.leftimgV = [[UIImageView alloc] init];
        [self addSubview:self.leftimgV];
        
        self.leftimgV.layer.cornerRadius = 3;
        self.leftimgV.clipsToBounds = YES;
        
        self.leftOneLB = [[UILabel alloc] init];
        self.leftOneLB.font = kFont(14);
        self.leftOneLB.textColor = CharacterColor70;
        self.leftOneLB.text = @"式搜救请我而佛";
        [self addSubview:self.leftOneLB];
        
        self.leftTwoLb = [[UILabel alloc] init];
        self.leftTwoLb.font = kFont(12);
        self.leftTwoLb.textColor = CharacterColor70;
        self.leftTwoLb.text = @"剩余时间: 1小时47分58秒";
        [self addSubview:self.leftTwoLb];
        
        self.moneyLB = [[UILabel alloc] init];
        self.moneyLB.font = kFont(12);
        self.moneyLB.textColor = RedLightColor;
        self.moneyLB.text = @"";
        [self addSubview:self.moneyLB];
        
        
        self.leftThreeLB = [[UILabel alloc] init];
        self.leftThreeLB.font = kFont(13);
        self.leftThreeLB.textColor = RedLightColor;
        self.leftThreeLB.text = @"￥145";
        [self addSubview:self.leftThreeLB];
        
        self.rightImgV = [[UIImageView alloc] init];
        self.rightImgV.image = [UIImage imageNamed:@"cpjl_yzp"];
        [self addSubview:self.rightImgV];
      
        
        [self.shopNameBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@17);
        }];
        
        [self.leftimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopNameBt.mas_bottom).offset(10);
            make.left.equalTo(self).offset(15);
            make.height.width.equalTo(@85);
        }];
        
        [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftimgV).offset(5);
            make.width.equalTo(@40);
            make.height.equalTo(@35);
            make.right.equalTo(self).offset(-20);
        }];
        
        
        [self.leftOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftimgV).offset(8);
            make.height.equalTo(@17);
        }];
        
        [self.moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        [self.leftTwoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self.moneyLB.mas_left).offset(-10);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        
        [self.leftThreeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        UIView * backV =[[UIView alloc] init];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self);
        }];
        
    }
    return self;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.shopNameBt setTitle:model.store_name forState:UIControlStateNormal];
    self.leftOneLB.text = model.name;
    
    self.leftTwoLb.text =  [NSString stringWithFormat:@"￥%@",[model.price getPriceAllStr]];
    
    self.leftThreeLB.text = model.createtime;
    self.leftThreeLB.textColor = CharacterColor70;
    
    if (self.type == 2) {
        self.rightImgV.image = [UIImage imageNamed:@"cpjl_yzp"];
    }else if (self.type == 0) {
        self.rightImgV.image = [UIImage imageNamed:@"cpjl_bcy"];
    }else if (self.type == 1) {
        self.rightImgV.image = [UIImage imageNamed:@"cpjl_ylx"];
    }

    [self.leftimgV sd_setImageWithURL:[model.thumb getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
