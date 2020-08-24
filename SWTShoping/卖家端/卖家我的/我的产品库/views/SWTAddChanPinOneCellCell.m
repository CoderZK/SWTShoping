//
//  SWTAddChanPinOneCellCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAddChanPinOneCellCell.h"

@implementation SWTAddChanPinOneCellCell


- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 0) {
        self.leftLB.font = kFont(14);
        self.leftLB.textColor = [UIColor blackColor];
        self.addBt.hidden = self.desLB.hidden = self.desimgV.hidden =YES;
        self.leftLB.hidden = NO;
    }else if (type == 1) {
        self.leftLB.font = kFont(13);
        self.leftLB.textColor = CharacterColor102;
        self.addBt.hidden = self.desLB.hidden = self.desimgV.hidden = YES;
        self.leftLB.hidden = NO;
    }else {
        self.addBt.hidden =  self.desLB.hidden = self.desimgV.hidden = NO;
        self.leftLB.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
