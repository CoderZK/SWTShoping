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
    
    
}

- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
        
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
