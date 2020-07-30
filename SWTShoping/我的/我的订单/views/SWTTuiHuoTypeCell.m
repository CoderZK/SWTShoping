//
//  SWTTuiHuoTypeCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuoTypeCell.h"

@implementation SWTTuiHuoTypeCell
- (IBAction)click:(UIButton *)sender {
    if (sender.tag == 100) {
        self.leftBt.selected = YES;
        self.rightBt.selected = NO;
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:@"1"];
        }
    }else {
       self.leftBt.selected = NO;
        self.rightBt.selected = YES;
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:@"2"];
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
