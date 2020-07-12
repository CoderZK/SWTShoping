//
//  SWTHeMaiMineDingZhiShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaiMineDingZhiShowView.h"
@interface SWTHeMaiMineDingZhiShowView()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIButton *leftBtBt,*rightBt;


@end

@implementation SWTHeMaiMineDingZhiShowView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 380)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        UIButton * closeBt  =[[UIButton alloc] init];
        [closeBt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [closeBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:closeBt];
        
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, ScreenW, 17)];
        lb.font = kFont(14);
        lb.textColor = CharacterColor50;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"我的合买定制";
        [self.whiteV addSubview:lb];
        
        UIView * lineV = [[UIView alloc] init];
        lineV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:lineV];
        
        [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.width.width.equalTo(@30);
                 make.right.equalTo(self.whiteV).offset(-5);
                 make.top.equalTo(self.whiteV).offset(5);
             }];
        
        
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(closeBt.mas_bottom).offset(10);
            make.left.right.equalTo(self.whiteV);
            make.height.equalTo(@20);
        }];
        
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
        
     
        
        
        
        
        
    }
    
    return self;
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 380;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
