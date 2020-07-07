//
//  SWTMineHomeButton.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineHomeButton.h"

@implementation SWTMineHomeButton

- (instancetype)initWithFrame:(CGRect)frame withImageWidth:(CGFloat)width {
    self = [super initWithFrame:frame];
    CGFloat allH = frame.size.height;
    CGFloat allW = frame.size.width;
    CGFloat offY = width / 2 - 3;
    if (self) {
        
        self.imgV = [[UIImageView alloc] init];
        [self addSubview:self.imgV];
        self.imgV.image = [UIImage imageNamed:@"369"];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self);
            make.width.height.equalTo(@(width));
            make.centerY.equalTo(self.mas_centerY).offset(-(12));

        }];
        
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(13);
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.textColor = CharacterColor70;
        [self addSubview:self.titleLB];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.imgV.mas_bottom).offset(6);
            make.height.equalTo(@18);
        }];
        
    }
    
    return self;
}

@end
