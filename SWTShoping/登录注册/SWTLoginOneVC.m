//
//  SWTLoginOneVC.m
//  TTT
//
//  Created by zk on 2020/7/6.
//  Copyright © 2020 张坤. All rights reserved.
//

#import "SWTLoginOneVC.h"

@interface SWTLoginOneVC ()
@property (weak, nonatomic) IBOutlet UIButton *backBt;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UIButton *weiXinBt;
@property (weak, nonatomic) IBOutlet UIButton *registBt;

@end

@implementation SWTLoginOneVC

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
}

- (IBAction)abck:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
