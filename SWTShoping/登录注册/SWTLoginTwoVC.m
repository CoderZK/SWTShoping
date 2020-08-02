//
//  SWTLoginTwoVC.m
//  TTT
//
//  Created by zk on 2020/7/6.
//  Copyright © 2020 张坤. All rights reserved.
//

#import "SWTLoginTwoVC.h"
#import "SWTRegistVC.h"
@interface SWTLoginTwoVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UIButton *weiXinBt;

@end

@implementation SWTLoginTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    
    self.loginBt.layer.cornerRadius = self.weiXinBt.layer.cornerRadius = 22.5;
    self.loginBt.clipsToBounds = self.weiXinBt.clipsToBounds = YES;
    self.loginBt.layer.borderWidth = self.weiXinBt.layer.borderWidth = 0.8;
    self.loginBt.layer.borderColor = self.weiXinBt.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.passwordTF.text = self.passwordStr;
    self.phoneTF.text = self.phoneStr;
    
    
    
}


- (void)loginAction  {
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.passwordTF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"mobile"] = self.phoneTF.text;
    dict[@"password"] = self.passwordTF.text;
    [zkRequestTool networkingPOST:login_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [zkSignleTool shareTool].session_token = responseObject[@"data"][@"accessToken"];
            [zkSignleTool shareTool].session_uid =  responseObject[@"data"][@"userid"];
            [zkSignleTool shareTool].isLogin = YES;
            [zkSignleTool shareTool].level =  responseObject[@"data"][@"level"];
            [zkSignleTool shareTool].phone = self.phoneTF.text;
            [zkSignleTool shareTool].userSig = responseObject[@"data"][@"usersig"];
            [zkSignleTool shareTool].nickname =  responseObject[@"data"][@"nickname"];
            
            [self loginIM];
            
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
     
        
    }];
}

- (void)loginIM {
    
    
    [[V2TIMManager sharedInstance] login:[zkSignleTool shareTool].session_uid userSig:[zkSignleTool shareTool].userSig succ:^{
        NSLog(@"%@",@"登录腾讯成功");
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"登录腾旭失败");
    }];
}

- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
        [self loginAction];
    }else if (sender.tag == 101) {
        SWTRegistVC * vc =[[SWTRegistVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 102) {
        SWTRegistVC * vc =[[SWTRegistVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isForgetPassword = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
