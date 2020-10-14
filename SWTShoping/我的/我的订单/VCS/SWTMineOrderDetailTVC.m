//
//  SWTMineOrderDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineOrderDetailTVC.h"
#import "SWTOrderDetailOneCell.h"
#import "SWTOrderDetailTwoCell.h"
#import "SWTOrderDetailFourCell.h"
#import "SWTOrderThreeCell.h"
#import "SWTMineOrderCell.h"
#import "SWTMineAddressTVC.h"
#import "SWTSendMinePingLunTVC.h"
#import "SWTTiJiaoTuiHuoTwoTVC.h"
#import "SWTWuLiuTVC.h"
#import "SWTTuiHuoOneTVC.h"
#import "SWTMJFaHuoShowView.h"
#import "SWTMJRefundCell.h"
@interface SWTMineOrderDetailTVC ()
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , strong)SWTModel *refundModel;
@end

@implementation SWTMineOrderDetailTVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
    
    if (self.isShouHou) {
        [self getRufure];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTOrderDetailOneCell" bundle:nil] forCellReuseIdentifier:@"SWTOrderDetailOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTOrderDetailTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTOrderDetailTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTOrderDetailFourCell" bundle:nil] forCellReuseIdentifier:@"SWTOrderDetailFourCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTOrderThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTOrderThreeCell"];
    [self.tableView registerClass:[SWTMineOrderCell class] forCellReuseIdentifier:@"SWTMineOrderCell"];
    [self.tableView registerClass:[SWTMJRefundCell class] forCellReuseIdentifier:@"SWTMJRefundCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
       self.tableView.estimatedRowHeight = 40;
    
    
    
}
- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"orderno"] = self.ID;
    [zkRequestTool networkingPOST:orderDetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataModel == nil) {
        return 0;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 5;
    }else if (section == 2) {
        return 1;
    }else {
        return 4;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 70;
        }else if (indexPath.row == 1) {
            return 77;
        }else {
            return UITableViewAutomaticDimension;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return UITableViewAutomaticDimension;
        }else if (indexPath.row == 4) {
            return 50;
        }else {
            return 30;
        }
    }else if (indexPath.section == 2) {
        if (self.refundModel == nil) {
            return 0;
        }
        return UITableViewAutomaticDimension;
    }else {
       if (indexPath.row == 0) {
            return 50;
        }else {
            return 30;
        }
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    view.backgroundColor = BackgroundColor;
    return view;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SWTOrderDetailOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTOrderDetailOneCell" forIndexPath:indexPath];
            if (self.dataModel.status.intValue == 4) {
                cell.imgV.image = [UIImage imageNamed:@"dyx53"];
            }else {
               cell.imgV.image = [UIImage imageNamed:@"dyx49"];
            }
            if(self.dataModel.status.intValue == 0) {
                cell.titleLB.text = @"待付款";
            }else if(self.dataModel.status.intValue == 1) {
                cell.titleLB.text = @"待发货";
            }else if(self.dataModel.status.intValue == 2) {
                cell.titleLB.text = @"待收货";
            }else if(self.dataModel.status.intValue == 3) {
                cell.titleLB.text = @"待评价";
            }else if(self.dataModel.status.intValue == 4) {
                cell.titleLB.text = @"已完成";
            }else  {
                cell.titleLB.text = @"已完成";
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1) {
             SWTOrderDetailTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTOrderDetailTwoCell" forIndexPath:indexPath];
            NSDictionary * dict = [self.dataModel.expressinfo mj_JSONObject];
            
            if ( [[NSString stringWithFormat:@"%@",dict[@"message"]] isEqualToString:@"ok"]) {
                NSArray * arr = [dict[@"data"] mj_JSONObject];
                if (arr.count > 0) {
                    [cell.statusBt setTitle:arr[0][@"context"] forState:UIControlStateNormal];
                    cell.timeLB.text = arr[0][@"time"];
                }else {
                            [cell.statusBt setTitle:@"揽货中" forState:UIControlStateNormal];
                    cell.timeLB.text = @"";
                }
            }else {
                [cell.statusBt setTitle:@"处理中..." forState:UIControlStateNormal];
                cell.timeLB.text = @"";
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
        }else {
            SWTOrderThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTOrderThreeCell" forIndexPath:indexPath];
            [cell.nameBt setTitle: [NSString stringWithFormat:@"  %@",self.dataModel.name] forState:UIControlStateNormal];
            cell.phoneLB.text = self.dataModel.mobile;
            cell.addressLB.text = self.dataModel.address;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SWTMineOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineOrderCell" forIndexPath:indexPath];
            self.dataModel.goodprice = self.dataModel.price;
            self.dataModel.goodnum = self.dataModel.num;
            self.dataModel.nickname = self.dataModel.store_name;
            self.dataModel.title = self.dataModel.goodname;
            
            if (self.isShouHou) {
                cell.isShangJia = YES;
                cell.status = self.refundModel.status;
            }
            if (self.isMj) {
                cell.mjModel = self.dataModel;
            }else {
                cell.model = self.dataModel;
            }
            [cell.rightTwoBt addTarget:self action:@selector(rightTwoAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.rightOneBt addTarget:self action:@selector(rightOneAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.rightThreeBt addTarget:self action:@selector(rightThreeAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            
            return cell;
        }else {
           SWTOrderDetailFourCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTOrderDetailFourCell" forIndexPath:indexPath];
            cell.rightLB.hidden = NO;
            cell.leftLB.textColor = CharacterColor102;
            cell.leftLB.font = kFont(13);
            cell.rightLB.textColor = CharacterColor102;
            if (indexPath.row == 4) {
                cell.leftLB.textColor = CharacterColor50;
                cell.leftLB.font =  kFont(15);
                cell.leftLB.text = @"实付:";
                cell.rightLB.text =  [NSString stringWithFormat:@"￥%@",self.dataModel.realprice.getPriceAllStr];
                cell.rightLB.textColor = RedLightColor ;
            }else if (indexPath.row == 1) {
                cell.leftLB.text = @"商品总价:";
                cell.rightLB.text =  [NSString stringWithFormat:@"￥%@",self.dataModel.price.getPriceAllStr];
            }else if (indexPath.row == 2) {
                cell.leftLB.text =  @"运费";
                cell.rightLB.text = @"￥0.00";
            }else if (indexPath.row == 3) {
                cell.leftLB.text =  @"店铺优惠:";
                cell.rightLB.text =  [NSString stringWithFormat:@"-￥%@",self.dataModel.coupons.getPriceAllStr];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 2) {
        SWTMJRefundCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMJRefundCell" forIndexPath:indexPath];
        cell.model = self.refundModel;
        cell.clipsToBounds = YES;
        return cell;
        
    } else {
        SWTOrderDetailFourCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTOrderDetailFourCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightLB.hidden = YES;
        cell.leftLB.textColor = CharacterColor102;
        cell.leftLB.font = kFont(13);
        if (indexPath.row == 0) {
            cell.leftLB.textColor = CharacterColor50;
            cell.leftLB.font = kFont(15);
            cell.leftLB.text = @"订单信息";
        }else if (indexPath.row == 1) {
            if (self.dataModel.paystatus.intValue == 1) {
                cell.leftLB.text = @"支付方式: 微信支付";
            }else if (self.dataModel.paystatus.intValue == 0) {
                cell.leftLB.text = @"支付方式: 支付宝支付";
            }else if (self.dataModel.paystatus.intValue == 2) {
                cell.leftLB.text = @"支付方式: 云闪付支付";
            }
            
        }else if (indexPath.row == 2) {
            cell.leftLB.text =  [NSString stringWithFormat:@"订单编号: %@",self.dataModel.orderid];;
        }else if (indexPath.row == 3) {
            cell.leftLB.text = [NSString stringWithFormat:@"创建时间 : %@",self.dataModel.createtime];
        }
        return cell;
    }

}

- (void)getRufure {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"orderid"] = self.IDTwo;
    [zkRequestTool networkingPOST:merchorderGet_refund_info_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.refundModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            NSArray * arr = responseObject[@"data"][@"imgs"];
            self.refundModel.refundImgs = arr;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
    
}

//右侧按钮
//0未支付1待发货2待收货3待评价4已完成5已关闭-1交易失败 -2 全部 6 售后
- (void)rightTwoAction:(UIButton *)button {
    SWTModel * model = self.dataModel;
    
    
    if  (self.isMj) {
        if ([button.titleLabel.text containsString:@"发货"]) {
            [self faHuoActionWithModel:self.dataModel];

        }else if ([button.titleLabel.text containsString:@"查看物流"]) {
            SWTWuLiuTVC * vc =[[SWTWuLiuTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = model.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([button.titleLabel.text isEqualToString:@"退款"] || [button.titleLabel.text containsString:@"完成"]) {
            //退款
            [self mjTuiKuanAction];
        }else if ([button.titleLabel.text containsString:@"同意退货退款"]) {
            //退货退款的先同意
            [self caozuoWithID:self.ID withType:2];
        }
    }else {

            if ([button.titleLabel.text containsString:@"付款"]) {
                //付款
                SWTPayVC * vc =[[SWTPayVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.orderID = model.orderid;
                vc.priceStr = model.goodprice;
                [self.navigationController pushViewController:vc animated:YES];
                
        //        [self actionModel:model withOrderID:nil withUrlStr:orderPay_SWT withtype:-20];
            }else if ([button.titleLabel.text containsString:@"提醒卖家发货"]) {
                //提醒发货
                [self actionModel:model withOrderID:nil withUrlStr:pushmsgRemindsend_SWT withtype:-11];
            }else if ([button.titleLabel.text containsString:@"确认收货"]) {
                [self actionModel:model withOrderID:nil withUrlStr:orderDelivery_SWT withtype:-2];
            }else if ([button.titleLabel.text containsString:@"评价"]) {
                
                SWTSendMinePingLunTVC* vc =[[SWTSendMinePingLunTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if (model.status.intValue == 4) {
//                [self actionModel:model withOrderID:nil withUrlStr:@"1234" withtype:-4];
            }else if (model.status.intValue == 5) {
//                [self actionModel:model withOrderID:nil withUrlStr:@"1234" withtype:-5];
            }else if (model.status.intValue == 6) {
                SWTTiJiaoTuiHuoTwoTVC * vc =[[SWTTiJiaoTuiHuoTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
    }
    
    
    
}

//发货
- (void)faHuoActionWithModel:(SWTModel *)model {
    
    SWTMJFaHuoShowView * showV  =[[SWTMJFaHuoShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    showV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [showV.delegateSignal subscribeNext:^(NSArray * x) {
        @strongify(self);
        
        [self sendGoodWithArr:x withID:self.IDTwo];
        
    }];
    [showV show];
    
    
}


//发货
- (void)sendGoodWithArr:(NSArray *)arr withID:(NSString *)ID{
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = ID;
    dict[@"expresssn"] = arr[0];
    dict[@"expressid"] = arr[1];
    dict[@"expressname"] = arr[2];
    dict[@"express"] = arr[3];
    [zkRequestTool networkingPOST:merchorderSend_order_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"发货成功"];
            [self getData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}



//左侧按钮
- (void)rightOneAction:(UIButton *)button {
    SWTModel * model = self.dataModel;
    if (self.isMj) {
        
       if ([button.titleLabel.text containsString:@"拒绝"]) {
           //拒绝申请退款
           [self caozuoWithID:self.ID withType:1];
        }
    }else {

        if ([button.titleLabel.text containsString:@"改地址"]) {
            //改地址
            [self editOrderAddressOneWithModel:model];
        }else if ([button.titleLabel.text containsString:@"查看物流"]) {
            SWTWuLiuTVC * vc =[[SWTWuLiuTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = self.dataModel.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
    
}

//点击售后
- (void)rightThreeAction:(UIButton *)button {
    
    SWTTuiHuoOneTVC * vc =[[SWTTuiHuoOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = self.dataModel;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

// 售后操作
- (void)caozuoWithID:(NSString *)ID withType:(NSInteger)type {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"refundid"] = self.refundModel.ID;
    dict[@"opt"] = @(type);
    [zkRequestTool networkingPOST:merchorderAudit_order_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (type == 1) {
                [SVProgressHUD showSuccessWithStatus:@"退款申请拒绝成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self getRufure];
                });
            }else if (type == 3) {
                [SVProgressHUD showSuccessWithStatus:@"退款完成"]; 
               
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                     [LTSCEventBus sendEvent:@"tuikuan" data:nil];
                     [self getData];
                });
                
                
                
            }else if (type == 2) {
                [self getData];
                [self getRufure];
            }
            
            
 
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}

//退款操作
- (void)mjTuiKuanAction {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merOrderId"] = self.dataModel.orderid;
    dict[@"refundAmount"] =  [NSString stringWithFormat:@"%0.0f",self.dataModel.realprice.floatValue * 100];
    [zkRequestTool networkingPOST:payRefund_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dict = [responseObject[@"returninfo"] mj_JSONObject];
        if ([dict.allKeys containsObject:@"errCode"] &&  [dict[@"errCode"] isEqualToString:@"SUCCESS"]) {
             [self caozuoWithID:nil withType:3];
        }else {
            [SVProgressHUD showErrorWithStatus:@"退款失败,请联系客服"];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 1){
        SWTWuLiuTVC * vc =[[SWTWuLiuTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


@end
