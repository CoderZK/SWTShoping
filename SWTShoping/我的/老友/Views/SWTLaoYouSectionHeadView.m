//
//  SWTLaoYouSectionHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouSectionHeadView.h"

@implementation SWTLaoYouSectionHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(15);
        self.titleLB.textColor = CharacterColor50;
        [self addSubview:self.titleLB];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self);
            make.height.equalTo(@20);
        }];
        self.leftImgV =[[UIImageView alloc] init];
        self.leftImgV.image = [UIImage imageNamed:@"shop_icon_title1"];
        [self addSubview:self.leftImgV];
        [self.leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@26);
            make.height.equalTo(@13);
            make.centerY.equalTo(self);
            make.right.equalTo(self.titleLB.mas_left).offset(-20);
        }];
        
        self.rightImgV =[[UIImageView alloc] init];
        self.rightImgV.image = [UIImage imageNamed:@"shop_icon_title2"];
        [self addSubview:self.rightImgV];
        [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@26);
            make.height.equalTo(@13);
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLB.mas_right).offset(20);
        }];
        
    }
    self.backgroundColor = WhiteColor;
    self.contentView.backgroundColor = WhiteColor;
    return self ;
}

@end
