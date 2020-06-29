//
//  SWTHomeReMenView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHomeReMenView.h"

@implementation SWTHomeReMenView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgV  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.imgV];
        
        
        self.leftImgV  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 20)];
        self.leftImgV.image =[UIImage imageNamed:@"shop6"];
        [self addSubview:self.leftImgV];
        self.leftLB =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 20)];
        self.leftLB.font = kFont(10);
        self.leftLB.textAlignment = NSTextAlignmentCenter;
        self.leftLB.text = @"直播中";
        self.leftLB.textColor = WhiteColor;
        [self.leftImgV addSubview:self.leftLB];
        
        
        
        
        
        
        
        
    }
    
    return self;
}

@end
