//
//  SWTMJMineOneCell.m
//  SWTZBMH
//
//  Created by kunzhang on 2020/8/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineOneCell.h"

@implementation SWTMJMineOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickAction:(UIButton *)sender {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(sender.tag)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
