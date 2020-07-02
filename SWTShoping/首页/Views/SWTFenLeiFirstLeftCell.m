//
//  SWTFenLeiFirstLeftCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTFenLeiFirstLeftCell.h"

@implementation SWTFenLeiFirstLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftV.backgroundColor = RedColor;
    self.leftV.hidden = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.titleLB.font = kFont(15);
        self.titleLB.textColor = RedColor;
        self.leftV.hidden = NO;
    }else {
        self.titleLB.font = kFont(13);
        self.titleLB.textColor = CharacterColor70;
        self.leftV.hidden = YES;
    }
    
    
    
    

}

@end
