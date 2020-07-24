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
        self.imgV.image = [UIImage imageNamed:@"369"];
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
        
        self.Bt =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [self addSubview:self.Bt];
        
        self.rightLB = [[UILabel alloc] initWithFrame:CGRectMake( 45 , 0, frame.size.width - 50 , 18)];
        self.rightLB.font = kFont(10);
        self.rightLB.textAlignment = NSTextAlignmentRight;
        self.rightLB.textColor = WhiteColor;
        [self addSubview:self.rightLB];
        self.rightLB.text = @"1.5万观看";
        
        
        
        
        
        self.centerLB = [[UILabel alloc] initWithFrame:CGRectMake(25, frame.size.height - 40 - 17, 80, 14)];
        self.centerLB.textColor = CharacterColor102;
        self.centerLB.backgroundColor  =[UIColor colorWithWhite:0 alpha:0.4];
        self.centerLB.font = kFont(8);
        self.centerLB.text = @"     喜欢,怎么了";
//        [self addSubview:self.centerLB];
        self.centerLB.layer.cornerRadius = 7;
        self.centerLB.clipsToBounds = YES;
        
        self.headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15 , frame.size.height - 35 - 20 , 20, 20)];
        self.headImgV.layer.cornerRadius = 10;
        self.headImgV.clipsToBounds = YES;
        self.headImgV.image = [UIImage imageNamed:@"369"];
        [self addSubview:self.headImgV];
        
        
        self.bottomLB = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 25, frame.size.width  - 20, 15)];
        self.bottomLB.text = @"精美瓷器";
        self.bottomLB.font = kFont(12);
        self.bottomLB.textColor = WhiteColor;
        [self addSubview:self.bottomLB];

        
        self.Bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.Bt];
        
        
        
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        
    }
    
    return self;
}

@end
