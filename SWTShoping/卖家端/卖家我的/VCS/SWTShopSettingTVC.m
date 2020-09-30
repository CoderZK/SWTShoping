//
//  SWTShopSettingTVC.m
//  SWTZBMH
//
//  Created by kunzhang on 2020/8/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopSettingTVC.h"
#import "SWTMineShopSettingCell.h"
#import "SWTMineShopSettingSectionV.h"
#import "SWTMJJingPaiOrChuJiaSettingVC.h"
#import "SWTMJMineFenSiTVC.h"
#import "SWTMJDainPuBaoZhengJinVC.h"
#import "SWTMJAddShouHuoDiZhiTVC.h"
#import "SWTMJDainPuLoGoCell.h"
@interface SWTShopSettingTVC ()<UITextFieldDelegate>
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)NSArray *titleArr;
@property(nonatomic , strong)NSString *nameStr,*phone;
@end

@implementation SWTShopSettingTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self editShopSetting];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺设置";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineShopSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerClass:[SWTMineShopSettingSectionV class] forHeaderFooterViewReuseIdentifier:@"head"];
    
    self.titleArr = @[@[@"联系人",@"手机号码"],@[@"竞拍设置",@"买家出价条件"],@[@"粉丝"],@[@"店铺保证金",@"退货地址"]];
    [self initFootV];
    
}


- (void)initFootV {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    self.tableView.tableFooterView = self.footV;
    self.footV.backgroundColor = WhiteColor;
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(50, 10, ScreenW - 100, 40)];
    button.titleLabel.font = kFont(15);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //点击退出登录
        
        [zkSignleTool shareTool].isLogin = NO;
        [zkSignleTool shareTool].session_uid = nil;
        self.tabBarController.selectedIndex = 0;
        [self dismissViewControllerAnimated:YES completion:nil];
        [LTSCEventBus sendEvent:@"diss" data:nil];
        [[V2TIMManager sharedInstance] logout:nil fail:nil];
        
        
    }];
    [self.footV addSubview:button];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3 && indexPath.row == 0) {
        return 0;
    }
    return 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else {
        return 45;
    }
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.titleArr[indexPath.section][indexPath.row];
    cell.swithBt.hidden = YES;
    cell.leftwoLB.hidden = YES;
    cell.rightTF.hidden = NO;
    cell.rightTF.userInteractionEnabled = NO;
    if (indexPath.section == 0) {
        cell.rightImgV.hidden = YES;
        if (indexPath.row == 0) {
            cell.rightTF.text = self.dataModel.link;
            cell.rightTF.userInteractionEnabled = YES;
        }else {
            cell.rightTF.text = self.dataModel.mobile;
            cell.rightTF.userInteractionEnabled = NO;
        }
        
    }else if (indexPath.section == 1) {
        cell.rightTF.placeholder = @"请选择";
        if (indexPath.row == 0) {
            cell.rightTF.text  = self.dataModel.autodeduct ? @"已开启":@"未开启";
        }else if (indexPath.row == 1) {
            cell.rightTF.text  = self.dataModel.level_open ? @"已开启":@"未开启";
            
        } if (indexPath.row == 2) {
            cell.rightTF.hidden = YES;
            cell.swithBt.hidden = NO;
            cell.leftwoLB.hidden = NO;
            cell.leftwoLB.text = @"(订单金额 >= 2万可用)";
        }
    }else if (indexPath.section == 2) {
        cell.rightTF.placeholder = self.dataModel.focusnum;
        
    }else if (indexPath.section == 3) {
        cell.rightTF.userInteractionEnabled = NO;
        cell.rightTF.placeholder = @"";
        if (indexPath.row == 0) {
            cell.rightTF.hidden = YES;
            cell.swithBt.hidden = NO;
        }else if (indexPath.row == 1) {
            cell.rightTF.hidden = NO;
            cell.rightTF.userInteractionEnabled = NO;
            cell.swithBt.hidden = YES;
            
            cell.rightTF.text =  [NSString stringWithFormat:@"%@",self.dataModel.refund_address.length == 0?@"":self.dataModel.refund_address];
            
        }else {
            
        }
        
        
    }
    cell.clipsToBounds = YES;
    cell.rightTF.delegate = self;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWTMineShopSettingSectionV * headV  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (section == 0) {
        headV.titelLB.text = @"";
    } else if (section == 1) {
        headV.titelLB.text = @"竞拍设置";
    }else if (section == 2) {
        headV.titelLB.text = @"用户设置";
    }else {
        headV.titelLB.text = @"高级设置";
    }
    return headV;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endEditing:YES];
    if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            SWTMJJingPaiOrChuJiaSettingVC * vc =[[SWTMJJingPaiOrChuJiaSettingVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isBaoZhengJin = YES;
            vc.model = self.dataModel;
            Weak(weakSelf);
            vc.autoBlock = ^(SWTModel * _Nonnull model) {
                weakSelf.dataModel = model;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            SWTMJJingPaiOrChuJiaSettingVC * vc =[[SWTMJJingPaiOrChuJiaSettingVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isBaoZhengJin = NO;
            vc.model = self.dataModel;
            Weak(weakSelf);
            vc.autoBlock = ^(SWTModel * _Nonnull model) {
                weakSelf.dataModel = model;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2) {
        SWTMJMineFenSiTVC * vc =[[SWTMJMineFenSiTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3 ) {
        if (indexPath.row == 0) {
            SWTMJDainPuBaoZhengJinVC * vc =[[SWTMJDainPuBaoZhengJinVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1
                  ) {
            SWTMJAddShouHuoDiZhiTVC * vc =[[SWTMJAddShouHuoDiZhiTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            Weak(weakSelf);
            vc.addTuiHuoAddressBlock = ^(SWTModel * _Nonnull model) {
                weakSelf.dataModel = model;
                [weakSelf.tableView reloadData];
            };
            vc.dataModel = self.dataModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTMineShopSettingCell * cell = (SWTMineShopSettingCell *)textField.superview.superview;
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.dataModel.link = textField.text;
        }else if (indexPath.row == 1){
            self.dataModel.mobile = textField.text;
        }
    }
}


- (void)editShopSetting {
    [self.tableView endEditing:YES];
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    dict[@"link"] = self.dataModel.link;
    dict[@"mobile"] = self.dataModel.mobile;
    [zkRequestTool networkingPOST:merchUpd_merchinfo_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (self.shopSettingBlock != nil) {
                self.shopSettingBlock(self.dataModel);
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
    
}

@end
