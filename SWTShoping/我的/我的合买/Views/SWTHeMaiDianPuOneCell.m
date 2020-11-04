//
//  SWTHeMaiDianPuOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaiDianPuOneCell.h"

@implementation SWTHeMaiDianPuOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
     [self initSubViews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//距离结束多少时多少秒
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
   
}


- (void)initSubViews {
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerChange) name:@"ListChangeNF" object:nil];
    
}


- (void)timerChange {
    NSInteger timeMS = [LSTTimer getTimeIntervalForIdentifier:@"listTimer"];
    NSInteger resTimeMS = self.timeInterval*1000 -timeMS;
    NSLog(@"%zd",timeMS);
    Weak(weakSelf);
    [LSTTimer formatDateForTime:resTimeMS handle:^(NSString * _Nonnull day, NSString * _Nonnull hour, NSString * _Nonnull minute, NSString * _Nonnull second, NSString * _Nonnull ms) {
        if (day.intValue + hour.intValue + minute.intValue + second.intValue == 0) {
            [weakSelf.timeBt setTitle:@"已结束"forState:UIControlStateNormal];
        }else {
            [weakSelf.timeBt setTitle:[NSString stringWithFormat:@"%@天%@:%@:%@",day,hour,minute,second] forState:UIControlStateNormal];
//            [weakSelf.timeBt setNeedsLayout];
            [weakSelf.timeBt setNeedsLayout];
            [weakSelf.timeBt layoutIfNeeded];
            [weakSelf setNeedsLayout];
            [weakSelf layoutIfNeeded];
//            [weakSelf.timeBt layoutSubviews];
        }
        
    }];
    
}


@end
