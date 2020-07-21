//
//  SWTGoodsDetailFiveCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailFiveCell.h"

@implementation SWTGoodsDetailFiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 5;
    self.backV.clipsToBounds = YES;
    self.headBt.layer.cornerRadius = 20;
    self.headBt.clipsToBounds = YES;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
    [self.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.nameLB.text = model.store_name;
    self.titleLB.text = model.name;
    self.contentLB.text = model.des;
    if ([model.isfollow isEqualToString:@"no"]) {
        [self.gaunzhuBt setBackgroundImage:[UIImage imageNamed:@"Focus"] forState:UIControlStateNormal];
    }else {
       [self.gaunzhuBt setBackgroundImage:[UIImage imageNamed:@"dyx24"] forState:UIControlStateNormal];
    }
    
    NSArray * arr = [model getTypeLBArr];
    self.typeLB.hidden = self.typeImgOne.hidden = self.typeImgVTwo.hidden = self.typeTwoLB.hidden = YES;
    if (arr.count > 0) {
        self.typeLB.hidden = self.typeImgOne.hidden =  NO;
        self.typeLB.text = arr[0];
    }
    if (arr.count> 1) {
        self.typeLB.hidden = self.typeImgOne.hidden = self.typeImgVTwo.hidden = self.typeTwoLB.hidden = NO;
        self.typeTwoLB.text = arr[1];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    
    
    
}

@end
