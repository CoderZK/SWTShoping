//
//  SWTShaiXuanRightView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShaiXuanRightView.h"
#import "SWTShaiXuanBtView.h"

@interface SWTShaiXuanRightView()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)NSArray<SWTModel *> *caiZhiArr;
@property(nonatomic , strong)SWTShaiXuanBtView *fuwuView,*caiLiaoView;
@property(nonatomic , strong)UIButton *queDingBt;
@end

@implementation SWTShaiXuanRightView

- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray<SWTModel *> *)caiZhiArr {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.caiZhiArr = caiZhiArr;
        
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(ScreenW, sstatusHeight + 44 , ScreenW * 3/4, ScreenH - sstatusHeight - 44)];
        [self addSubview:self.whiteV];
        
        self.whiteV.backgroundColor = [UIColor whiteColor];
        
//        self.queDingBt = [[UIButton alloc] init];
//        [self.queDingBt setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
//        self.queDingBt.titleLabel.font = kFont(14);
//        [self.queDingBt setTitleColor:WhiteColor forState:UIControlStateNormal];
//        [self.queDingBt addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.queDingBt setTitle:@"确定" forState:UIControlStateNormal];
//        [self.whiteV addSubview:self.queDingBt];
//        [self.queDingBt mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.whiteV).offset(10);
//            make.right.equalTo(self.whiteV).offset(-10);
//            make.bottom.equalTo(self.whiteV).offset(-34);
//            make.height.equalTo(@40);
//        }];
//        
        [self initSubV];
        
    }
    
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//
//
//        self.backgroundColor = [UIColor clearColor];
//
//        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
//        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(ScreenW, sstatusHeight + 44 , ScreenW * 3/4, ScreenH - sstatusHeight - 44)];
//        [self addSubview:self.whiteV];
//
//        self.whiteV.backgroundColor = [UIColor whiteColor];
//
//        [self initSubV];
//
//    }
//
//    return self;
//}

- (void)initSubV  {
    CGFloat ww = ScreenW * 3 / 4;
    UILabel * LB  =[[UILabel alloc] initWithFrame:CGRectMake(10, 15, ww - 20, 20)];
    LB.text = @"价格区间";
    LB.font = kFont(15);
    [self.whiteV addSubview:LB];
    
    
    UITextField * leftTF  = [[UITextField alloc] init];
    leftTF.placeholder = @"最低价";
    leftTF.font = kFont(14);
    leftTF.keyboardType = UIKeyboardTypeDecimalPad;
    leftTF.textAlignment = NSTextAlignmentCenter;
    leftTF.backgroundColor = BackgroundColor;
    leftTF.layer.cornerRadius = 3;
    leftTF.clipsToBounds = YES;
    [self.whiteV addSubview:leftTF];
    [leftTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteV).offset(10);
        make.top.equalTo(self.whiteV).offset(50);
        make.height.equalTo(@30);
        make.width.equalTo(@(ww/3.0));
    }];
    
    UITextField * rightTF  = [[UITextField alloc] init];
    rightTF.placeholder = @"最高价";
    rightTF.font = kFont(14);
    rightTF.textAlignment = NSTextAlignmentCenter;
    rightTF.keyboardType = UIKeyboardTypeDecimalPad;
    rightTF.backgroundColor = BackgroundColor;
    rightTF.layer.cornerRadius = 3;
    rightTF.clipsToBounds = YES;
    [self.whiteV addSubview:rightTF];
    [rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteV).offset(-10);
        make.top.equalTo(leftTF);
        make.height.equalTo(@30);
        make.width.equalTo(@(ww/3.0));
    }];
    
    UIView * lineV  =[[UILabel alloc] init];
    lineV.backgroundColor = lineBackColor;
    [self.whiteV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.width.equalTo(@(50));
        make.centerX.equalTo(self.whiteV);
        make.centerY.equalTo(leftTF);
    }];
    
    UILabel * LB2  =[[UILabel alloc] initWithFrame:CGRectMake(10, 100, ww - 20, 20)];
    LB2.text = @"服务";
    LB2.font = kFont(15);
    [self.whiteV addSubview:LB2];
   
    NSArray * arr = @[@"滴雨轩拍卖行",@"直营店",@"优选好店",@"包邮",@"包退",@"代工工作室"];

    self.fuwuView = [[SWTShaiXuanBtView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(LB2.frame) + 10 , ww - 20 , 20)];
    [self.whiteV addSubview:self.fuwuView];
    self.fuwuView.isTitleArr = YES;
    self.fuwuView.dataArray = arr;
    Weak(weakSelf);
    self.fuwuView.mj_h = self.fuwuView.hh;
    self.fuwuView.selectBlock = ^{
        if (weakSelf.shaiXuanBlock != nil) {
            weakSelf.shaiXuanBlock(leftTF.text, rightTF.text, weakSelf.caiLiaoView.selectArr, weakSelf.fuwuView.selectDict);
        };
    };
    
    UILabel * LB3  =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.fuwuView.frame) + 20, ww - 20, 20)];
    LB3.text = @"材料";
    LB3.font = kFont(15);
    [self.whiteV addSubview:LB3];
    
    self.caiLiaoView = [[SWTShaiXuanBtView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(LB3.frame) + 10 , ww - 20 , 20)];
    self.caiLiaoView.dataArray = self.caiZhiArr;
    self.caiLiaoView.mj_h = self.caiLiaoView.hh;
    [self.whiteV addSubview:self.caiLiaoView];
    self.caiLiaoView.selectBlock = ^{
         if (weakSelf.shaiXuanBlock != nil) {
             weakSelf.shaiXuanBlock(leftTF.text, rightTF.text, weakSelf.caiLiaoView.selectArr, weakSelf.fuwuView.selectDict);
         };
    };
    
    
    
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_x = ScreenW * 1 / 4;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_x = ScreenW;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
