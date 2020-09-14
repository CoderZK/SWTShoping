//
//  SWTMJChanPinListCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJChanPinListCell.h"

@implementation SWTMJChanPinListCell

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
    [self.imgV sd_setImageWithURL:[model.thumb getPicURL] placeholderImage:[UIImage imageNamed:@"369"]];
    self.titleLB.text = model.title;
    self.chanDiLB.text = model.place;
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",model.productprice.getPriceAllStr];;
    self.guiGeLB.text = model.spec;
    self.caiZhiLB.text = model.material;
    self.kuCunLB.text = model.stock;
    self.xiaoLiangLB.text = @"0";
    self.chanPinKuLB.text = model.warehouse_str;
}

@end
