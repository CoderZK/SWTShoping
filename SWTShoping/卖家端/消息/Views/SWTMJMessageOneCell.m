//
//  SWTMJMessageOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMessageOneCell.h"

@implementation SWTMJMessageOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgV.layer.cornerRadius = 3;
    self.imgV.clipsToBounds = YES;
    
    self.gaungfangLB.layer.cornerRadius = 8.5;
    self.gaungfangLB.clipsToBounds = YES;
    self.gaungfangLB.layer.borderColor = RedColor.CGColor;
    self.gaungfangLB.layer.borderWidth = 0.5;
    self.gaungfangLB.textColor = RedColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.imgV sd_setImageWithURL:model.img.getPicURL placeholderImage:[UIImage imageNamed:@"369"]];
    self.titleLB.text = model.name;
    self.contentLB.text = model.msg;
    self.timeLB.text = model.time;
}

@end
