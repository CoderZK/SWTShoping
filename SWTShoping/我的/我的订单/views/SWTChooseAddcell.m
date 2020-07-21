//
//  SWTChooseAddcell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTChooseAddcell.h"

@implementation SWTChooseAddcell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backV.backgroundColor = BackgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    if (model == nil) {
        self.morenLB.hidden = self.nameLB.hidden = self.phoneLB.hidden = self.addressLB.hidden = YES;
        self.contentLB.hidden = NO;
    }else {
        self.morenLB.hidden = !model.is_default;
        self.nameLB.hidden = self.phoneLB.hidden = self.addressLB.hidden = NO;
        
        self.contentLB.hidden = YES;
        self.nameLB.text = model.realname;
        self.phoneLB.text = model.mobile;
        self.addressLB.text =  [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.district,model.address_info];
    }
    
}

@end
