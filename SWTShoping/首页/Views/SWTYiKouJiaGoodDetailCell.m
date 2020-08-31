//
//  SWTYiKouJiaGoodDetailCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTYiKouJiaGoodDetailCell.h"

@implementation SWTYiKouJiaGoodDetailCell

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
    self.shopNameLB.text = model.name;
    self.priceLB.text =  [NSString stringWithFormat:@"￥%@",[model.price getPriceAllStr]];
    if ([model.isfav isEqualToString:@"yes"]) {
        [self.collectBt setImage:[UIImage imageNamed:@"praise1"] forState:UIControlStateNormal];
    }else {
        [self.collectBt setImage:[UIImage imageNamed:@"praise2"] forState:UIControlStateNormal];
    }
}

@end
