//
//  SWTHomeCollectionTwoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHomeCollectionTwoCell.h"

@implementation SWTHomeCollectionTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.headImgV.layer.cornerRadius = 15;
    self.headImgV.clipsToBounds = YES;
    self.headImgV.layer.borderColor = CharacterColor183.CGColor;
    self.headImgV.layer.borderWidth = 0.5;
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    
}

@end
