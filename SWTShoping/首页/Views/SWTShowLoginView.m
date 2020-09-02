//
//  SWTShowLoginView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShowLoginView.h"



@implementation SWTShowLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.leftLB = [[UILabel alloc] init];
        self.leftLB.textColor = WhiteColor;
        self.leftLB.font = kFont(14);
        self.leftLB.text = @"登录体验";
        [self addSubview:self.leftLB];
        
        [self.leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        
        self.rightBt = [[UIButton alloc] init];
        self.rightBt.titleLabel.font = kFont(14);
        [self.rightBt setTitle:@"立即登录" forState:UIControlStateNormal];
        [self.rightBt setBackgroundColor:RedColor];
        self.rightBt.layer.cornerRadius = 15;
        self.rightBt.clipsToBounds = YES;
        [self addSubview:self.rightBt];
        [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.centerY.equalTo(self);
            make.height.equalTo(@30);
            make.width.equalTo(@80);
        }];
        
        
        
    }
    
    return self;
}

@end
