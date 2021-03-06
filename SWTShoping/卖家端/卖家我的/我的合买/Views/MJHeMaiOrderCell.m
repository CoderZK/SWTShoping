//
//  MJHeMaiOrderCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiOrderCell.h"

@implementation MJHeMaiOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.leftBt.layer.cornerRadius = self.centerBt.layer.cornerRadius = self.rightBt.layer.cornerRadius = 10;
    self.leftBt.layer.borderColor = self.centerBt.layer.borderColor = self.rightBt.layer.borderColor =  RedColor.CGColor;
    self.leftBt.clipsToBounds = self.centerBt.clipsToBounds = self.rightBt.clipsToBounds = YES;
    [self.leftBt setTitleColor:RedColor forState:UIControlStateNormal];
    [self.centerBt setTitleColor:RedColor forState:UIControlStateNormal];
    [self.rightBt setTitleColor:RedColor forState:UIControlStateNormal];
    self.leftBt.layer.borderWidth = self.rightBt.layer.borderWidth = self.centerBt.layer.borderWidth = 0.5;
    self.rightBt.userInteractionEnabled = NO;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SWTModel *)model {
    
    _model = model;
    [self.imgV sd_setImageWithURL:model.thumb.getPicURL placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [self.shopNameBt setTitle:model.store_name forState:UIControlStateNormal];
    self.nameLB.text = model.goodname;
    self.caiZhiLB.text = [NSString stringWithFormat:@"  %@  ",model.material];
    self.caiZhiLB.layer.cornerRadius = 8;
    self.caiZhiLB.clipsToBounds = YES;
    
    self.moneyLB.text = [NSString stringWithFormat:@"￥%@",model.price.getPriceStr];

    
    if (model.status.intValue == 4) {
        //已完成
        self.leftBt.hidden = self.centerBt.hidden = YES;
        self.timeLB.text = model.chippedtime;
    }else {
        if (model.lots_status.intValue == 1) {
            self.leftBt.hidden = YES;
        }else {
            self.leftBt.hidden = NO;
        }
        self.centerBt.hidden = NO;
        self.timeLB.text = @"";
    }
    
    
}

@end
