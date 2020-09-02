//
//  SWTMinePaySettingVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMinePaySettingVC.h"

@interface SWTMinePaySettingVC ()
@property (weak, nonatomic) IBOutlet UIButton *confirmBt;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *gouBt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNoTF;

@end

@implementation SWTMinePaySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付安全";
    self.confirmBt.backgroundColor = RedColor;
    self.confirmBt.layer.cornerRadius = 15;
    self.confirmBt.clipsToBounds = YES;
   
}
- (IBAction)xieYiaction:(id)sender {
    
    
    
    
}
- (IBAction)confrimAction:(id)sender {
    
    
    
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
