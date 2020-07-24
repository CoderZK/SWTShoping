//
//  SWTTuiHuoDesCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuoDesCell.h"

@implementation SWTTuiHuoDesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backV.clipsToBounds = YES;
    self.backV.layer.cornerRadius  = 3;
    self.backV.backgroundColor = BackgroundColor;
    
    
      
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
