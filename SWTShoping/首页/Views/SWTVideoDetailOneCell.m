//
//  SWTVideoDetailOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTVideoDetailOneCell.h"

@implementation SWTVideoDetailOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 20;
    self.headBt.clipsToBounds = YES;
    self.vipBt.layer.cornerRadius = 8;
    self.vipBt.clipsToBounds = YES;
   
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
    [self.headBt sd_setBackgroundImageWithURL:[model.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage  imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.nameLB.text = model.nickname;

    //级别
    
    // 是否收藏
    
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
