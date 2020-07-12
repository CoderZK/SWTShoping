//
//  SWTMinePingLunListCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMinePingLunListCell.h"

@implementation SWTMinePingLunListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 3;
    self.backV.clipsToBounds = YES;
    self.headBt.layer.cornerRadius = 3;
    self.headBt.clipsToBounds = YES;
    self.imgV.layer.cornerRadius = 3;
    self.imgV.clipsToBounds = YES;
    self.writeBt.layer.cornerRadius = 7.5;
    self.writeBt.layer.borderColor = RedLightColor.CGColor;
    self.writeBt.layer.borderWidth = 0.5;
    [self.writeBt setTitleColor:RedLightColor forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
