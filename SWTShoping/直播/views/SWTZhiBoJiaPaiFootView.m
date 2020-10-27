//
//  SWTZhiBoJiaPaiFootView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/10/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoJiaPaiFootView.h"

@interface SWTZhiBoJiaPaiFootView()
@property(nonatomic,strong)UIView *wihteV,*redV;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *titleLB,*jiaJiaLB;
@property(nonatomic,strong)UIButton *timeBt,*rightBt;



@end

@implementation SWTZhiBoJiaPaiFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.wihteV = [[UIView alloc] init];
        self.wihteV.backgroundColor = WhiteColor;
        [self addSubview:self.wihteV];
        self.wihteV.layer.cornerRadius = 5;
        self.wihteV.clipsToBounds = YES;
        
        [self.wihteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-20);
        }];
        
        
        self.redV = [[UIView alloc] init];
        [self.wihteV addSubview:self.redV];
        self.redV.backgroundColor = RedColor;
        [self.redV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.wihteV);
            make.height.equalTo(@15);
        }];
        
        
        UILabel * lb = [[UILabel alloc] init];
        lb.textColor = WhiteColor;
        lb.text = @"竞拍";
        lb.font = kFont(13);
        [self.redV addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.redV).offset(10);
            make.bottom.top.right.equalTo(self.redV);
            
        }];
        
        self.imgV = [[UIImageView alloc] init];
        self.imgV.image = [UIImage imageNamed:@"369"];
        [self.wihteV addSubview:self.imgV];
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wihteV).offset(5);
            make.top.equalTo(self.wihteV).offset(20);
            make.width.height.equalTo(@65);
            
        }];
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(13);
        self.titleLB.textColor = CharacterColor50;
        [self.wihteV addSubview:self.titleLB];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgV);
            make.height.equalTo(@16);
            make.left.equalTo(self.imgV.mas_right).offset(5);
        }];
        self.titleLB.text = @"竞拍快点来啊啊";
    
        self.timeBt = [[UIButton alloc] init];
        [self.timeBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        self.timeBt.titleLabel.font  = kFont(12);
        self.timeBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.timeBt setImage:[UIImage imageNamed:@"naozhong"] forState:UIControlStateNormal];
        [self.wihteV addSubview:self.timeBt];
        [self.timeBt setTitle:@"77777" forState:UIControlStateNormal];
        
        self.jiaJiaLB = [[UILabel alloc] init];
        self.jiaJiaLB.font = kFont(13);
        self.jiaJiaLB.textColor = RedColor;
        [self.wihteV addSubview:self.jiaJiaLB];
        [self.jiaJiaLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB);
            make.bottom.equalTo(self.imgV);
            make.height.equalTo(@16);
        }];
        self.jiaJiaLB.text = @"3456";
        [self.timeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLB);
            make.top.equalTo(self.titleLB.mas_bottom).offset(5);
            make.height.equalTo(@14);
            
        }];
        
        self.rightBt = [[UIButton alloc] init];
        self.rightBt.backgroundColor = RedColor;
        [self.rightBt setTitle:@"出价" forState:UIControlStateNormal];;
        [self.rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.rightBt.titleLabel.font = kFont(13);
        [self.wihteV addSubview:self.rightBt];
        [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.wihteV).offset(-10);
            make.bottom.equalTo(self.wihteV).offset(-8);
            make.height.equalTo(@18);
            make.width.equalTo(@70);
        }];
        
        UIImageView * sanJianImgV  =[[UIImageView alloc] init];
        sanJianImgV.image = [UIImage imageNamed:@"sanjian"];
        [self addSubview:sanJianImgV];
        [sanJianImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.wihteV.mas_bottom).offset(-8);
            make.height.width.equalTo(@20);
            make.left.equalTo(self).offset(20);
        }];
        
     
        [self.rightBt addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setPriceStr:(NSString *)PriceStr {
    _PriceStr = PriceStr;
    
    self.jiaJiaLB.text =  [NSString stringWithFormat:@"￥%@",PriceStr.getPriceAllStr];
    
    
}


- (void)setModel:(SWTModel *)model {
    _model = model;
    
    
    [self.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.name;
    self.jiaJiaLB.text =  [NSString stringWithFormat:@"￥%@",model.nowprice];
    Weak(weakSelf);
    
    [LSTTimer removeTimerForIdentifier:@"yanshi"];
    
    [LSTTimer addTimerForTime:model.resttime.intValue /1000 identifier:@"yanshi" handle:^(NSString * _Nonnull day, NSString * _Nonnull hour, NSString * _Nonnull minute, NSString * _Nonnull second, NSString * _Nonnull ms) {
        
        
        if (day.intValue + hour.intValue + minute.intValue + second.intValue <= 0) {
            [weakSelf.timeBt setTitle:@"已结束" forState:UIControlStateNormal];
            
           
            if (self.isOrder) {
                [self tiJiaoOrderAction];
            }
        }else {
            
            NSLog(@"===thread %@",[NSThread currentThread]);
            
            [weakSelf.timeBt setTitle:[NSString stringWithFormat:@"%@天%@小时%@分%@秒",day,hour,minute,second] forState:UIControlStateNormal];
        }
        
    }];
    self.rightBt.hidden = self.isOrder;
}


- (void)tiJiaoOrderAction{
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"goodid"] = self.model.ID;
    dict[@"liveid"] = self.model.liveid;
    [zkRequestTool networkingPOST:livegenerorder1_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
    }];
}

- (void)rightAction:(UIButton *)button {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"123"];
    }
}

@end
