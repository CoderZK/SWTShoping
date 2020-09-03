//
//  UIViewController+AlertShow.m
//  FMWXB
//
//  Created by kunzhang on 2017/11/10.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import "UIViewController+AlertShow.h"
#import "SWTLoginTwoVC.h"
#import "TabBarController.h"
@implementation UIViewController (AlertShow)

-(void)showAlertWithKey:(NSString *)num message:(NSString *)message{
    [SVProgressHUD dismiss];
    int n = [num intValue];
    NSString * msg = nil;
    
    switch (n)
    {
        case 1024:
        {
            msg = @"登录失效,请重新登录";
            [zkSignleTool shareTool].isLogin = NO;
            [zkSignleTool shareTool].session_uid = nil;
            [LTSCEventBus sendEvent:@"diss" data:nil];
            [[V2TIMManager sharedInstance] logout:nil fail:nil];
            break;
        }
           
        case 7:
        {
            
            
            break;
        }
          
        case 8:
        {
          
            break;
        }   
        default:
            msg=[NSString stringWithFormat:@"%@",message];
            break;
    }

    if (msg)
    {

        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * confirm =[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            if (n == 1024) {
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[SWTLoginTwoVC alloc] init] animated:YES completion:nil];
                
            }

        }];
        [alertVC addAction:confirm];
        
        if (n== 1024) {
            UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
                
                TabBarController * tabVC  = [[TabBarController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
                
            }];
            [alertVC addAction:cancel];
        }
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
    
    
    
}

@end
