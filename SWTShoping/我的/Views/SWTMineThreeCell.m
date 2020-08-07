//
//  SWTMineThreeCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineThreeCell.h"
#import "SWTMineHomeButton.h"
@implementation SWTMineThreeCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 17)];
        self.titleLB.textColor = CharacterColor50;
        self.titleLB.font = kFont(14);
        self.titleLB.text = @"我的订单";
        [self addSubview:self.titleLB];
        CGFloat ww = 70;
        CGFloat space = (frame.size.width - 4* ww) / 8;
        NSArray * arr =  @[@"我的收藏",@"参拍记录",@"我的钱包",@"合买",@"我的客服",@"帮助与反馈",@"联系我们",@"我要开店"];
        for (int i = 0 ; i < arr.count; i++) {
            
            SWTMineHomeButton * bt  = [[SWTMineHomeButton alloc] initWithFrame:CGRectMake(space + (2*space + ww) * (i%4), 32 + i/4 * ww , ww, ww ) withImageWidth:22];
            bt.imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"mine%d",i+10]];
            bt.titleLB.text = arr[i];
            [self addSubview:bt];
            bt.tag = i+100;
            [bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    self.backgroundColor = WhiteColor;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    return self;
}

- (void)clickAction:(UIButton *)button {
    if (self.mineThreeCellBlock != nil) {
        self.mineThreeCellBlock(button.tag - 100);
    }
}

@end
