//
//  SWTMineYouHuiQuanNeiCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineYouHuiQuanNeiCell.h"

@implementation SWTMineYouHuiQuanNeiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shiYongBt.layer.cornerRadius = 10;
    self.shiYongBt.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
