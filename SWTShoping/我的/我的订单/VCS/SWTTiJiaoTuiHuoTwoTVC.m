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
@property(nonatomic , strong)SWTModel *detailModel;
@end

@implementation SWTTiJiaoTuiHuoTwoTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getDetailData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请退货";
    [self.tableView registerClass:[SWTTuiHuiOneCell class] forCellReuseIdentifier:@"SWTTuiHuiOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoAddressCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoAddressCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoDesCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoDesCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoThreeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 40;
    
    //    [self getBackAddressData];
    //    [self getDetailData];
    
}

//获取退货详情
- (void)getDetailData {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.model.ID;
    [zkRequestTool networkingPOST:orderBackdetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.detailModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}


//- (void)getBackAddressData {
//    [SVProgressHUD show];
//    NSMutableDictionary * dict = @{}.mutableCopy;
//    dict[@"id"] = self.model.ID;
//    [zkRequestTool networkingPOST:orderBackaddress_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [SVProgressHUD dismiss];
//        if ([responseObject[@"code"] intValue]== 200) {
//
//            self.addressModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
//
//        }else {
//            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//
//    }];
//}


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
    }else {
        
        if (indexPath.row == 0) {
            if (self.detailModel.address.length == 0) {
                return 0;
            }else {
                return UITableViewAutomaticDimension;
            }
        }else if (indexPath.row == 1) {
            return 115;
        }else {
            return UITableViewAutomaticDimension;
        }
    }
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SWTTuiHuoThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoThreeCell" forIndexPath:indexPath];
        
        
        [cell.leftBt addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.rightBt addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        if (self.detailModel.sn.length > 0) {
            [cell.rightBt setTitle:@"修改物流单号" forState:UIControlStateNormal];
        }else {
            [cell.rightBt setTitle:@"填写物流单号" forState:UIControlStateNormal];
        }
        cell.clipsToBounds = YES;
        return cell;
    }else {
        if (indexPath.row == 0) {
            SWTTuiHuoAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoAddressCell" forIndexPath:indexPath];
            cell.leftOneLB.text = self.detailModel.address;
            cell.leftTwoLB.text = self.detailModel.mobile;
            return cell;
        }else if (indexPath.row == 1) {
            SWTTuiHuiOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuiOneCell" forIndexPath:indexPath];
            cell.lineV.hidden = YES;
            cell.model = self.model;
            cell.clipsToBounds = YES;
            return cell;
        }else {
            SWTTuiHuoDesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoDesCell" forIndexPath:indexPath];
            cell.reasonStr = self.detailModel.reason;
            cell.picArr = [self.detailModel.imgs componentsSeparatedByString:@","];
            cell.contextStr = self.detailModel.text;
            cell.clipsToBounds = YES;
            return cell;
        }
    }
    
    
    
}

//点击左侧按钮
- (void)leftAction:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"撤销申请"]) {
        [self cheHuiAction];
    }
}

//点击右侧按钮
- (void)rightAction:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"填写物流单号"] || [button.titleLabel.text isEqualToString:@"修改物流单号"] ) {
        
        SWTTuiHuoKuaiDiDanHaoVC * vc =[[SWTTuiHuoKuaiDiDanHaoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        self.detailModel.ID = self.model.ID;
        vc.model = self.detailModel;
        [self.navigationController pushViewController:vc animated:YES];
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
            [LTSCEventBus sendEvent:@"sucess" data:nil];
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
