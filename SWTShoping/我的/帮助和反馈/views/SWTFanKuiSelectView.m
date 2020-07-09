//
//  SWTFanKuiSelectView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTFanKuiSelectView.h"

@implementation SWTFanKuiSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.leftImgV = [[UIImageView alloc] init];
        self.leftImgV.image = [UIImage imageNamed:@"gou"];
        [self addSubview:self.leftImgV];
        
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(14);
        self.titleLB.textColor = CharacterColor50;
        [self addSubview:self.titleLB];
        
        self.button = [[UIButton alloc] init];
        [self addSubview:self.button];
        [self.leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.centerY.equalTo(self);
            make.height.width.equalTo(@10);
        }];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(self.leftImgV.mas_right).offset(5);
            make.right.equalTo(self).offset(-5);
            make.centerY.equalTo(self);
        }];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    
    return self;
}
@end
