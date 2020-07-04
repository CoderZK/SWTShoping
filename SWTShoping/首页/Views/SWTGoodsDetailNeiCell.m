//
//  SWTGoodsDetailNeiCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailNeiCell.h"

@implementation SWTGoodsDetailNeiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgV.layer.cornerRadius = 15;
    self.headImgV.clipsToBounds = YES;
    
    self.typeLB.layer.borderColor = CharacterColor102.CGColor;
    self.typeLB.layer.borderWidth = 0.5;
    self.typeLB.textColor = CharacterColor102;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
