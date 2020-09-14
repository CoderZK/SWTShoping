//
//  SWTZhiBoJingPaiShowCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoJingPaiShowCell.h"

@implementation SWTZhiBoJingPaiShowCell

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
    [self.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.name;
    if (model.isJiPai) {
        self.jiaJiaLB.text =  [NSString stringWithFormat:@"加价幅度:%@",model.stepprice.getPriceAllStr];
        self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",model.productprice.getPriceAllStr];
        self.jiaJiaLB.hidden = self.shuaXinAction.hidden = NO;
        
    }else {
        self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",model.productprice.getPriceAllStr];
        self.jiaJiaLB.hidden = self.shuaXinAction.hidden = YES;
    }
   
}

- (IBAction)shuaXin:(id)sender {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectShuaXinWithCell:)]) {
        [self.delegate didSelectShuaXinWithCell:self];
    }

   
    
}


@end
