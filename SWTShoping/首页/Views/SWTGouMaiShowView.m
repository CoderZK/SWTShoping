//
//  SWTGouMaiShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGouMaiShowView.h"

@interface SWTGouMaiShowView()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIButton *chuaddBt;

@property(nonatomic , strong)UIImageView *leftimgV;
@property(nonatomic , strong)UILabel *leftOneLB,*leftTwoLb;
@property(nonatomic , strong)UIButton *jianBt,*addBt;
@property(nonatomic , strong)UITextField *numberTF;

@end

@implementation SWTGouMaiShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 250)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 40, 0, 40, 40)];
        [button1 setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:button1];
        
        self.leftimgV = [[UIImageView alloc] init];
        self.leftimgV.image = [UIImage imageNamed:@"369"];
        [self.whiteV addSubview:self.leftimgV];
        
        self.leftimgV.layer.cornerRadius = 3;
        self.leftimgV.clipsToBounds = YES;
        
        self.leftOneLB = [[UILabel alloc] init];
        self.leftOneLB.font = kFont(13);
        self.leftOneLB.textColor = CharacterColor70;
        self.leftOneLB.text = @"西施珍宝";
        [self.whiteV addSubview:self.leftOneLB];
        
        self.leftTwoLb = [[UILabel alloc] init];
        self.leftTwoLb.font = kFont(13);
        self.leftTwoLb.text = @"467";
        self.leftTwoLb.textColor = RedLightColor;
        [self.whiteV addSubview:self.leftTwoLb];
        
        UIView * backV =[[UIView alloc] init];
        backV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:backV];
        
        UIView * backTwoV =[[UIView alloc] init];
        backTwoV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:backTwoV];
        
        self.addBt = [[UIButton alloc] init];
        [self.addBt setTitle:@"+" forState:UIControlStateNormal];
        [self.addBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.addBt setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        self.addBt.titleLabel.font = kFont(14);
        [self.whiteV addSubview:self.addBt];
        self.addBt.tag = 101;
        [self.addBt addTarget:self action:@selector(clickAcion:) forControlEvents:UIControlEventTouchUpInside];
        
        self.jianBt = [[UIButton alloc] init];
        [self.jianBt setTitle:@"-" forState:UIControlStateNormal];
        [self.jianBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.jianBt setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        self.jianBt.titleLabel.font = kFont(14);
        [self.whiteV addSubview:self.jianBt];
        self.jianBt.tag = 100;
        [self.jianBt addTarget:self action:@selector(clickAcion:) forControlEvents:UIControlEventTouchUpInside];
        
        self.numberTF = [[UITextField alloc] init];
        self.numberTF.font = kFont(12);
        self.numberTF.textAlignment = NSTextAlignmentCenter;
        self.numberTF.keyboardType = UIKeyboardTypeNumberPad;
        self.numberTF.textColor = [UIColor blackColor];
        self.numberTF.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.numberTF.text = @"1";
        [self.whiteV addSubview:self.numberTF];
        
        
        
        
        UILabel * lb = [[UILabel alloc] init];
        lb.font = kFont(14);
        lb.textColor = CharacterColor70;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"购买数量";
        [self.whiteV addSubview:lb];
        
        
        self.chuaddBt = [[UIButton alloc] init];
        self.chuaddBt.tag = 102;
        [self.chuaddBt setTitle:@"立即购买" forState:UIControlStateNormal];
        self.chuaddBt.titleLabel.font = kFont(14);
        [self.chuaddBt setBackgroundImage:[UIImage imageNamed:@"rbg"] forState:UIControlStateNormal];
        [self.chuaddBt addTarget:self action:@selector(clickAcion:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:self.chuaddBt];
        
        
        [self.leftimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.whiteV).offset(30);
            make.left.equalTo(self.whiteV).offset(15);
            make.height.width.equalTo(@85);
        }];
        
        [self.leftOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self.whiteV).offset(-10);
            make.top.equalTo(self.leftimgV).offset(8);
            make.height.equalTo(@17);
        }];
        
        [self.leftTwoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self.whiteV).offset(-10);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(15);
            make.right.equalTo(self.whiteV).offset(-15);
            make.height.equalTo(@0.5);
            make.top.equalTo(self.leftimgV.mas_bottom).offset(10);
        }];
        
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(15);
            make.height.equalTo(@20);
            make.top.equalTo(backV.mas_bottom).offset(9.5);
        }];
        
        [self.addBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteV).offset(-15);
            make.height.width.equalTo(@17);
            make.top.equalTo(backV.mas_bottom).offset(11);
        }];
        
        
        [self.numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.addBt.mas_left).offset(-15);
            make.height.equalTo(@17);
            make.width.equalTo(@30);
            make.top.equalTo(backV.mas_bottom).offset(11);
        }];
        
        [self.jianBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.numberTF.mas_left).offset(-15);
            make.height.width.equalTo(@17);
            make.top.equalTo(backV.mas_bottom).offset(11);
        }];
        
        [backTwoV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(15);
            make.right.equalTo(self.whiteV).offset(-15);
            make.height.equalTo(@0.5);
            make.top.equalTo(backV.mas_bottom).offset(39);
        }];
        
        [self.chuaddBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backTwoV.mas_bottom).offset(25);
            make.left.equalTo(self.whiteV).offset(20);
            make.right.equalTo(self.whiteV).offset(-20);
            make.height.equalTo(@35);
        }];
        
        @weakify(self);
        [[self.numberTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.leftTwoLb.text =  [NSString stringWithFormat:@"￥%0.2f",self.model.price.floatValue * self.numberTF.text.intValue];
        }];
        
    }
    
    return self;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.leftimgV sd_setImageWithURL:[model.thumb getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    
    self.leftTwoLb.text =  [NSString stringWithFormat:@"￥%@",[model.price getPriceAllStr]];
    self.leftOneLB.text = model.name;
}

- (void)clickAcion:(UIButton *)button {
    if (button.tag == 100) {
        if (self.numberTF.text.intValue > 1) {
            self.numberTF.text =  [NSString stringWithFormat:@"%d",self.numberTF.text.intValue - 1];
        }
        self.leftTwoLb.text =  [NSString stringWithFormat:@"￥%0.2f",self.model.price.floatValue * self.numberTF.text.intValue];
    }else if (button.tag == 101) {
        self.numberTF.text =  [NSString stringWithFormat:@"%d",self.numberTF.text.intValue + 1];
        self.leftTwoLb.text =  [NSString stringWithFormat:@"￥%0.2f",self.model.price.floatValue * self.numberTF.text.intValue];
    }else if (button.tag == 102) {
        if (self.numberTF.text.length == 0 || self.numberTF.text.intValue == 0){
            [SVProgressHUD showErrorWithStatus:@"至少要购买1个"];
            return;
        };
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:self.numberTF.text];
            [self dismiss];
        }
        
    }
    
    
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 250;
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
