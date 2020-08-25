//
//  SWTAddChnaPinTFV.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAddChnaPinTFV.h"

@implementation SWTAddChnaPinTFV

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.leftLB = [[UILabel alloc] init];
        self.leftLB.font = kFont(14);
        [self addSubview:self.leftLB];
        [self.leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(@17);
            make.width.equalTo(@40);
            
        }];
        
        self.TF = [[UITextField alloc] init];
        self.TF.layer.borderWidth = 0.5;
        self.TF.layer.borderColor = CharacterColor102.CGColor;
        self.TF.font = kFont(13);
        self.TF.textColor = CharacterColor70;
        [self addSubview:self.TF];
        
        [self.TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftLB.mas_right).offset(5);
            make.height.equalTo(@17);
            make.right.equalTo(self).offset(-5);
            make.centerY.equalTo(self);
        }];
        
        
        
        
        
        
        
    }
    
    return self;
}

- (void)setLestStr:(NSString *)lestStr {
    _lestStr = lestStr;
    [self.leftLB mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([lestStr getWidhtWithFontSize:14]+ 5));
    }];
}

- (void)setIsChoose:(BOOL)isChoose {
    _isChoose = isChoose;
    if (isChoose) {
        UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.TF addGestureRecognizer:tap];
        
        
        UIImageView * imgV  =[[UIImageView alloc] init];
        [self.TF addSubview:imgV];
        imgV.image = [UIImage imageNamed:@"bbdyx42"];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.TF).offset(-2);
            make.width.width.equalTo(@8);
            make.height.equalTo(@6);
            make.centerY.equalTo(self.TF);
        }];
        
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    NSInteger tag = tap.view.tag;
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(tag)];
    }
    
}

@end
