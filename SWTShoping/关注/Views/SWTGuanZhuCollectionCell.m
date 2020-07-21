//
//  SWTGuanZhuCollectionCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGuanZhuCollectionCell.h"

@implementation SWTGuanZhuCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.imgV sd_setImageWithURL:[model.goodimg getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.goodname;
    
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",[model.goodprice getPriceStr]];
}

@end
