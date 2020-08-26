//
//  SWTAddVideoTypeCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAddVideoTypeCell.h"

@implementation SWTAddVideoTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    if (model.isSelect) {
        self.imgV.image = [UIImage imageNamed:@"bbdyx34"];
    }else {
        self.imgV.image = [UIImage imageNamed:@"dyx44"];
    }
    self.titleLB.text = model.name;
}

@end
