//
//  SWTTongYongOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTongYongOneCell.h"

@implementation SWTTongYongOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineV.backgroundColor = lineBackColor;
    self.rightTwoLB.textColor = RedColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
