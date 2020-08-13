//
//  SWTVideoDesOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTVideoDesOneCell.h"

@implementation SWTVideoDesOneCell

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
    
    [self.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    
    self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:13 lineSpace:3 textColor:CharacterColor70];
    self.timeLB.text = model.createtime;
    
}

@end
