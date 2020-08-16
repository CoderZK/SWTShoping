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
    SWTMJMineChanPinKuTwoTVC * vc =[[SWTMJMineChanPinKuTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
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
