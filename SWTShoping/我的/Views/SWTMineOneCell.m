//
//  SWTMineOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineOneCell.h"
#import "SWTMineHomeButton.h"
@implementation SWTMineOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headBt.layer.cornerRadius = 20;
    self.headBt.clipsToBounds = YES;
    self.vipBt.layer.cornerRadius = 8;
    self.vipBt.clipsToBounds = YES;
    self.edibtBt.layer.cornerRadius = 8;
    self.edibtBt.clipsToBounds = YES;
    self.edibtBt.layer.borderWidth = 0.5;
    self.edibtBt.layer.borderColor = RedColor.CGColor;
    
    NSArray * arr = @[@"我的竞拍",@"我的关注",@"我的消息",@"我的足迹"];
    CGFloat ww = 60;
    CGFloat space = (ScreenW - 20 - 4* ww)/8;
    for (int i  = 0 ; i < arr.count; i++) {
        
        SWTMineHomeButton * bt = [[SWTMineHomeButton alloc] initWithFrame:CGRectMake(space + (2*space + ww)*i, 60, ww, ww+30) withImageWidth:40];
        [self addSubview:bt];
        bt.imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"mine%d",i+1]];
        bt.titleLB.text = arr[i];
        bt.tag = i+100;
        [bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(space + 2, 150, ScreenW - 20 - 2*space - 4, 0.5)];
    backV.backgroundColor = lineBackColor;
    [self addSubview:backV];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(space + 2, 151 , ScreenW - 20 - 2*space - 4, 49);
    [button setImage:[UIImage imageNamed:@"mine18"] forState:UIControlStateNormal];
    [button setTitle:@"您关注的xx直播正在直播中" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    [self addSubview:button];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    button.tag = 107;
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.guanZhuBt = button;
//    
    self.layer.cornerRadius = 5;
    self.clipsToBounds  = YES;
}


- (IBAction)clickAction:(UIButton *)button {
    if (self.mineOneCellBlock != nil) {
        self.mineOneCellBlock(button.tag - 100);
    }
}

@end
