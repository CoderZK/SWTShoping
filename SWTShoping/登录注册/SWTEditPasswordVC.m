//
//  SWTEditPasswordVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTEditPasswordVC.h"
#import "SWTLoginTwoVC.h"
@interface SWTEditPasswordVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UITextField *oldTF;
@property (weak, nonatomic) IBOutlet UITextField *nOneTF;
@property (weak, nonatomic) IBOutlet UITextField *nTwoTF;

@end

@implementation SWTEditPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBt.layer.cornerRadius  = 22.5;
    self.loginBt.clipsToBounds =  YES;
    self.navigationItem.title = @"修改密码";
}
- (IBAction)confirM:(id)sender {
    
    if (self.oldTF.text.length > 6 || self.oldTF.text.length > 16) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-16位密码"];
        return;
    }
    if (self.nOneTF.text.length > 6 || self.nOneTF.text.length > 16) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-16位新密码"];
        return;
    }
    
    if([self.nOneTF.text isEqualToString:self.nTwoTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一样"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"newpassword"] = self.nOneTF.text;
    dict[@"password"] = self.oldTF.text;
    [zkRequestTool networkingPOST:editpassword_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                SWTLoginTwoVC * vc =[[SWTLoginTwoVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.phoneStr = [zkSignleTool shareTool].phone;
                vc.passwordStr = self.nOneTF.text;
                [self.navigationController pushViewController:vc animated:YES];
                
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
