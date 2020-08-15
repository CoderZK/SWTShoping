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
        self.navigationItem.title = @"镜拍设置";
        self.titleLB.text = @"保证金自动从余额扣除";
    }else {
        self.viewOne.hidden = YES;
        self.yyCons.constant = 0;
        self.navigationItem.title = @"出价条件设置";
        self.titleLB.text = @"限制V0用户出价";
    }
}
- (IBAction)action:(id)sender {
    
    
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
