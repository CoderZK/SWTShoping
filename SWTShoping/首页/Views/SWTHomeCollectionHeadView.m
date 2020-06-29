//
//  SWTHomeCollectionHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHomeCollectionHeadView.h"

@implementation SWTHomeCollectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.redV = [[UIView alloc] init];
        self.redV.backgroundColor = TabberGreen;
        [self addSubview:self.redV];
        [self.redV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.height.equalTo(@18);
            make.width.equalTo(@2);
            make.centerY.equalTo(self);
        }];
        
        self.titleLB =[[UILabel alloc] init];
        self.titleLB.font= [UIFont systemFontOfSize:16 weight:0.2];
        [self addSubview:self.titleLB];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.redV.mas_right).offset(5);
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
            make.height.equalTo(@20);
        }];
        
        self.titleLB.text = @"精品推荐";
    }
    
    return self;
}


@end
