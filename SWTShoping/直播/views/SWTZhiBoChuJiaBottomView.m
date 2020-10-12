//
//  SWTZhiBoChuJiaBottomView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoChuJiaBottomView.h"

@interface SWTZhiBoChuJiaBottomView()
@property(nonatomic , strong)UIView *chujiaV;
@property(nonatomic , strong)UIButton *leftBt,*rightBt,*chujiaBt;
@property(nonatomic , strong)UITextField *priceTF;
@end

@implementation SWTZhiBoChuJiaBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.chujiaV = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 210 , 30)];
        self.chujiaV.layer.cornerRadius = 15;
        self.chujiaV.clipsToBounds = YES;
        self.chujiaV.layer.borderColor = WhiteColor.CGColor;
        self.chujiaV.layer.borderWidth = 1.0;
        [self addSubview:self.chujiaV];
        
        self.leftBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        self.leftBt.titleLabel.font = kFont(14);
        [self.leftBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.leftBt.backgroundColor = RGB(141, 86, 26);
        self.leftBt.tag = 100;
        [self.leftBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.chujiaV addSubview:self.leftBt];
        [self.leftBt setTitle:@"-100" forState:UIControlStateNormal];
        
        self.rightBt = [[UIButton alloc] initWithFrame:CGRectMake(140, 0, 70, 30)];
        self.rightBt.titleLabel.font = kFont(14);
        [self.rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.rightBt.backgroundColor = RGB(214,136, 26);
        [self.chujiaV addSubview:self.rightBt];
        [self.rightBt setTitle:@"+100" forState:UIControlStateNormal];
        self.rightBt.tag = 101;
        [self.rightBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        self.priceTF  =[[UITextField alloc] initWithFrame:CGRectMake(70, 0, 70, 30)];
        self.priceTF.keyboardType = UIKeyboardTypeDecimalPad;
        self.priceTF.font = kFont(14);
        self.priceTF.textColor = WhiteColor;
        [self.chujiaV addSubview:self.priceTF];
        self.priceTF.textAlignment = NSTextAlignmentCenter;
        self.priceTF.text = @"10000";

        
        
        
        self.chujiaBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 105 - 30, 15, 80, 30)];
        self.chujiaBt.titleLabel.font = kFont(14);
        [self.chujiaBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self.chujiaBt setBackgroundImage:[UIImage imageNamed:@"rbg"] forState:UIControlStateNormal];
        self.chujiaBt.layer.cornerRadius = 15;
        self.chujiaBt.clipsToBounds = YES;
        [self.chujiaBt setTitle:@"出价" forState:UIControlStateNormal];
        [self addSubview:self.chujiaBt];
        self.chujiaBt.tag = 102;
        [self.chujiaBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * messageBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW  - 40, 15, 30, 30)];
        [self addSubview:messageBt];
        [messageBt setBackgroundImage:[UIImage imageNamed:@"bbdyx65"] forState:UIControlStateNormal];
        messageBt.tag = 103;
    
        [messageBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return self;
}

- (void)action:(UIButton *)button {
    CGFloat price = self.priceTF.text.doubleValue;
    CGFloat stepPrice = self.model.stepprice.doubleValue;
    CGFloat nowPrice = self.model.price.doubleValue;
    if (button.tag == 100) {
        //点击减号
        if (price - stepPrice < nowPrice) {
            [SVProgressHUD showErrorWithStatus:@"出价不能小于当前最新价格"];
        }else {
            self.priceTF.text = [NSString stringWithFormat:@"%0.2f",price - stepPrice];
        }
    }else if (button.tag == 101) {
        //点击加好
        self.priceTF.text = [NSString stringWithFormat:@"%0.2f",price + stepPrice];
    }else if (button.tag == 102) {
        // 点击出价
        [self chuJiaAction:button];
        
    }else if (button.tag == 103){
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:@"-1"];
        }
    }
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.leftBt setTitle:[NSString stringWithFormat:@"-%@",model.stepprice] forState:UIControlStateNormal];
    [self.rightBt setTitle:[NSString stringWithFormat:@"+%@",model.stepprice] forState:UIControlStateNormal];
    self.priceTF.text = model.price;
    
}

- (void)chuJiaAction:(UIButton *)button {

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"goodid"]= self.model.ID;
    dict[@"price"] = [NSString stringWithFormat:@"%0.2f",self.priceTF.text.doubleValue];;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:goodOffer_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"您出价:%0.2f 成功",self.priceTF.text.doubleValue]];
            
//            if (self.delegateSignal) {
//                [self.delegateSignal sendNext:self.priceTF.text];
//            }
            
            
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}


@end
