//
//  SWTFanKuiOneNeiCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTFanKuiOneNeiCell.h"

@implementation SWTFanKuiOneNeiCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.backV.backgroundColor = WhiteColor;
    self.backV.layer.cornerRadius = 5;
    self.backV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
