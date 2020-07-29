//
//  SWTHeMaiThreeCollectCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaiThreeCollectCell.h"

@implementation SWTHeMaiThreeCollectCell

- (void)setModel:(SWTModel *)model {
    _model = model;
    
    NSString * str = @"";
                  if (model.watchnum.intValue > 10000) {
                      str =  [NSString stringWithFormat:@"%0.1f万人在观看",model.watchnum.floatValue/10000.0];
                  }else {
                      str =  [NSString stringWithFormat:@"%@人在观看",model.watchnum];
                  }
    
    self.numberLb.text = str;
    self.shopNameLB.text = model.store_name;
    self.titleLB.text = model.name;
    [self.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
