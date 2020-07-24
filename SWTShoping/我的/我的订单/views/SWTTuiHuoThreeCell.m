//
//  SWTTuiHuoThreeCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuoThreeCell.h"

@implementation SWTTuiHuoThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.rightBt.layer.cornerRadius = self.leftBt.layer.cornerRadius = 15;
    self.leftBt.clipsToBounds = self.rightBt.clipsToBounds = YES;
    self.leftBt.layer.borderWidth = self.rightBt.layer.borderWidth = 0.5;
    self.leftBt.layer.borderColor = CharacterColor102.CGColor;
    self.rightBt.layer.borderColor = RedColor.CGColor;
    
    self.lineV.backgroundColor = lineBackColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
