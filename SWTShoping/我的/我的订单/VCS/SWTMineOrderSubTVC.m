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
    cell.model = self.dataArray[indexPath.row];
    cell.rightOneBt.tag = indexPath.row;
    cell.rightTwoBt.tag = indexPath.row;
    [cell.rightTwoBt addTarget:self action:@selector(rightTwoAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightOneBt addTarget:self action:@selector(rightOneAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SWTTuiHuoOneTVC * vc =[[SWTTuiHuoOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//右侧按钮
//0未支付1待发货2待收货3待评价4已完成5已关闭-1交易失败 -2 全部
- (void)rightTwoAction:(UIButton *)button {
    SWTModel * model = self.dataArray[button.tag];
    if (model.status.intValue == 0) {
        //付款
        [self actionModel:model withOrderID:nil withUrlStr:orderPay_SWT withtype:-20];
    }else if (model.status.intValue == 1) {
        //
        [self actionModel:model withOrderID:nil withUrlStr:@"1234" withtype:-11];
    }else if (model.status.intValue == 2) {
         [self actionModel:model withOrderID:nil withUrlStr:orderDelivery_SWT withtype:-2];
    }else if (model.status.intValue == 3) {
        
        SWTSendMinePingLunTVC* vc =[[SWTSendMinePingLunTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (model.status.intValue == 4) {
        [self actionModel:model withOrderID:nil withUrlStr:@"1234" withtype:-4];
    }else if (model.status.intValue == 5) {
       [self actionModel:model withOrderID:nil withUrlStr:@"1234" withtype:-5];
    }
    
}

//左侧按钮
- (void)rightOneAction:(UIButton *)button {
    
    SWTModel * model = self.dataArray[button.tag];
    if (model.status.intValue == 0) {
        //改地址
        [self editOrderAddressOneWithModel:model];
    }else if (model.status.intValue == 1) {
        
    }else if (model.status.intValue == 2) {
        
    }else if (model.status.intValue == 3) {
        
    }else if (model.status.intValue == 4) {
        
    }else if (model.status.intValue == 5) {
        
    }
    
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
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
  
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
            if (type == -20) {
               [SVProgressHUD showSuccessWithStatus:@"付款成功"];
            }else if (type == 0){
              [SVProgressHUD showSuccessWithStatus:@"修改收货地址成功"];
            }else if (type == 1) {
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
