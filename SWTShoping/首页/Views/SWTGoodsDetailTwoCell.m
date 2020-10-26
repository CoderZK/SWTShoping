//
//  SWTGoodsDetailTwoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailTwoCell.h"

@implementation SWTGoodsDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
     [self initSubViews];
    
}
- (IBAction)clickAction:(UIButton *)sender {
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext: @(sender.tag)];
    }
    
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
    NSInteger timeMS = [LSTTimer getTimeIntervalForIdentifier:@"listTimerTwo"];
    NSInteger resTimeMS = self.timeInterval  -timeMS;
    NSLog(@"%zd======%f\n",timeMS,self.timeInterval);
    [LSTTimer formatDateForTime:resTimeMS handle:^(NSString * _Nonnull day, NSString * _Nonnull hour, NSString * _Nonnull minute, NSString * _Nonnull second, NSString * _Nonnull ms) {
        if (day.intValue + hour.intValue + minute.intValue + second.intValue == 0) {
            self.timeLB.text = @"已结束";
            [LTSCEventBus sendEvent:@"timeover" data:@""];
        
        }else {
            [LTSCEventBus sendEvent:@"timerun" data:@""];
            if (day > 0) {
               self.timeLB.text = [NSString stringWithFormat:@"剩余时间: %@天%@:%@:%@",day,hour,minute,second];
            }else {
               self.timeLB.text = [NSString stringWithFormat:@"剩余时间: %@:%@:%@",hour,minute,second];
            }
            
        }
        
    }];
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    self.titleLB.text = model.name;
    if ([model.isfav isEqualToString:@"yes"]) {
        [self.collectionBt setImage:[UIImage imageNamed:@"praise1"] forState:UIControlStateNormal];
    }else {
        [self.collectionBt setImage:[UIImage imageNamed:@"praise2"] forState:UIControlStateNormal];
    }
    
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",[model.price getPriceAllStr]];
    self.desLB.text =  [NSString stringWithFormat:@"市场估计:%@以上  加价%@以上  出价%@次数",[model.marketprice getPriceStr],model.stepprice,model.bidsnum];
    
    
    
}

@end
