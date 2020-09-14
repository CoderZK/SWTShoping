//
//  SWTGoodsDetailNeiCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailNeiCell.h"

@implementation SWTGoodsDetailNeiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgV.layer.cornerRadius = 15;
    self.headImgV.clipsToBounds = YES;
    
    self.typeLB.layer.borderColor = CharacterColor102.CGColor;
    self.typeLB.layer.borderWidth = 0.5;
    self.typeLB.textColor = CharacterColor102;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
    self.timeLB.text = model.createtime;
    if (model.status.intValue == 1) {
        self.typeLB.text = @"领先";
        self.typeLB.layer.borderWidth = 0.5;
        self.typeLB.layer.borderColor = RedLightColor.CGColor;
    }else {
        self.typeLB.text = @"出局";
        self.typeLB.layer.borderWidth = 0.5;
        self.typeLB.layer.borderColor = CharacterColor102.CGColor;
    }
    
    
    
    [self.headImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",model.price.getPriceAllStr];
    self.phoneLB.text = model.nickname;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
