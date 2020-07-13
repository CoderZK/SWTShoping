//
//  SWTLoginOneVC.m
//  TTT
//
//  Created by zk on 2020/7/6.
//  Copyright © 2020 张坤. All rights reserved.
//

#import "SWTLoginOneVC.h"
#import "SWTLoginTwoVC.h"
#import "SWTRegistVC.h"
@interface SWTLoginOneVC ()
@property (weak, nonatomic) IBOutlet UIButton *backBt;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UIButton *weiXinBt;
@property (weak, nonatomic) IBOutlet UIButton *registBt;

@end

@implementation SWTLoginOneVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgV.layer.cornerRadius = 5;
    self.imgV.clipsToBounds = YES;
    
    
    
    self.loginBt.layer.cornerRadius = self.weiXinBt.layer.cornerRadius = 22.5;
    self.loginBt.clipsToBounds = self.weiXinBt.clipsToBounds = YES;
    self.loginBt.layer.borderWidth = self.weiXinBt.layer.borderWidth = 0.8;
    self.loginBt.layer.borderColor = self.weiXinBt.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    
    
    
    
    
    
    
}
- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
        SWTLoginTwoVC * vc =[[SWTLoginTwoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 101) {
        
        
    }else if (sender.tag == 102) {
        SWTRegistVC * vc =[[SWTRegistVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (IBAction)abck:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
