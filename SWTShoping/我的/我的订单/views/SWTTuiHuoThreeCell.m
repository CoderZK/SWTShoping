//
//  SWTTuiHuoThreeCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuoThreeCell.h"

@implementation SWTTuiHuoThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.rightBt.layer.cornerRadius = self.leftBt.layer.cornerRadius = 15;
    self.leftBt.clipsToBounds = self.rightBt.clipsToBounds = YES;
    self.leftBt.layer.borderWidth = self.rightBt.layer.borderWidth = 0.5;
    self.leftBt.layer.borderColor = CharacterColor102.CGColor;
    self.rightBt.layer.borderColor = CharacterColor102.CGColor;
    
    self.lineV.backgroundColor = lineBackColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//0 退款中 1 退货中 2 成功
- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 0) {
        self.riCons.constant = self.wdCons.constant = 0;
    }else if (type == 1) {
        
    }else if (type == 2) {
        
        self.rightBt.hidden = self.leftBt.hidden = YES;
    }
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    if (model.address.length == 0) {
        //退款
        self.riCons.constant = self.wdCons.constant = 0;
        if (model.backstatus.intValue == -1) {
            [self.leftBt setTitle:@"失败" forState:UIControlStateNormal];
        }else if (model.backstatus.intValue == 1) {
            [self.leftBt setTitle:@"撤销申请" forState:UIControlStateNormal];
        }else if (model.backstatus.intValue == 2) {
            [self.leftBt setTitle:@"已完成" forState:UIControlStateNormal];
        }
    }else {
        
        self.riCons.constant = 15;
        self.wdCons.constant = 90;
        
        self.leftBt.hidden = YES;
       if (model.backstatus.intValue == -1) {
            [self.rightBt setTitle:@"失败" forState:UIControlStateNormal];
        }else if (model.backstatus.intValue == 1) {
            if ([model.isshowexpress isEqualToString:@"false"]) {
               [self.rightBt setTitle:@"填写物流单号" forState:UIControlStateNormal];
            }else {
                [self.rightBt setTitle:@"修改物流单号" forState:UIControlStateNormal];
            }
            self.leftBt.hidden = NO;
        }else if (model.backstatus.intValue == 2) {
            [self.rightBt setTitle:@"已完成" forState:UIControlStateNormal];
        }
        
    }
}

@end
