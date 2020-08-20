//
//  SWTMJJingPaiOrChuJiaSettingVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJJingPaiOrChuJiaSettingVC.h"

@interface SWTMJJingPaiOrChuJiaSettingVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yyCons;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UISwitch *swiftBt;
@property (weak, nonatomic) IBOutlet UIView *viewOne;

@end

@implementation SWTMJJingPaiOrChuJiaSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isBaoZhengJin) {
        self.navigationItem.title = @"竞拍设置";
        self.titleLB.text = @"保证金自动从余额扣除";
    }else {
        self.viewOne.hidden = YES;
        self.yyCons.constant = 0;
        self.navigationItem.title = @"出价条件设置";
        self.titleLB.text = @"限制V0用户出价";
    }
    
    if (self.isBaoZhengJin) {
        self.swiftBt.on = self.model.autodeduct;
    }else {
        self.swiftBt.on = self.model.level_open;
    }
    
}
- (IBAction)action:(id)sender {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;

        if (self.isBaoZhengJin) {
            dict[@"autodeduct"] = self.swiftBt.on ? @"0":@"1";
        }else {
            dict[@"level_open"] = self.swiftBt.on ? @"0":@"1";
        }
        
    dict[@"id"] = self.model.ID;
    [zkRequestTool networkingPOST:merchUpd_merchinfo_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (self.isBaoZhengJin) {
                self.model.autodeduct = !self.swiftBt.on ;
            }else {
                self.model.autodeduct = !self.swiftBt.on;
            }
            self.swiftBt.on = !self.swiftBt.on;
            if (self.autoBlock != nil) {
                self.autoBlock(self.model);
            }
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
