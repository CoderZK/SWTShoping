//
//  SWTMineOrderSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineOrderSubTVC.h"
#import "SWTMineOrderCell.h"
#import "SWTMineHeMaiTiJiaoOrderTVC.h"
#import "SWTTuiHuoOneTVC.h"
#import "SWTMineAddressTVC.h"
#import "SWTSendMinePingLunTVC.h"
#import "SWTWuLiuTVC.h"
#import "SWTTiJiaoTuiHuoTwoTVC.h"
#import "SWTMineOrderDetailTVC.h"
@interface SWTMineOrderSubTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;

@end

@implementation SWTMineOrderSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SWTMineOrderCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    
    
    @weakify(self);
    [LTSCEventBus registerEvent:@"sucess" block:^(id data) {
        @strongify(self);
        
        self.page = 1;
        [self getData];
        
        
    }];
    
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        weakSelf.page = 1;
        [weakSelf getData];
    };
    
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pagesize"] = @(10);
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"status"] = @(self.type);
    [zkRequestTool networkingPOST:orderList_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [self.noneView showNoneDataViewAt:self.view img:[UIImage imageNamed:@"dyx47"] tips:@"暂无数据"];
            }else {
                [self.noneView  dismiss];
            }
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.type == 6) {
        self.dataArray[indexPath.row].status = @"6";
    }
    cell.model = self.dataArray[indexPath.row];
    cell.rightOneBt.tag = indexPath.row;
    cell.rightTwoBt.tag = indexPath.row;
    cell.rightThreeBt.tag = indexPath.row;
    [cell.rightTwoBt addTarget:self action:@selector(rightTwoAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightOneBt addTarget:self action:@selector(rightOneAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightThreeBt addTarget:self action:@selector(rightThreeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SWTModel * model = self.dataArray[indexPath.row];
    if (self.type == 6){
        SWTTiJiaoTuiHuoTwoTVC * vc =[[SWTTiJiaoTuiHuoTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        SWTMineOrderDetailTVC * vc =[[SWTMineOrderDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = model.orderid;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //    if (model.status.intValue == 0) {
    //        //未付款
    //        SWTPayVC * vc =[[SWTPayVC alloc] init];
    //        vc.hidesBottomBarWhenPushed = YES;
    //        vc.orderID = responseObject[@"data"];
    //        vc.priceStr = [NSString stringWithFormat:@"%0.2f",self.model.price.doubleValue * self.numStr.doubleValue - self.zheKouMoney];
    //        [self.navigationController pushViewController:vc animated:YES];
    //        
    //        
    //    }
    
    //    SWTTuiHuoOneTVC * vc =[[SWTTuiHuoOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    
}

//右侧按钮
//0未支付1待发货2待收货3待评价4已完成5已关闭-1交易失败 -2 全部 6 售后
- (void)rightTwoAction:(UIButton *)button {
    SWTModel * model = self.dataArray[button.tag];
    if ([button.titleLabel.text containsString:@"付款"]) {
        //付款
        SWTPayVC * vc =[[SWTPayVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.orderID = model.orderid;
        vc.priceStr = model.goodprice;
        [self.navigationController pushViewController:vc animated:YES];
        
//        [self actionModel:model withOrderID:nil withUrlStr:orderPay_SWT withtype:-20];
    }else if ([button.titleLabel.text containsString:@"提醒卖家发货"]) {
        //
        [self actionModel:model withOrderID:nil withUrlStr:pushmsgRemindsend_SWT withtype:-11];
    }else if ([button.titleLabel.text containsString:@"确认收货"]) {
        [self actionModel:model withOrderID:nil withUrlStr:orderDelivery_SWT withtype:-2];
    }else if ([button.titleLabel.text containsString:@"评价"]) {
        
        SWTSendMinePingLunTVC* vc =[[SWTSendMinePingLunTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (model.status.intValue == 6) {
        SWTTiJiaoTuiHuoTwoTVC * vc =[[SWTTiJiaoTuiHuoTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//左侧按钮
- (void)rightOneAction:(UIButton *)button {
    
    SWTModel * model = self.dataArray[button.tag];
    if ([button.titleLabel.text containsString:@"改地址"]) {
        //改地址
        [self editOrderAddressOneWithModel:model];
    }else if (model.status.intValue == 1) {
        
    }else if ([button.titleLabel.text containsString:@"查看物流"]) {
        SWTWuLiuTVC * vc =[[SWTWuLiuTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (model.status.intValue == 4) {
        
    }else if (model.status.intValue == 5) {
        
    }
    
}
//点击售后
- (void)rightThreeAction:(UIButton *)button {
    
    SWTTuiHuoOneTVC * vc =[[SWTTuiHuoOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = self.dataArray[button.tag];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)editOrderAddressOneWithModel:(SWTModel *)orderModel {
    
    SWTMineAddressTVC * vc =[[SWTMineAddressTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    Weak(weakSelf);
    vc.sendAddressModelBlock = ^(SWTModel * _Nonnull model) {
        [weakSelf actionModel:orderModel withOrderID:model.ID withUrlStr:orderEditaddress_SWT withtype:0];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)actionModel:(SWTModel *)model withOrderID:(NSString *)addressID withUrlStr:(NSString *)urlStr withtype:(NSInteger )type{
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"addressid"] = addressID;
    dict[@"orderid"] = model.ID;
    dict[@"price"] = model.goodprice;
    dict[@"id"] = model.ID;
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]== 200) {
            
            [LTSCEventBus sendEvent:@"sucess" data:nil];
            if (type == -20) {
                [SVProgressHUD showSuccessWithStatus:@"付款成功"];
            }else if (type == 0){
                [SVProgressHUD showSuccessWithStatus:@"修改收货地址成功"];
            }else if (type == -11) {
                [SVProgressHUD showSuccessWithStatus:@"催发货成功"];
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
