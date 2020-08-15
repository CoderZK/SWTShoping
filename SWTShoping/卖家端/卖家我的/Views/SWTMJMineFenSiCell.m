//
//  SWTMJMineFenSiCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineFenSiCell.h"

@implementation SWTMJMineFenSiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgV.layer.cornerRadius = 20;
    self.imgV.clipsToBounds = YES;
    self.vipBt.layer.cornerRadius = 9;
    self.vipBt.clipsToBounds = YES;
    [self.guanZhuBt setTitleColor:RedLightColor forState:UIControlStateNormal];
    self.guanZhuBt.layer.cornerRadius = 3;
    self.guanZhuBt.clipsToBounds = YES;
    self.guanZhuBt.layer.borderWidth = 0.5;
    self.guanZhuBt.layer.borderColor = RedLightColor.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
