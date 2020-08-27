//
//  SWTMJFaHuoShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJFaHuoShowView.h"
@interface SWTMJFaHuoShowView()<zkPickViewDelelgate>
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UITextField *TF,*TFTwo;
@property(nonatomic , strong)UIButton *confirmBt;
@property(nonatomic , strong)NSMutableArray<SWTModel * > *dataArray;
@property(nonatomic , strong)SWTModel *slectModel;
@end
@implementation SWTMJFaHuoShowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
 
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 350)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
      
        
        UILabel * lb  = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenW - 30, 20)];
        lb.text = @"发货物流信息";
        lb.font = kFont(15);
        lb.textAlignment = NSTextAlignmentCenter;
        [self.whiteV addSubview:lb];
        
       UILabel * lb2  = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 80 , 20)];
        lb2.text = @"物流单号";
        lb2.font = kFont(16);
        [self.whiteV addSubview:lb2];
        
        self.TF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), CGRectGetMinY(lb2.frame) - 5, ScreenW - 100, 30)];
        self.TF.placeholder = @"请输入物流单号";
        self.TF.font = kFont(15);
        [self.whiteV addSubview:self.TF];
        
        UILabel * lb3  = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.TF.frame) +  15, 80 , 20)];
        lb3.text = @"物流单号";
        lb3.font = kFont(16);
        [self.whiteV addSubview:lb3];
        
        self.TFTwo = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb2.frame), CGRectGetMinY(lb3.frame) - 5, ScreenW - 100, 30)];
        self.TFTwo.placeholder = @"请选择物流公司";
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self.TFTwo addGestureRecognizer:tap];
        self.TFTwo.font = kFont(15);
        [self.whiteV addSubview:self.TFTwo];
        

        
        self.confirmBt = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.TFTwo.frame) + 30, ScreenW - 100, 40)];
        [self.confirmBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self.confirmBt setTitle:@"提交" forState:UIControlStateNormal];
        self.confirmBt.titleLabel.font = kFont(14);
        self.confirmBt.layer.cornerRadius = 20;
        self.confirmBt.clipsToBounds = YES;
        self.confirmBt.backgroundColor = [UIColor orangeColor];
        [self.whiteV addSubview:self.confirmBt];
        [self.confirmBt addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.dataArray = @[].mutableCopy;
        [self getData];
        
        
    }
    
    return self;
}

- (void)getData {
  
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchorderGet_express_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
     
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}

- (void)tap {
    
    NSMutableArray * arr = @[].mutableCopy;
    for (SWTModel * model  in self.dataArray) {
        [arr addObject:model.name];
    }
     zkPickView * pickV = [[zkPickView alloc] init];
       pickV.arrayType = titleArray;
       pickV.array = arr;
       pickV.selectLb.text = @"请选择快递公司";
       [pickV show];
       pickV.delegate = self;
}

- (void)confirmAction{
    if (self.TF.text.floatValue < 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入物流单号"];
        return;
    }
    if (self.TFTwo.text.floatValue < 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入物流公司名"];
        return;
    }
    if (self.slectModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择物流公司"];
        return;
    }
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@[self.TF.text,self.slectModel.ID,self.TFTwo.text,self.slectModel.express]];
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 350;
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

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    self.slectModel = self.dataArray[leftIndex];
    self.TFTwo.text = self.dataArray[leftIndex].name;
}


@end
