//
//  SWTRegistVC.m
//  TTT
//
//  Created by zk on 2020/7/6.
//  Copyright © 2020 张坤. All rights reserved.
//

#import "SWTRegistVC.h"
#import "LxmWebViewController.h"
@interface SWTRegistVC ()
@property (weak, nonatomic) IBOutlet UIButton *gouBt;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UIButton *xieYiBt;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIButton *yinsiBt;
@property (weak, nonatomic) IBOutlet UIButton *codeBt;
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;

@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;

@end

@implementation SWTRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isForgetPassword){
        self.navigationItem.title = @"忘记密码";
        self.gouBt.hidden = self.lb2.hidden = self.lb1.hidden = self.xieYiBt.hidden = self.yinsiBt.hidden = YES;
    }else {
        self.navigationItem.title = @"注册";
    }
    
    self.codeBt.layer.cornerRadius = 3;
    self.codeBt.clipsToBounds = YES;
    self.codeBt.layer.borderColor = CharacterColor50.CGColor;
    self.codeBt.layer.borderWidth = 0.5;
    [self.codeBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    
    
    self.confirmBt.layer.cornerRadius =  22.5;
    self.confirmBt.clipsToBounds = YES;

    
    
}

- (IBAction)clickAction:(UIButton *)sender {
    
    if (sender.tag == 100) {
        [self sendCodeAction:sender];
    }else if (sender.tag == 101) {
        sender.selected = !sender.selected;
    }else if (sender.tag == 102) {
        //协议
        LxmWebViewController * vc =[[LxmWebViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 103) {
        //隐私
           LxmWebViewController * vc =[[LxmWebViewController alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 104) {
       //确定
        
        
    }
    
}


- (void)timeAction {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
    self.codeBt.userInteractionEnabled = NO;
    self.number = 60;
    
    
}

- (void)timerStar {
    _number = _number -1;
    if (self.number > 0) {
        [self.codeBt setTitle:[NSString stringWithFormat:@"%lds后重发",_number] forState:UIControlStateNormal];
    }else {
        [self.codeBt setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.codeBt.userInteractionEnabled = YES;
    }
    
    
}

//发送验证码
- (void)sendCodeAction:(UIButton *)button  {
    
    [self timeAction];

//    button.userInteractionEnabled = NO;
//    NSMutableDictionary * dataDict = @{@"phone":self.TF.text ,@"type":@"1"}.mutableCopy;
//    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_sendVerificationCodeURL] parameters:dataDict success:^(NSURLSessionDataTask *task, id responseObject) {
//        button.userInteractionEnabled = YES;
//        if ([responseObject[@"key"] intValue]== 1) {
//             [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
//            ALCCodeVC * vc =[[ALCCodeVC alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            vc.phoneStr = self.TF.text;
//            [self.navigationController pushViewController:vc animated:YES];
//
//        }else {
//            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//        button.userInteractionEnabled = YES;
//
//    }];
    
}



@end
