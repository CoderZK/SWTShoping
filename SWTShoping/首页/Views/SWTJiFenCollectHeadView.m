//
//  SWTJiFenCollectHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTJiFenCollectHeadView.h"

@interface SWTJiFenCollectHeadView()

@property(nonatomic , strong)UIView *leftV,*rightV;

@end


@implementation SWTJiFenCollectHeadView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
     
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(14);
        self.titleLB.textColor = CharacterColor70;
        [self addSubview:self.titleLB];
        
        self.leftV = [[UIView alloc] init];
        self.leftV.backgroundColor = CharacterColor70;
        [self addSubview:self.leftV];
        
        self.rightV = [[UIView alloc] init];
        self.rightV.backgroundColor = CharacterColor70;
        [self addSubview:self.rightV];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.equalTo(@20);
        }];
        
        [self.leftV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@25);
            make.height.equalTo(@1);
            make.right.equalTo(self.titleLB.mas_left).offset(-15);
            make.centerY.equalTo(self);
        }];

        [self.rightV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@25);
            make.height.equalTo(@1);
            make.left.equalTo(self.titleLB.mas_right).offset(15);
            make.centerY.equalTo(self);
        }];
        
        
    }
    
    return self;
}


@end
