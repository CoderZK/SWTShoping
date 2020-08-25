//
//  SWTMJAddZhiBoShangPinCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJAddZhiBoShangPinCell.h"

@implementation SWTMJAddZhiBoShangPinCell

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
    self.leftLB.text = model.title;
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",model.productprice];
    [self.leftImgV sd_setImageWithURL:model.thumb.getPicURL placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
}

@end
