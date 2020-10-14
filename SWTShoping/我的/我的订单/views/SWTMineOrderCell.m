//
//  SWTMineOrderCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineOrderCell.h"

@implementation SWTMineOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.headImgV = [[UIImageView alloc] init];
        [self addSubview:self.headImgV];
        self.headImgV.image = [UIImage imageNamed:@"shop1-1"];
        
        //        self.leftHeadImgV = [[UIImageView alloc] init];
        //        self.leftHeadImgV.layer.cornerRadius = 15;
        //        self.leftHeadImgV.clipsToBounds = YES;
        //        [self addSubview:self.leftHeadImgV];
        //
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
        self.rightImgV.image = [UIImage imageNamed:@"cpjl_yzp"];
        [self addSubview:self.rightImgV];
        
        self.statusLB = [[UILabel alloc] init];
        self.statusLB.font = kFont(12);
        self.statusLB.textColor = CharacterColor70;
        self.statusLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.statusLB];
        self.statusLB.text = @"卖家已发货";
        
        self.numberAndMoneyLB = [[UILabel alloc] init];
        self.numberAndMoneyLB.font = kFont(12);
        self.numberAndMoneyLB.textColor = CharacterColor70;
        [self addSubview:self.numberAndMoneyLB];
        self.numberAndMoneyLB.numberOfLines = 2;
        self.numberAndMoneyLB.textAlignment = NSTextAlignmentRight;
        self.numberAndMoneyLB.text = @"￥1500\nx1";
        
        self.typeOneLB = [[UILabel alloc] init];
        self.typeOneLB.text = @"  直营  ";
        self.typeOneLB.textColor = RedLightColor;
        self.typeOneLB.font = kFont(10);
        self.typeOneLB.backgroundColor = RedBackColor;
        self.typeOneLB.layer.cornerRadius = 7.5;
        self.typeOneLB.clipsToBounds = YES;
        [self addSubview:self.typeOneLB];
        
        self.typeTwoLB = [[UILabel alloc] init];
        self.typeTwoLB.text = @"  包邮  ";
        self.typeTwoLB.textColor = RedLightColor;
        self.typeTwoLB.font = kFont(10);
        self.typeTwoLB.backgroundColor = RedBackColor;
        self.typeTwoLB.layer.cornerRadius = 7.5;
        self.typeTwoLB.clipsToBounds = YES;
        [self addSubview:self.typeTwoLB];
        
        self.rightOneBt = [[UIButton alloc] init];
        self.rightOneBt.layer.cornerRadius = 7.5;
        self.rightOneBt.titleLabel.font = kFont(12);
        
        [self.rightOneBt setTitle:@"  改地址  " forState:UIControlStateNormal];
        self.rightOneBt.layer.borderColor  = RedLightColor.CGColor;
        self.rightOneBt.layer.borderWidth = 0.5;
        self.rightOneBt.clipsToBounds = YES;
        [self addSubview:self.rightOneBt];
        
        self.rightTwoBt = [[UIButton alloc] init];
        self.rightTwoBt.layer.cornerRadius = 7.5;
        self.rightTwoBt.titleLabel.font = kFont(12);
        
        [self.rightTwoBt setTitle:@"  付款  " forState:UIControlStateNormal];
        self.rightTwoBt.layer.borderColor  = RedLightColor.CGColor;
        self.rightTwoBt.layer.borderWidth = 0.5;
        self.rightTwoBt.clipsToBounds = YES;
        [self addSubview:self.rightTwoBt];
        
        self.rightThreeBt = [[UIButton alloc] init];
        self.rightThreeBt.layer.cornerRadius = 7.5;
        self.rightThreeBt.titleLabel.font = kFont(12);
        [self.rightThreeBt setTitle:@"  售后  " forState:UIControlStateNormal];
        self.rightThreeBt.layer.borderColor  = RedLightColor.CGColor;
        self.rightThreeBt.layer.borderWidth = 0.5;
        self.rightThreeBt.clipsToBounds = YES;
        [self addSubview:self.rightThreeBt];
        
        [self.rightTwoBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        [self.rightOneBt setTitleColor:RedLightColor forState:UIControlStateNormal];
        [self.rightThreeBt setTitleColor:RedLightColor forState:UIControlStateNormal];
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
        
        
        [self.leftThreeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        [self.typeOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftOneLB);
            make.height.equalTo(@15);
            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
        }];
        
        [self.typeTwoLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeOneLB.mas_right).offset(10);
            make.height.equalTo(@15);
            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
        }];
        
        [self.rightTwoBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeTwoLB.mas_bottom).offset(10);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@15);
        }];
        
        [self.rightOneBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightTwoBt);
            make.right.equalTo(self.rightTwoBt.mas_left).offset(-15);
            make.height.equalTo(@15);
        }];
        
        [self.rightThreeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightTwoBt);
            make.right.equalTo(self.rightOneBt.mas_left).offset(-15);
            make.height.equalTo(@15);
        }];
        
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
    [self.shopNameBt setTitle: [NSString stringWithFormat:@" %@",model.store_name] forState:UIControlStateNormal];
    self.leftOneLB.text = model.goodname;
    [self.leftimgV sd_setImageWithURL:[model.thumb getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    //     [self.leftHeadImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.numberAndMoneyLB.text =  [NSString stringWithFormat:@"￥%@\nx%@",model.goodprice.getPriceAllStr,model.goodnum];
    self.leftTwoLb.text =model.spec;
    self.leftThreeLB.hidden = YES;
    //0未支付1待发货2待收货3待评价4已完成5已关闭-1交易失败 -2 全部
    self.rightTwoBt.hidden = self.rightOneBt.hidden = NO;
    self.rightThreeBt.hidden = YES;
    
    if (model.backstatus.intValue == 1) {
        self.rightOneBt.hidden = self.rightThreeBt.hidden = self.rightTwoBt.hidden = YES;
        [self.rightTwoBt setTitle:@" 退款中 " forState:UIControlStateNormal];
        self.rightTwoBt.hidden = NO;
        self.rightThreeBt.hidden = NO;
        [self.rightThreeBt setTitle:@" 退货退款 " forState:UIControlStateNormal];
        [self.rightThreeBt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightTwoBt.mas_left).offset(-15);
        }];
        self.statusLB.text = @"退款中";
    }else if (model.backstatus.intValue == 2) {
        self.rightOneBt.hidden = self.rightThreeBt.hidden = self.rightTwoBt.hidden = YES;
        if (model.status.intValue == -1) {
            self.statusLB.text = @"交易失败";
            [self.rightTwoBt setTitle:@" 退款完成 " forState:UIControlStateNormal];
            self.rightTwoBt.hidden = NO;
        }else {
            self.statusLB.text = @"退款完成";
            [self.rightTwoBt setTitle:@" 退款完成 " forState:UIControlStateNormal];
            self.rightTwoBt.hidden = NO;
        }
        
    }else  {
        if (model.status.intValue == -1) {
            self.leftThreeLB.hidden = NO;
            self.typeOneLB.hidden = self.typeTwoLB.hidden = YES;
            self.leftThreeLB.hidden = NO;
            self.leftThreeLB.text = model.goodprice;
            self.rightOneBt.hidden = self.rightTwoBt.hidden =  YES;
            self.statusLB.text = @"交易失败";
            if (model.backstatus.intValue == 1) {
                [self.rightTwoBt setTitle:@" 退款中 " forState:UIControlStateNormal];
                self.rightTwoBt.hidden = NO;
                self.statusLB.text = @"交易中";
            }else if (model.backstatus.intValue == 2){
                [self.rightTwoBt setTitle:@" 退款完成 " forState:UIControlStateNormal];
                self.rightTwoBt.hidden = NO;
            }
        }else {
            
            self.typeOneLB.hidden = self.typeTwoLB.hidden = YES;
            NSArray * arr = [model getTypeLBArr];
            if (arr.count > 0) {
                self.typeOneLB.hidden = NO;
                self.typeOneLB.text =  [NSString stringWithFormat:@" %@ ",arr[0]];
            }
            if (arr.count > 1) {
                self.typeTwoLB.hidden = NO;
                self.typeTwoLB.text =  [NSString stringWithFormat:@" %@ ",arr[1]];
            }
            
            if (model.status.intValue == 0) {
                self.statusLB.text = @" 待付款 ";
                [self.rightOneBt setTitle:@" 改地址 " forState:UIControlStateNormal];
                [self.rightTwoBt setTitle:@" 付款 " forState:UIControlStateNormal];
            }else if (model.status.intValue == 1) {
                self.statusLB.text = @" 待商家发货 ";
                [self.rightTwoBt setTitle:@" 提醒卖家发货 " forState:UIControlStateNormal];
                self.rightOneBt.hidden = YES;
                self.rightThreeBt.hidden = NO;
                [self.rightThreeBt mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.rightTwoBt.mas_left).offset(-15);
                }];
            }else if (model.status.intValue == 2) {
                self.statusLB.text = @" 待收货 ";
                
                [self.rightOneBt setTitle:@" 查看物流 " forState:UIControlStateNormal];
                [self.rightTwoBt setTitle:@" 确认收货 " forState:UIControlStateNormal];
                self.rightThreeBt.hidden = NO;
                [self.rightThreeBt mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.rightOneBt.mas_left).offset(-15);
                }];
                
            }else if (model.status.intValue == 3) {
                self.statusLB.text = @" 待评价 ";
                [self.rightOneBt setTitle:@" 查看物流 " forState:UIControlStateNormal];
                if (model.commentstatus.intValue == 0) {
                    [self.rightTwoBt setTitle:@" 评价 " forState:UIControlStateNormal];
                    self.rightTwoBt.hidden = NO;
                }else {
                    self.rightTwoBt.hidden = YES;
                }
                
                self.rightThreeBt.hidden = NO;
                [self.rightThreeBt mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.rightOneBt.mas_left).offset(-15);
                }];
            }else if (model.status.intValue == 4) {
                self.statusLB.text = @" 已完成 ";
                
                 self.rightTwoBt.hidden = self.rightThreeBt.hidden = YES;
                self.rightOneBt.hidden = NO;
                [self.rightTwoBt setTitle:@"退款" forState:UIControlStateNormal];
                if (model.commentstatus.intValue == 0) {
                    [self.rightTwoBt setTitle:@" 评价 " forState:UIControlStateNormal];
                    self.rightTwoBt.hidden = NO;
                }else {
                    self.rightTwoBt.hidden = YES;
                }
                
                
            }else if (model.status.intValue == 5) {
                self.statusLB.text = @" 交易失败 ";
                
            }else if (model.status.intValue == 6) {
                self.statusLB.text = @" 售后 ";
                self.rightOneBt.hidden =  YES;
                if (model.backstatus.intValue == -1) {
                    
                    [self.rightTwoBt setTitle:@" 失败 " forState:UIControlStateNormal];
                }else if (model.backstatus.intValue == 1) {
                    [self.rightTwoBt setTitle:@" 退款中 " forState:UIControlStateNormal];
                }else {
                    [self.rightThreeBt setTitle:@" 退款完成 " forState:UIControlStateNormal];
                }
                
            }
            
            
        }
    }
    
    
}


- (void)setMjModel:(SWTModel *)mjModel {
    _mjModel = mjModel;
    [self.headImgV sd_setImageWithURL:mjModel.avatar.getPicURL placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [self.shopNameBt setTitle: [NSString stringWithFormat:@" %@",mjModel.nickname] forState:UIControlStateNormal];
    self.leftOneLB.text = mjModel.title;
    [self.leftimgV sd_setImageWithURL:[mjModel.thumb getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    //     [self.leftHeadImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.numberAndMoneyLB.text =  [NSString stringWithFormat:@"￥%@\nx%@",mjModel.goodprice.getPriceAllStr,mjModel.goodnum];
    self.leftTwoLb.text =mjModel.spec;
    self.leftThreeLB.hidden = YES;
    //0未支付1待发货2待收货3待评价4已完成5已关闭-1交易失败 -2 全部
    self.rightTwoBt.hidden = self.rightOneBt.hidden = self.rightThreeBt.hidden =  YES;
    self.rightThreeBt.hidden = YES;
    
    
    if (self.isShangJia) {
        //商家端
        if (self.status.intValue == 0 || self.status.intValue == 1) {
            self.rightTwoBt.hidden = self.rightOneBt.hidden = NO;
            [self.rightOneBt setTitle:@" 拒绝 " forState:UIControlStateNormal];
            if (mjModel.refundtype.intValue == 1) {
                [self.rightTwoBt setTitle:@"退款" forState:UIControlStateNormal];
            }else {
                if (mjModel.sn.length > 0) {
                    [self.rightTwoBt setTitle:@" 完成 " forState:UIControlStateNormal];
                }else {
                   [self.rightTwoBt setTitle:@" 同意退货退款 " forState:UIControlStateNormal];
                }
                
            }
            
        }
    }else {
        
        if (mjModel.backstatus.intValue == 1) {
            self.rightOneBt.hidden = self.rightThreeBt.hidden = self.rightTwoBt.hidden = YES;
            [self.rightTwoBt setTitle:@" 退款中 " forState:UIControlStateNormal];
            self.rightTwoBt.hidden = NO;
            self.statusLB.text = @"退款中";
        }else if (mjModel.backstatus.intValue == 2) {
            self.rightOneBt.hidden = self.rightThreeBt.hidden = self.rightTwoBt.hidden = YES;
            if (mjModel.status.intValue == -1) {
                self.statusLB.text = @"交易失败";
                [self.rightTwoBt setTitle:@" 退款完成 " forState:UIControlStateNormal];
                self.rightTwoBt.hidden = NO;
            }else {
                self.statusLB.text = @"退款完成";
                [self.rightTwoBt setTitle:@" 退款完成 " forState:UIControlStateNormal];
                self.rightTwoBt.hidden = NO;
            }
            
        }else {
            
            if (mjModel.status.intValue == -1) {
                self.leftThreeLB.hidden = NO;
                self.typeOneLB.hidden = self.typeTwoLB.hidden =  YES;
                self.leftThreeLB.hidden = NO;
                self.leftThreeLB.text = mjModel.goodprice;
                self.rightOneBt.hidden = self.rightTwoBt.hidden = YES;
                self.statusLB.text = @"交易失败";
            }else {
                
                self.typeOneLB.hidden = self.typeTwoLB.hidden = YES;
                NSArray * arr = [mjModel getTypeLBArr];
                if (arr.count > 0) {
                    self.typeOneLB.hidden = NO;
                    self.typeOneLB.text =  [NSString stringWithFormat:@" %@ ",arr[0]];
                }
                if (arr.count > 1) {
                    self.typeTwoLB.hidden = NO;
                    self.typeTwoLB.text =  [NSString stringWithFormat:@" %@ ",arr[1]];
                }
                
                if (mjModel.status.intValue == 0) {
                    self.rightTwoBt.hidden = self.rightOneBt.hidden = self.rightThreeBt.hidden = YES;
                    self.statusLB.text = @"等待买家付款";
                    //            [self.rightOneBt setTitle:@" 改地址 " forState:UIControlStateNormal];
                    //            [self.rightTwoBt setTitle:@" 付款 " forState:UIControlStateNormal];
                }else if (mjModel.status.intValue == 1) {
                    self.statusLB.text = @"待卖家发货";
                    [self.rightTwoBt setTitle:@" 发货 " forState:UIControlStateNormal];
                    self.rightOneBt.hidden = YES;
                    self.rightTwoBt.hidden = NO;
                    self.rightThreeBt.hidden = YES;
                    [self.rightThreeBt mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.rightTwoBt.mas_left).offset(-15);
                    }];
                }else if (mjModel.status.intValue == 2) {
                    self.statusLB.text = @" 待收货 ";
                    [self.rightTwoBt setTitle:@" 查看物流 " forState:UIControlStateNormal];
                    self.rightOneBt.hidden = YES;
                    self.rightThreeBt.hidden = YES;
                    self.rightTwoBt.hidden = YES;
                    [self.rightThreeBt mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(self.rightTwoBt.mas_left).offset(-15);
                    }];
                    
                    if (mjModel.backstatus.intValue == 1) {
                        self.rightTwoBt.hidden = YES;
                    }else if (mjModel.backstatus.intValue == 2) {
                        self.rightTwoBt.hidden = NO;
                    }
                    
                }else if (mjModel.status.intValue == 3) {
                    self.statusLB.text = @" 交易成功 ";
                    self.rightTwoBt.hidden = self.rightOneBt.hidden = self.rightThreeBt.hidden = YES;
                    [self.rightTwoBt setTitle:@" 查看物流 " forState:UIControlStateNormal];
                    
                    if (mjModel.backstatus.intValue == 1) {
                        self.statusLB.text = @" 交易成功 ";
                        self.rightTwoBt.hidden = YES;
                    }else if (mjModel.backstatus.intValue == 2) {
                        self.statusLB.text = @" 待收货 ";
                        self.rightTwoBt.hidden = NO;
                    }
                    
                }else if (mjModel.status.intValue == 4) {
                    self.statusLB.text = @" 交易成功 ";
                    self.rightOneBt.hidden = self.rightTwoBt.hidden = self.rightThreeBt.hidden = YES;
                    
                }else if (mjModel.status.intValue == 5) {
                    self.statusLB.text = @" 交易关闭 ";
                    self.rightTwoBt.hidden = self.rightOneBt.hidden = self.rightThreeBt.hidden = YES;
                }else if (mjModel.status.intValue == 6) {
                    self.statusLB.text = @" 售后 ";
                    self.rightOneBt.hidden =  YES;
                    if (mjModel.backstatus.intValue == -1) {
                        [self.rightTwoBt setTitle:@" 失败 " forState:UIControlStateNormal];
                    }else if (mjModel.backstatus.intValue == 1) {
                        self.rightOneBt.hidden =  NO;
                        [self.rightOneBt setTitle:@" 驳回退款 " forState:UIControlStateNormal];
                        [self.rightThreeBt setTitle:@" 同意买家退货 " forState:UIControlStateNormal];
                        
                    }else {
                        self.rightOneBt.hidden =  NO;
                        [self.rightOneBt setTitle:@" 查看物流 " forState:UIControlStateNormal];
                        [self.rightTwoBt setTitle:@"退款" forState:UIControlStateNormal];
                        self.rightThreeBt.hidden = YES;
                        [self.rightThreeBt mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.right.equalTo(self.rightOneBt.mas_left).offset(-15);
                        }];
                        
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
        
        
    }
    
    
    
}

@end
