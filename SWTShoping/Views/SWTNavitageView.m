//
//  SWTNavitageView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTNavitageView.h"

@implementation SWTNavitageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIImageView * vv = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, ScreenW, frame.size.height)];
        vv.image = [UIImage  imageNamed:@"minebg"];
        [self addSubview:vv];

        
        
        UILabel * titelLB  = [[UILabel alloc]  initWithFrame:CGRectMake(20, sstatusHeight, ScreenW - 80, 44)];
        titelLB.font = kFont(18);
        titelLB.textAlignment = NSTextAlignmentCenter;
        titelLB.text = @"上海达文拍卖场";
        titelLB.textColor = WhiteColor;
        [self addSubview:titelLB];
        
        UIButton * leftBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, sstatusHeight, 44, 44)];
        [leftBt setImage:[UIImage imageNamed:@"wback"] forState:UIControlStateNormal];
        [self addSubview:leftBt];
     
        
        UIButton * rightBt  =[[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 50, sstatusHeight, 50, 44)];
        rightBt.titleLabel.font = kFont(14);
        [rightBt setTitle:@"私信" forState:UIControlStateNormal];
        [self addSubview:rightBt];
        
        self.rightBt = rightBt;
        self.leftBt = leftBt;
        self.titleLB = titelLB;
        self.imgV = vv;
        
    }
    
    return self;
}

@end
