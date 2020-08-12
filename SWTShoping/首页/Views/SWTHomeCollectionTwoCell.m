//
//  SWTHomeCollectionTwoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHomeCollectionTwoCell.h"

@implementation SWTHomeCollectionTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.headImgV.layer.cornerRadius = 15;
    self.headImgV.clipsToBounds = YES;
    self.headImgV.layer.borderColor = CharacterColor183.CGColor;
    self.headImgV.layer.borderWidth = 0.5;
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.headImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    
    [self.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    
    self.nameLB.text = model.store_name;;
    NSString * str = @"";
    if (model.playnum.intValue > 10000) {
        str =  [NSString stringWithFormat:@"%0.1f万人在观看",model.playnum.floatValue/10000.0];
    }else {
        str =  [NSString stringWithFormat:@"%@人在观看",model.playnum];
    }
    self.numberLB.text = str;
    self.desLB.text = model.name;
}

@end
