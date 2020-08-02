//
//  SWTTiJiaoTuiHuoTwoTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTiJiaoTuiHuoTwoTVC.h"
#import "SWTTuiHuiOneCell.h"
#import "SWTTuiHuoAddressCell.h"
#import "SWTTuiHuoDesCell.h"
#import "SWTTuiHuoThreeCell.h"
#import "SWTTuiHuoKuaiDiDanHaoVC.h"
@interface SWTTiJiaoTuiHuoTwoTVC ()
@property(nonatomic , strong)SWTModel *addressModel;
@end

@implementation SWTTiJiaoTuiHuoTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请退货";
    [self.tableView registerClass:[SWTTuiHuiOneCell class] forCellReuseIdentifier:@"SWTTuiHuiOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoAddressCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoAddressCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoDesCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoDesCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoThreeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 40;
    
    [self getBackAddressData];
    
}

- (void)getBackAddressData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.model.ID;
    [zkRequestTool networkingPOST:orderBackaddress_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.addressModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 119;
    }
    if (indexPath.row == 1) {
        return 115;
    }
    return UITableViewAutomaticDimension;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SWTTuiHuoThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoThreeCell" forIndexPath:indexPath];
        @weakify(self);
        
        [[cell.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self cheHuiAction];
        }];
        [[cell.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                 @strongify(self);
            SWTTuiHuoKuaiDiDanHaoVC * vc =[[SWTTuiHuoKuaiDiDanHaoVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = self.model;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
    }else {
        if (indexPath.row == 0) {
            SWTTuiHuoAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoAddressCell" forIndexPath:indexPath];
            cell.leftOneLB.text = self.addressModel.address;
            cell.leftTwoLB.text = self.addressModel.mobile;
               return cell;
        }else if (indexPath.row == 1) {
            SWTTuiHuiOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuiOneCell" forIndexPath:indexPath];
            cell.lineV.hidden = YES;
            cell.model = self.model;
               return cell;
        }else {
            SWTTuiHuoDesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoDesCell" forIndexPath:indexPath];
            cell.reasonStr = self.reasonStr;
            cell.picArr = self.picArr;
            cell.contextStr = self.contextStr;
               return cell;
        }
    }
    
    
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (void)cheHuiAction {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.model.ID;
    [zkRequestTool networkingPOST:orderUndo_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
  
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"撤回成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


@end
