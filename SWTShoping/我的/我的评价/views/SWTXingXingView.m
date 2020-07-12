//
//  SWTXingXingView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/11.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTXingXingView.h"



@implementation SWTXingXingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        CGFloat ww = frame.size.height;
        CGFloat space = (frame.size.width - 5*ww)/4;
        
        for (int i = 0;i< 5; i++) {
            UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(i*(ww+space), 0, ww, ww)];
            [button setBackgroundImage:[UIImage imageNamed:@"xingblack"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"xingred"] forState:UIControlStateSelected];
            button.tag = 100+i;
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];

        }
        
        
    }
    
    return self;
}

- (void)clickAction:(UIButton *)button {
    for (int i = 100 ; i < 105; i++) {
        UIButton * buNei  = [self viewWithTag:i];
        if (buNei.tag <= button.tag ) {
            buNei.selected = YES;
        }else {
            buNei.selected = NO;
        }
    }
}


@end
