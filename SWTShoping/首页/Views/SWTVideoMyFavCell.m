//
//  SWTVideoMyFavCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTVideoMyFavCell.h"

@implementation SWTVideoMyFavCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backV.backgroundColor = BackgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(SWTModel *)model {
    _model = model;
    
    [self.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
       
       self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:13 lineSpace:3 textColor:CharacterColor70];
    
    self.scanNUmberLB.text =  [NSString stringWithFormat:@"%@人正在观看",model.playnum];
    self.timeLB.text = model.createtime;
}

@end
