//
//  SWTMineThreeCell.m
//  SWTZBMH
//
//  Created by kunzhang on 2020/8/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineThreeCell.h"

@implementation SWTMJMineThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineV.backgroundColor = lineBackColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
