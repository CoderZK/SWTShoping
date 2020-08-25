//
//  SWTAddChanPinHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAddChanPinHeadView.h"

@implementation SWTAddChanPinHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.leiBieV = [[SWTAddChnaPinTFV alloc] initWithFrame:CGRectMake(15, 15, 200, 25)];
        self.leiBieV.leftLB.text = self.leiBieV.lestStr =@"产品类别: ";
        self.leiBieV.isChoose = YES;
        self.leiBieV.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [self.leiBieV.delegateSignal subscribeNext:^(NSNumber * x) {
            @strongify(self);
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:@(100)];
            }
        }];
        [self addSubview:self.leiBieV];
        
        self.nameV = [[SWTAddChnaPinTFV alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.leiBieV.frame), (ScreenW - 35)/2, 25)];
        self.nameV.isChoose = YES;
        self.nameV.leftLB.text = self.nameV.lestStr = @"品名: ";
        self.nameV.delegateSignal = [[RACSubject alloc] init];
        [self.nameV.delegateSignal subscribeNext:^(NSNumber * x) {
            @strongify(self);
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:@(101)];
            }
            
            
        }];
        [self addSubview:self.nameV];
        
        
        self.addressV = [[SWTAddChnaPinTFV alloc] initWithFrame:CGRectMake(ScreenW/2+2.5, CGRectGetMinY(self.nameV.frame), (ScreenW - 35)/2, 25)];
        self.addressV.leftLB.text = self.addressV.lestStr =  @"产地: ";
        [self addSubview:self.addressV];
        
        
        self.guiGeV = [[SWTAddChnaPinTFV alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.nameV.frame), (ScreenW - 35)/2, 25)];
        self.guiGeV.leftLB.text = self.guiGeV.lestStr =  @"规格: ";
        [self addSubview:self.guiGeV];
        
        self.caizhiV = [[SWTAddChnaPinTFV alloc] initWithFrame:CGRectMake(ScreenW/2+2.5, CGRectGetMinY(self.guiGeV.frame), (ScreenW - 35)/2, 25)];
        self.caizhiV.leftLB.text = self.caizhiV.lestStr =  @"材质: ";
        [self addSubview:self.caizhiV];
        self.caizhiV.isChoose = YES;
        self.caizhiV.delegateSignal = [[RACSubject alloc] init];
        [self.caizhiV.delegateSignal subscribeNext:^(NSNumber * x) {
            @strongify(self);
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:@(102)];
            }
            
            
        }];
        
        self.weightV = [[SWTAddChnaPinTFV alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.caizhiV.frame), (ScreenW - 35)/2, 25)];
        self.weightV.leftLB.text = self.weightV.lestStr =  @"重量: ";
        [self addSubview:self.weightV];
        
        
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.weightV.frame), ScreenW - 30, 0.5)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        
        UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(backV.frame) + 15 , 80, 20)];
        lb.font = kFont(14);
        [self addSubview:lb];
        lb.text = @"产品标题";
        [self addSubview:lb];
        self.chanPinNameTF = [[UITextField alloc] initWithFrame:CGRectMake(95,CGRectGetMaxY(backV.frame) + 10 , ScreenW - 105, 30)];
        self.chanPinNameTF.placeholder = @"请输入标题";
        self.chanPinNameTF.font = kFont(14);
        [self addSubview:self.chanPinNameTF];
        
        UIView * backVTwo =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.chanPinNameTF.frame) + 10, ScreenW - 30, 0.5)];
        backVTwo.backgroundColor = lineBackColor;
        [self addSubview:backVTwo];
        
        self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(backVTwo.frame)+10, ScreenW - 16, 70)];
        self.TV.placeholder = @"产品描述";
        
        self.TV.font = kFont(14);
        [self addSubview:self.TV];
        CGFloat ww = (ScreenW - 60)/4;
        self.picV = [[UIScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.TV.frame) + 10, ScreenW - 20, ww)];
        self.picV.showsVerticalScrollIndicator = NO;
        self.picV.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.picV];
        
        self.HHHH = CGRectGetMaxY(self.picV.frame) + 10;
        
    }
    self.backgroundColor = WhiteColor;
    return self;
}

- (void)setPics {
    CGFloat ww = (ScreenW - 60)/4;
    CGFloat space = 10;
    CGFloat leftM = 0;
    [self.picV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i =0 ; i< self.picArr.count + 1; i++) {
        
        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake(leftM + (space+ ww) * i, 0, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;
        anNiuBt.backgroundColor = RGB(250, 250, 250);
        
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.picV addSubview:anNiuBt];
        
        UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake(ww - 25 , 0, 25, 25)];
        
        deleteBt.tag = 200+i;
        [deleteBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i < self.picArr.count) {
            
            if ([self.picArr[i] isKindOfClass:[UIImage class]]) {
                [anNiuBt setBackgroundImage:self.picArr[i] forState:UIControlStateNormal];
            }else {
                [anNiuBt sd_setBackgroundImageWithURL:[self.picArr[i] getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
            }
            [deleteBt setImage:[UIImage imageNamed:@"48"] forState:UIControlStateNormal];
            [anNiuBt addSubview:deleteBt];
        }else {
            [anNiuBt setBackgroundImage:[UIImage imageNamed:@"bbdyx72"] forState:UIControlStateNormal];
            
            
        }
        
        
        
    }
}

- (void)setPicArr:(NSMutableArray *)picArr {
    _picArr = picArr;
    
    [self setPics];
    
}

- (void)hitAction:(UIButton *)anNiuBt {
    
    if (anNiuBt.tag >=200) {
        //删除
        [self.picArr removeObjectAtIndex:anNiuBt.tag - 200];
        [self setPics];
        [self.delegateSignal sendNext: [NSString stringWithFormat:@"%ld",anNiuBt.tag]];
    }else {
        if (anNiuBt.tag - 100  == self.picArr.count) {
            //添加图片
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:@(199)];
            }
            
        }
        //        else if (anNiuBt.tag - 100  == self.picArr.count + 1) {
        //            //添加视频
        //            if (self.delegateSignal) {
        //                [self.delegateSignal sendNext:@(198)];
        //            }
        //        }
    }
}

@end
