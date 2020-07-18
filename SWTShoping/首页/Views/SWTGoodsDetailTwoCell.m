//
//  SWTGoodsDetailTwoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailTwoCell.h"

@implementation SWTGoodsDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}
- (IBAction)clickAction:(UIButton *)sender {
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext: @""];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    self.titleLB.text = model.name;
    if ([model.isfollow isEqualToString:@"no"]) {
        [self.collectionBt setImage:[UIImage imageNamed:@"praise2"] forState:UIControlStateNormal];
    }else {
        [self.collectionBt setImage:[UIImage imageNamed:@"praise1"] forState:UIControlStateNormal];
    }
    
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",[model.price getPriceStr]];
    self.desLB.text =  [NSString stringWithFormat:@"市场估计:%@以上  加价%@以上  出价%@次数",[model.productprice getPriceStr],@"1000",model.bidsnum];
}

@end
