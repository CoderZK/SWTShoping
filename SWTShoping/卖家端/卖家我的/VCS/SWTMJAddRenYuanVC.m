//
//  SWTMJAddRenYuanVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJAddRenYuanVC.h"

@interface SWTMJAddRenYuanVC ()
@property (weak, nonatomic) IBOutlet UITextField *TFOne;
@property (weak, nonatomic) IBOutlet UITextField *TFTwo;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;

@end

@implementation SWTMJAddRenYuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加管理员";
    self.confirmBt.layer.cornerRadius = 22.5;
    self.confirmBt.clipsToBounds = YES;
}

- (IBAction)confirmAction:(id)sender {
    
    if (self.TFOne.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入添加人员账号"];
        return;
    }
    if (self.TFOne.text != self.TFTwo.text) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的账号不一样"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    dict[@"mobile"] = self.TFOne.text;
    [zkRequestTool networkingPOST:merchset_admin_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
       
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"添加管理人员成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
      
        
    }];
    
}


@end
