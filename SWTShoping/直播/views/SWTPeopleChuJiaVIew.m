//
//  SWTPeopleChuJiaVIew.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTPeopleChuJiaVIew.h"

@implementation SWTPeopleChuJiaVIew


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = RedColor;
        UIBezierPath * mask  = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(frame.size.height/2.0, frame.size.height/2.0)];
        CAShapeLayer * shapeL  =[[CAShapeLayer alloc] init];
        shapeL.path = mask.CGPath;
        self.layer.mask = shapeL;
        
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 18)];
        self.nameLB.text = @"139****8888";
        self.nameLB.textColor = YellowColor;
        self.nameLB.font = kFont(15);
        [self addSubview:self.nameLB];
        
        UILabel * chaJialB  =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLB.frame) + 5, 10, 60, 20)];
        chaJialB.textColor = WhiteColor;
        chaJialB.font = kFont(15);
        chaJialB.text = @"出价";
        [self addSubview:chaJialB];
        
        self.moneyLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, frame.size.width - 30, 30)];
        self.moneyLB.font = [UIFont systemFontOfSize:25 weight:0.2];
        self.moneyLB.text = @"90000";
        self.moneyLB.textColor = WhiteColor;
        [self addSubview:self.moneyLB];
        
        
        
        
    }
    
    return self;
}

@end
