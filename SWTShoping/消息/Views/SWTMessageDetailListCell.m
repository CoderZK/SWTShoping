//
//  SWTMessageDetailListCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMessageDetailListCell.h"

@implementation SWTMessageDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 3;
       self.imgV.clipsToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
