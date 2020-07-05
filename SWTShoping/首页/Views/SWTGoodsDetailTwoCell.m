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

@end
