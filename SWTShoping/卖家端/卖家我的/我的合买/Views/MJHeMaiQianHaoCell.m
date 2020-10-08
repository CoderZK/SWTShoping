//
//  MJHeMaiQianHaoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiQianHaoCell.h"

@implementation MJHeMaiQianHaoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftBt.layer.borderColor = RedColor.CGColor;
    self.leftBt.layer.borderWidth = 0.5;
    [self.leftBt setTitleColor:RedColor forState:UIControlStateNormal];
    [self.leftBt setTitle:@"联系买家" forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    self.LB1.text = model.lotsno;
    self.LB2.text = model.username;
    self.LB3.text = model.status;
    [self.rigthBt setTitle:model.orderstatus forState:UIControlStateNormal];
    if ([model.orderstatus isEqual:@"已完成"] || [model.orderstatus isEqual:@"待收货"])
    {
        self.rigthBt.layer.borderColor = [UIColor greenColor].CGColor;
        self.rigthBt.layer.borderWidth = 0.5;
        [self.rigthBt setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
    }else {
        self.rigthBt.layer.borderColor = RedColor.CGColor;
        self.rigthBt.layer.borderWidth = 0.5;
        [self.rigthBt setTitleColor:RedColor forState:UIControlStateNormal];
    }
    
}

@end
