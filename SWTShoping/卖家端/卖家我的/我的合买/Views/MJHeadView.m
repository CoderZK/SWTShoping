//
//  MJHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeadView.h"

@implementation MJHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.statusLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30, 20)];
        self.statusLB.font = kFont(15);
        self.statusLB.textColor = WhiteColor;
        self.statusLB.text = @"待分料";
        [self addSubview:self.statusLB];
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, ScreenW - 30, 20)];
        self.timeLB.font = kFont(13);
        self.timeLB.textColor = WhiteColor;
        self.timeLB.text = @"1天23小时29分后未处理将自动收回";
        [self addSubview:self.timeLB];;
        
    }
    return self;
}

@end
