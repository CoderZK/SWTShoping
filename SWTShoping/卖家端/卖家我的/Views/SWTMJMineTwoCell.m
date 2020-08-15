//
//  SWTMineTwoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineTwoCell.h"
#import "SWTMineHomeButton.h"
@implementation SWTMJMineTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 17)];
        self.titleLB.textColor = CharacterColor50;
        self.titleLB.font = kFont(14);
        self.titleLB.text = @"店铺订单";
        UIImageView *imgV  =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenW - 21-20, 18, 11, 11)];
        imgV.image = [UIImage imageNamed:@"you"];
        
        UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 100 - 40, 14, 100, 20)];
        lb.text = @"查看全部";
        lb.font = kFont(13);
        lb.textAlignment = NSTextAlignmentRight;
        lb.textColor = CharacterColor70;
        [self addSubview:lb];
        
        
        UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(ScreenW / 2, 5, ScreenW / 2, 30)];
        [self addSubview:button];
        button.tag = 100;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:imgV];
        [self addSubview:self.titleLB];
        CGFloat ww = 60;
        CGFloat space = (ScreenW - 5* ww) / 6;
        NSArray * arr =  @[@"待付款",@"待发货",@"待收货",@"售后",@"店铺报表"];
        for (int i = 0 ; i < arr.count; i++) {
            
            SWTMineHomeButton * bt  = [[SWTMineHomeButton alloc] initWithFrame:CGRectMake(space + (space + ww) * i, 42, ww,50) withImageWidth:22];
            bt.imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"mine%d",i+5]];
            bt.titleLB.text = arr[i];
            [self addSubview:bt];
            bt.tag = i+101;
            [bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    self.backgroundColor = WhiteColor;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    return self;
}



- (void)clickAction:(UIButton *)button {
    if (self.mineTwoCellBlock != nil) {
        self.mineTwoCellBlock(button.tag - 100);
    }
}

@end
