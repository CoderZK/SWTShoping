//
//  SWTHeMaiOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaiOneCell.h"

@implementation SWTHeMaiOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bakcV.layer.cornerRadius = 3;
    self.bakcV.clipsToBounds = YES;
}

@end
