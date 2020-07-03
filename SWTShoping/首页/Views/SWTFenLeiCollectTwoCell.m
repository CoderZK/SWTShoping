//
//  SWTFenLeiCollectTwoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTFenLeiCollectTwoCell.h"

@implementation SWTFenLeiCollectTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 17.5;
    self.imgV.clipsToBounds = YES;
}

@end
