//
//  SWTMineSectionHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineSectionHeadView.h"

@implementation SWTMineSectionHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.titleLB =[[UILabel alloc] init];
        self.titleLB.font= [UIFont systemFontOfSize:14];
        self.titleLB.textColor = CharacterColor50;
        [self addSubview:self.titleLB];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
            make.height.equalTo(@20);
        }];
        self.titleLB.text = @"精品推荐";
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

@end
