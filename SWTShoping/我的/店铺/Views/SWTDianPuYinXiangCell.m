//
//  SWTDianPuYinXiangCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTDianPuYinXiangCell.h"

@implementation SWTDianPuYinXiangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.leftBt.layer.cornerRadius = self.rightBt.layer.cornerRadius = 10;
    self.leftBt.clipsToBounds = self.rightBt.clipsToBounds = YES;
    self.leftBt.layer.borderColor = self.rightBt.layer.borderColor = RedColor.CGColor;
    self.leftBt.layer.borderWidth = self.rightBt.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
