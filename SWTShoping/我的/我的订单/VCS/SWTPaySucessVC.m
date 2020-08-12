//
//  SWTPaySucessVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTPaySucessVC.h"
#import "SWTMineOrderFartherVC.h"
#import "SWTMineOrderDetailTVC.h"
@interface SWTPaySucessVC ()
@property (weak, nonatomic) IBOutlet UILabel *orderLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet UIButton *bt2;

@end

@implementation SWTPaySucessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bt1.layer.cornerRadius = self.bt2.layer.cornerRadius = 15;
    self.bt1.clipsToBounds = self.bt2.clipsToBounds = YES;
    self.bt2.layer.borderWidth = self.bt1.layer.borderWidth = 0.5;
    self.bt2.layer.borderColor = self.bt1.layer.borderColor = CharacterColor102.CGColor;;
    self.orderLB.text = self.orderID;
    
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",self.priceStr.getPriceStr];
    
    
    self.navigationItem.title = @"支付成功";
    UIButton * backBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [backBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    [backBt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBt addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBt];
}
- (void)back:(UIButton *)button {
    if (self.navigationController.childViewControllers.count >= 3) {
        UIViewController * vc = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3];
        if ([vc isKindOfClass:[SWTMineOrderDetailTVC class]] || [vc isKindOfClass:[SWTMineOrderFartherVC class]]) {
             [self.navigationController popToViewController:vc animated:YES];
        }else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
}

- (IBAction)goback:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)lookOrder:(id)sender {
    
    SWTMineOrderFartherVC * vc =[[SWTMineOrderFartherVC alloc] init];
    vc.selectIndex = 0;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
