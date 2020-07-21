//
//  SWTMienAddressCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMienAddressCell.h"

@implementation SWTMienAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    self.nameLB.text = model.realname;
    self.phoneLB.text = model.mobile;
    self.addressLB.text =  [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.address_info];
    self.morenLB.hidden = !model.is_default;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
