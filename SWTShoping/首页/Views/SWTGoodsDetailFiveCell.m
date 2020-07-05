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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
