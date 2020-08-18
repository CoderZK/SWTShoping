//
//  SWTMJMineVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineVC.h"
#import "SWTMJMineOneCell.h"
#import "SWTMJMineTwoCell.h"
#import "SWTMJMineThreeCell.h"
#import "SWTShopSettingTVC.h"
#import "SWTMJMineZhengRenMessage.h"
#import "SWTMJMineMoneyVC.h"
#import "SWTMJMineOrderFatherVC.h"
#import "SWTMJMineJingPaiFatherVC.h"
#import "SWTMJMineBaoBiaoVC.h"
#import "SWTMJMineVideoFatherVC.h"
#import "SWTMJMineChanPinKuOneVC.h"
#import "SWTMJMineChanPinKuTwoTVC.h"
#import "SWTMJAddYouHuiQuanTVC.h"
@interface SWTMJMineVC ()
@property(nonatomic , strong)NSArray *leftArr;
@end

@implementation SWTMJMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"卖家中心";
    self.leftArr = @[@"总资产",@"拍品管理",@"产品库",@"优惠券",@"直播",@"视频"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMineOneCell" bundle:nil] forCellReuseIdentifier:@"SWTMJMineOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMineThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTMJMineThreeCell"];
    [self.tableView registerClass:[SWTMJMineTwoCell class] forCellReuseIdentifier:@"SWTMJMineTwoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setLeftNagate];
}

- (void)setLeftNagate {
    
    UIButton * leftBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    @weakify(self);
    [[leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return self.leftArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 100;
        }
        return 95;
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if(indexPath.row == 0) {
            SWTMJMineOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMJMineOneCell" forIndexPath:indexPath];
            cell.delegateSignal = [[RACSubject alloc] init];
            @weakify(self);
            [cell.delegateSignal subscribeNext:^(NSNumber * x) {
                @strongify(self);
                if (x.intValue == 100) {
                    //点击是编辑
                    SWTMJMineZhengRenMessage * vc =[[SWTMJMineZhengRenMessage alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (x.intValue== 101) {
                    //点击的是设置
                    SWTShopSettingTVC * vc =[[SWTShopSettingTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                                   vc.hidesBottomBarWhenPushed = YES;
                                   [self.navigationController pushViewController:vc animated:YES];
                                   
                }
                
                
            }];
            return cell;
        }else {
            SWTMJMineTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMJMineTwoCell" forIndexPath:indexPath];
            Weak(weakSelf);
            cell.mineTwoCellBlock = ^(NSInteger index) {
                if (index == 5) {
                    //点击店铺报表
                    SWTMJMineBaoBiaoVC * vc =[[SWTMJMineBaoBiaoVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    
                    SWTMJMineOrderFatherVC * vc =[[SWTMJMineOrderFatherVC alloc] init];
                    vc.selectIndex = index;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
            };
            return cell;
        }
    }else {
        SWTMJMineThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMJMineThreeCell" forIndexPath:indexPath];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.leftImgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"bbdyx%d",11+indexPath.row]];
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //总资产
            SWTMJMineMoneyVC * vc =[[SWTMJMineMoneyVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            SWTMJMineJingPaiFatherVC * vc =[[SWTMJMineJingPaiFatherVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            SWTMJMineChanPinKuOneVC * vc =[[SWTMJMineChanPinKuOneVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3) {
            SWTMJAddYouHuiQuanTVC * vc =[[SWTMJAddYouHuiQuanTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4) {
            
        }else if (indexPath.row == 5) {
            SWTMJMineVideoFatherVC * vc =[[SWTMJMineVideoFatherVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
