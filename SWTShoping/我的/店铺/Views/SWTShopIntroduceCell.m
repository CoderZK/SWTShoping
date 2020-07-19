//
//  SWTShopIntroduceCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopIntroduceCell.h"

@implementation SWTShopIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
        self.vipBt.layer.cornerRadius = 8;
    self.vipBt.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
