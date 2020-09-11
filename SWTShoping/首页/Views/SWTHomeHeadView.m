//
//  SWTHomeHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHomeHeadView.h"


@interface SWTHomeHeadView()<SDCycleScrollViewDelegate>

@end

@implementation SWTHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, sstatusHeight + 44 + 10 + (ScreenW - 30) / 345 * 150 - 20)];
        self.imgV.image = [UIImage imageNamed:@"bg"];
        [self addSubview:self.imgV];
//        self.imgV.contentMode = UIViewContentModeScaleToFill;
        self.backgroundColor = WhiteColor;
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imgV.frame), ScreenW, 130)];
        [self addSubview:self.whiteV];
        
        self.sdView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0 ,sstatusHeight + 44 + 10 , ScreenW  , (ScreenW) / 345 * 150)];
        self.sdView.delegate = self;
//        self.sdView.layer.cornerRadius = 5;
//        self.sdView.clipsToBounds = YES;
        self.sdView.pageControlDotSize = CGSizeMake(3, 3);
        self.sdView.currentPageDotColor = [UIColor orangeColor];
        self.sdView.pageDotColor = WhiteColor;
        self.sdView.imageURLStringsGroup = @[];
  
        [self addSubview:self.sdView];
        
        
        
        self.whiteV.backgroundColor = WhiteColor;
        NSArray * arr = @[@"直播",@"商城",@"精品视频",@"分类"];
        CGFloat space = (ScreenW - 4* 45 )/8;
        for (int i  = 0 ; i < 4 ; i++) {
            UIImageView * imgV =[[UIImageView alloc] initWithFrame:CGRectMake(space + i* (2* space + 45 ), 40, 45, 45)];
            imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"shop%d",i+1]];
            [self.whiteV addSubview:imgV];
            UILabel * LB  = [[UILabel alloc] initWithFrame:CGRectMake(i*(ScreenW/4), CGRectGetMaxY(imgV.frame) +5, ScreenW /4 , 18)];
            LB.font = kFont(14);
            LB.textColor = CharacterColor70;
            LB.text = arr[i];
            LB.textAlignment = NSTextAlignmentCenter;
            [self.whiteV addSubview:LB];
            
            UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(i*(ScreenW/4), CGRectGetMinY(imgV.frame), ScreenW/4, 70)];
            [self.whiteV addSubview:button];
            
            button.tag = i+100;
            
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        
        
    }
    
    return self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickHomeHeadViewWithIndex:andIsLunBoTu:)]) {
        [self.delegate didClickHomeHeadViewWithIndex:index andIsLunBoTu:YES];
    }
}

- (void)clickAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickHomeHeadViewWithIndex:andIsLunBoTu:)]) {
        [self.delegate didClickHomeHeadViewWithIndex:button.tag -100 andIsLunBoTu:NO];
    }
}

@end
