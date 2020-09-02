//
//  SWTZhiBoPeopleComeInView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoPeopleComeInView.h"

@interface SWTZhiBoPeopleComeInView()
@property(nonatomic , strong)NSTimer *timer;
@property(nonatomic , assign)NSInteger  number;

@end

@implementation SWTZhiBoPeopleComeInView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(13);
        self.titleLB.textColor = WhiteColor;
        [self addSubview:self.titleLB];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        
        self.backgroundColor = RGB(140, 85, 27);
        self.layer.cornerRadius = 3;
        self.clipsToBounds = YES;
        
        self.number = 2;
        
        
        
    }
    
    return self;
}

- (void)show {
    self.hidden = NO;
    self.number = 2;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    
}

- (void)timeAction {
    self.number--;
   
    if (self.number <= 0) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
