//
//  SWTMJTiXianTWoVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/11/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJTiXianTWoVC.h"

@interface SWTMJTiXianTWoVC ()
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *carTypeTF;
@property (weak, nonatomic) IBOutlet UITextField *carNoTF;
@property (weak, nonatomic) IBOutlet UITextField *carNoTwoTF;

@end

@implementation SWTMJTiXianTWoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    self.moneyLB.text = [NSString stringWithFormat:@"可提现金额: ￥%@",self.moenyStr.getPriceAllStr];
}
- (IBAction)allAction:(id)sender {
    
    
    self.moneyTF.text = self.moenyStr.getPriceAllStr;
    
    
}


- (IBAction)tixianAction:(id)sender {
    
    if (self.moneyTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
        return;
    }
    
    if (self.moneyTF.text.doubleValue > self.moenyStr.doubleValue) {
        [SVProgressHUD showErrorWithStatus:@"提现金额不能大于可提现金额"];
        return;
    }
    if (self.moneyTF.text.doubleValue <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入大于0的提现金额"];
        return;
    }
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入持卡人姓名"];
        return;
    }
    
    if (self.carTypeTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入开户行"];
        return;
    }
    if (self.carNoTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入银行卡号"];
        return;
    }
    if (![self.carNoTF.text isEqualToString:self.carNoTwoTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的银行卡号不相同"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"card"] = self.carNoTwoTF.text;
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    dict[@"name"] = self.nameTF.text;
    dict[@"type"] = self.carTypeTF.text;
    dict[@"money"] = self.moneyTF.text;
    [zkRequestTool networkingPOST:merchwithdrawalapply_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
            [SVProgressHUD showSuccessWithStatus:@"提现申请成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];
    
}



@end
