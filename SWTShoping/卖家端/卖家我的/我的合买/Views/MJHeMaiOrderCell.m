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
    self.leftBt.layer.borderColor = self.centerBt.layer.borderColor = self.rightBt.layer.borderColor =  CharacterColor102.CGColor;
    self.leftBt.clipsToBounds = self.centerBt.clipsToBounds = self.rightBt.clipsToBounds = YES;
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
    self.caiZhiLB.text = model.material;
    
    self.moneyLB.text = [NSString stringWithFormat:@"￥%@",model.price.getPriceStr];

    
    
    
}

@end
