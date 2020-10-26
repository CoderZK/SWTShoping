//
//  SWTTuiHuoKuaiDiDanHaoVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuoKuaiDiDanHaoVC.h"

@interface SWTTuiHuoKuaiDiDanHaoVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UITextField *orderTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *desTF;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , assign)NSInteger selectIndex;

@end

@implementation SWTTuiHuoKuaiDiDanHaoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流信息填写";
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.desTF.text = self.model.remark;
    self.orderTF.text = self.model.sn;
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchorderGet_express_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
            for (int i = 0; i<self.dataArray.count;i++) {
                if ([self.dataArray[i].express isEqualToString:self.model.express]) {
                    self.nameTF.text = self.dataArray[i].name;
                    self.selectIndex = i;
                    break;
                }
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}

- (IBAction)tijiaoAction:(UIButton *)sender {
    if (self.orderTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写物流单号"];
        return;
    }
    if (self.nameTF.text.length  ==0 ) {
        [SVProgressHUD showErrorWithStatus:@"请选择物流公司"];
        return;
    }
    
    if (self.desTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入备注"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"express"] = self.dataArray[self.selectIndex].express;
    dict[@"expressname"] = self.dataArray[self.selectIndex].name;
    dict[@"id"] = self.model.ID;
    dict[@"sn"] = self.orderTF.text;
    dict[@"remark"] = self.desTF.text;
    [zkRequestTool networkingPOST:orderBackexpress_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"填写订单号成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
}

- (IBAction)action:(id)sender {
    [self.view endEditing:YES];
    NSMutableArray * arr = @[].mutableCopy;
    for (SWTModel * model  in self.dataArray) {
        [arr addObject:model.name];
    }
    zkPickView * pickV = [[zkPickView alloc] init];
    pickV.arrayType = titleArray;
    pickV.array = arr;
    [pickV show];
    pickV.delegate = self;
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    self.selectIndex = leftIndex;
    self.nameTF.text = self.dataArray[leftIndex].name;
}



@end
