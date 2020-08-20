//
//  SWTMJMineChanPinKuOneVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineChanPinKuOneVC.h"
#import "SWTMJMineChanPinKuTwoTVC.h"
@interface SWTMJMineChanPinKuOneVC ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *statusBt;

@end

@implementation SWTMJMineChanPinKuOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的产品库";
}
- (IBAction)kaiTongAction:(id)sender {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchDo_open_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
     
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"开启产品库成功"];
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
