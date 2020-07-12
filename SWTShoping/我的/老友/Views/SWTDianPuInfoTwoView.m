//
//  SWTDianPuInfoTwoView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTDianPuInfoTwoView.h"

@implementation SWTDianPuInfoTwoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLB =[[UILabel alloc] init];
               self.titleLB.font = kFont(14);
               self.titleLB.textColor = CharacterColor50;
               [self addSubview:self.titleLB];
        
        self.leftBt  =[[UIButton alloc] init];
        [self.leftBt setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:self.leftBt];
        self.leftBt.layer.cornerRadius = 5;
        self.leftBt.clipsToBounds = YES;
        self.leftBt.backgroundColor = [UIColor redColor];
        
        self.rigthImgV = [[UIImageView alloc] init];
        self.rigthImgV.backgroundColor =[UIColor greenColor];
        self.rigthImgV.layer.cornerRadius = 5;
        self.rigthImgV.clipsToBounds = YES;
        [self addSubview:self.rigthImgV];
        
        
        [self setCons];
               
    }
    
    return self;
}

- (void)setCons {
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(0);
        make.height.equalTo(@20);
    }];
    
    [self.leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self.titleLB.mas_bottom).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(@((ScreenW -30)/2));
    }];
    [self.rigthImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftBt);
        make.left.equalTo(self.leftBt.mas_right).offset(10);
        make.bottom.right.equalTo(self).offset(-10);
        make.width.equalTo(@((ScreenW -30)/2));
    }];
    
   
}

@end
