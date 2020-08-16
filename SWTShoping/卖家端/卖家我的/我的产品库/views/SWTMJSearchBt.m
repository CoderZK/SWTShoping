//
//  SWTMJSearchBt.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJSearchBt.h"

@implementation SWTMJSearchBt

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     
        self.textLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 10, frame.size.height)];
        self.textLB.font = kFont(14);
        [self addSubview:self.textLB];
        
        self.rightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.textLB.frame) + 2, (frame.size.height - 6)/2, 8, 6)];
        self.rightImgV.image =[UIImage imageNamed:@"bbdyx52"];
        [self addSubview:self.rightImgV];
        
    }
    
    return self;
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (isSelect) {
        self.rightImgV.image =[UIImage imageNamed:@"bbdyx51"];
        self.textLB.textColor = YellowColor;
    }else {
        self.rightImgV.image = [UIImage imageNamed:@"bbdyx52"];
        self.textLB.textColor = CharacterColor70;
    }
}

@end
