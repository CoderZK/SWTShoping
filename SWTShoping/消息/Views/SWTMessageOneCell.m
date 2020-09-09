//
//  SWTMessageOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMessageOneCell.h"

@implementation SWTMessageOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 3;
    self.imgV.clipsToBounds = YES;
    self.redV.layer.cornerRadius = 2;
    self.redV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
