//
//  SWTMinePaySettingVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMinePaySettingVC.h"

@interface SWTMinePaySettingVC ()
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *gouBt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNoTF;

@end

@implementation SWTMinePaySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付安全";
    self.confirmBt.backgroundColor = RedColor;
    self.confirmBt.layer.cornerRadius = 15;
    self.confirmBt.clipsToBounds = YES;
   
}
- (IBAction)xieYiaction:(id)sender {
    
    
    
    
}
- (IBAction)gouAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;

}
- (IBAction)confrimAction:(id)sender {

    if (self.passwordTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    if (self.cardNoTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入证件号"];
        return;
    }
    if (self.gouBt.selected) {
        [SVProgressHUD showErrorWithStatus:@"请勾选个人信息协议"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"idcard"] = self.cardNoTF.text;
    dict[@"name"] = self.nameTF.text;
    dict[@"paypassword"] = self.passwordTF.text;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",userPay_SWT,[zkSignleTool shareTool].session_uid] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
       
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"支付设置成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
 
        
    }];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
