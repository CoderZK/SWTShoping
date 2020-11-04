//
//  SWTHuoDeShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHuoDeShowView.h"

@interface SWTHuoDeShowView()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UILabel *titleLB,*moneyLB,*timeLB;
@property(nonatomic , strong)UIImageView *imgV;
@property(nonatomic , strong)UIButton *payBt;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)double  number;
@end

@implementation SWTHuoDeShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
        
        NSLog(@"%@",@"67777777777");
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(30, (ScreenH - 400)/2, ScreenW - 60, 400)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        CGFloat ww = ScreenW - 60;
        
        UILabel * titleLB  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,ww , 40)];
        titleLB.backgroundColor = RedColor;
        titleLB.text = @"恭喜 **** 成功拍得";
        titleLB.font = kFont(14);
        titleLB.textColor = WhiteColor;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [self.whiteV addSubview:titleLB];
        
        UIImageView * imgV  = [[UIImageView alloc] initWithFrame:CGRectMake((ww-180)/2, 60, 180, 160)];
        imgV.image =  [UIImage imageNamed:@"369"];
        [self.whiteV addSubview:imgV];
        
        
        UILabel * lb2  =[[UILabel alloc] initWithFrame:CGRectMake(ww/2-30, CGRectGetMaxY(imgV.frame) + 10 , 60, 20)];
        lb2.textColor = CharacterColor70;
        lb2.font = kFont(14);
        lb2.textAlignment =NSTextAlignmentCenter;
        [self.whiteV addSubview:lb2];
        lb2.text = @"成交价";
        
        UIView * lineOneV  =[[UIView alloc] initWithFrame:CGRectMake(10, 20, ww /2 - 15 - 20, 0.5)];
        lineOneV.backgroundColor = lineBackColor;
        lineOneV.centerY = lb2.centerY;
        [self.whiteV addSubview:lineOneV];
        
        UIView * lineTwoV  =[[UIView alloc] initWithFrame:CGRectMake(ww /2  + 15  +10, 20, ww /2 - 15 - 20, 0.5)];
        lineTwoV.backgroundColor = lineBackColor;
        lineTwoV.centerY = lb2.centerY;
        [self.whiteV addSubview:lineTwoV];
        
        UILabel * moneyLb  = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lb2.frame) + 10, ww - 20, 25)];
        
        moneyLb.textAlignment = NSTextAlignmentCenter;
        moneyLb.font = [UIFont systemFontOfSize:20 weight:0.3];
        moneyLb.text =  [NSString stringWithFormat:@"￥%@",@""];
        moneyLb.textColor = RedColor;
        [self.whiteV addSubview:moneyLb];
        
        UILabel * timeLB  = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(moneyLb.frame) + 20 , ww-20, 17)];
        timeLB.text = @"剩余有效时间:";
        timeLB.font = kFont(13);
        timeLB.textColor = CharacterColor102;
        timeLB.textAlignment = NSTextAlignmentCenter;
        [self.whiteV addSubview:timeLB];
        
        UIButton * payBt  =[[UIButton alloc] initWithFrame:CGRectMake(ww/2 - 60, CGRectGetMaxY(timeLB.frame) + 15, 120, 40)];
        [payBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        payBt.titleLabel.font = kFont(14);
        [payBt setTitle:@"支付" forState:UIControlStateNormal];
        payBt.layer.cornerRadius = 20;
        [payBt addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
        
        payBt.clipsToBounds = YES;
        [self.whiteV addSubview:payBt];
        payBt.backgroundColor = RedColor;
        
        self.timeLB = timeLB;
        self.payBt = payBt;
        self.titleLB = titleLB;
        self.moneyLB = moneyLb;
        self.imgV  = imgV;
        
        
        
    }
    
    return self;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    self.titleLB.text = [NSString stringWithFormat:@"恭喜 %@ 成功拍得",model.username];
    self.moneyLB.text = [NSString stringWithFormat:@"￥%@",model.price.getPriceAllStr];
    [self.imgV sd_setImageWithURL:model.img.getPicURL placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    
    self.number = 0;
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(getNumberActionTwo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //    [LSTTimer removeTimerForIdentifier:@"huode"];
    //    Weak(weakSelf);
    //       [LSTTimer addTimerForTime:model.resttime.doubleValue /1000 identifier:@"huode" handle:^(NSString * _Nonnull day, NSString * _Nonnull hour, NSString * _Nonnull minute, NSString * _Nonnull second, NSString * _Nonnull ms) {
    //           if (day.dou + hour.intValue + minute.intValue + second.intValue + ms.intValue <= 0) {
    //               weakSelf.timeLB.text = @"已结束";
    //               [weakSelf dismiss];
    ////               [LSTTimer removeAllTimer];
    //
    //           }else {
    //               weakSelf.timeLB.text = [NSString stringWithFormat:@"剩余时间:%@",[NSString stringWithFormat:@"%@天%@小时%@分%@秒",day,hour,minute,second]];
    ////               [weakSelf setNeedsLayout];
    ////               [weakSelf layoutIfNeeded];
    //
    //               [weakSelf.timeLB layoutIfNeeded];
    //               [weakSelf.timeLB layoutSubviews];
    ////               [weakSelf layoutSubviews];
    //           }
    //
    //       }];
    
    
    
}

- (void)setIsOeder:(BOOL)isOeder{
    _isOeder = isOeder;
    self.payBt.hidden = !isOeder;
}


- (void)getNumberActionTwo {
    
    self.number++;
    Weak(weakSelf);
    NSInteger totalSeconds = self.model.resttime.doubleValue/1000 - self.number;
    NSString *days = [NSString stringWithFormat:@"%zd", totalSeconds/60/60/24];
    NSString *hours =  [NSString stringWithFormat:@"%zd", totalSeconds/60/60%24];
    NSString *minute = [NSString stringWithFormat:@"%zd", (totalSeconds/60)%60];
    NSString *second = [NSString stringWithFormat:@"%zd", totalSeconds%60];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (totalSeconds <=0) {
            [self.timer invalidate];
            self.timer = nil;
            weakSelf.timeLB.text = @"已结束";
            [weakSelf dismiss];
            
            [weakSelf setNeedsLayout];
            [weakSelf layoutIfNeeded];
        }else {
            
            weakSelf.timeLB.text = [NSString stringWithFormat:@"%@天%@小时%@分%@秒",days,hours,minute,second];
            [weakSelf setNeedsLayout];
            [weakSelf layoutIfNeeded];
        }
        
        
    });
    
    
    
}

- (void)payAction:(UIButton *)button {
//    [self dismiss];
    self.hidden = YES;
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:self.model];
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            //        self.whiteV.mj_y = ScreenH;
            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
         
        }];
    });
    
    
}
@end
