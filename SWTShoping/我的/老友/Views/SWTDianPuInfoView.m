//
//  SWTDianPuInfoView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTDianPuInfoView.h"

@interface SWTDianPuInfoView()
@property(nonatomic , assign)BOOL  isJianTou;
@property(nonatomic , assign)NSInteger maxNumber;

@end

@implementation SWTDianPuInfoView

- (instancetype)initWithFrame:(CGRect)frame withIsJianTou:(BOOL)isJianTou withMaxNumber:(NSInteger)maxNumer{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isJianTou = isJianTou; // 1 为 有箭头 , 2 为无箭头
        self.maxNumber = maxNumer;
        
        self.leftLB =[[UILabel alloc] init];
        self.leftLB.font = kFont(14);
        self.leftLB.textColor = CharacterColor50;
        [self addSubview:self.leftLB];
        
        self.rightTF =[[UITextField alloc] init];
        self.rightTF.font = kFont(14);
        self.rightTF.textAlignment = NSTextAlignmentRight;
        self.rightTF.textColor = CharacterColor50;
        [self addSubview:self.rightTF];
        [[[self.rightTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
           return YES;
        }] subscribeNext:^(NSString * _Nullable x) {
            if (x.length > maxNumer) {
                self.rightTF.text = [x substringToIndex:maxNumer];
            }
        }];
        
        
        self.rightBt =[[UIButton alloc] init];
        [self addSubview:self.rightBt];
        
        self.rightImgV =[[UIImageView alloc] init];
        self.rightImgV.image = [UIImage imageNamed:@"you"];
        [self addSubview:self.rightImgV];
        
        self.lineV = [[UIView alloc] init];
        self.lineV.backgroundColor = lineBackColor;
        [self addSubview:self.lineV];
        
        if (isJianTou) {
            self.rightBt.hidden = NO;
            self.rightTF.userInteractionEnabled = NO;
        }else {
            self.rightBt.hidden = YES;
            self.rightTF.userInteractionEnabled = YES;
        }
        
        [self setCons];
        
    }
    return self;
    
}

- (void)setCons {
    [self.leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.equalTo(@20);
        make.centerY.equalTo(self);
    }];
    
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        if (!self.isJianTou) {
           make.height.width.equalTo(@0);
        }else {
           make.height.width.equalTo(@12);
        }
        make.centerY.equalTo(self);
    }];
    
    
    [self.rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImgV.mas_left);
        make.height.equalTo(@20);
        make.centerY.equalTo(self);
    }];
    
    
    [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@30);
        make.centerY.equalTo(self);
    }];
    
    [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
    
   
}

@end
