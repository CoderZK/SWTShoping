//
//  SWTMJAddYouHuiQuanBt.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJAddYouHuiQuanBt.h"

@implementation SWTMJAddYouHuiQuanBt

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.topLB = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height - 37 )/2, frame.size.width, 17)];
        self.topLB.font = kFont(14);
        [self addSubview:self.topLB];
        self.topLB.text = @"98折";
        
        
        self.bottomLB = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topLB.frame) + 5, frame.size.width, 15)];
        self.bottomLB.font = kFont(12);
        [self addSubview:self.bottomLB];
        self.bottomLB.text = @"满8000使用";
        
        self.topLB.textAlignment = self.bottomLB.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}


- (void)setType:(NSInteger)type {
    _type = type;
    
    if (type == 0) {
        [self setBackgroundImage:[UIImage imageNamed:@"bbdyx74"] forState:UIControlStateNormal];
        self.topLB.textColor = self.bottomLB.textColor = RedLightColor;
    }else if (type == 1) {
        [self setBackgroundImage:[UIImage imageNamed:@"bbdyx29"] forState:UIControlStateNormal];
        self.topLB.textColor = self.bottomLB.textColor = RedLightColor;
    }else {
        [self setBackgroundImage:[UIImage imageNamed:@"bbdyx30"] forState:UIControlStateNormal];
        self.topLB.textColor = self.bottomLB.textColor = CharacterColor50;
    }
    
    
    
    
}

@end
