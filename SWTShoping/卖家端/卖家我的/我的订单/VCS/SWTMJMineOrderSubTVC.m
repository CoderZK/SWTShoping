//
//  SWTMJMineOrderSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineOrderSubTVC.h"
#import "SWTMineOrderCell.h"
#import "SWTMJFaHuoShowView.h"
#import "SWTMineOrderDetailTVC.h"
#import "SWTWuLiuTVC.h"
@interface SWTMJMineOrderSubTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTMJMineOrderSubTVC

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
    
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        weakSelf.page = 1;
        [weakSelf getData];
    };
    [LTSCEventBus registerEvent:@"tuikuan" block:^(id data) {
        weakSelf.page = 1;
        [weakSelf getData];
    }];
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageindex"] = @(self.page);
    dict[@"pagesize"] = @(10);
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    dict[@"type"] =self.type == 0 ?@"": @(self.type);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:merchorderGet_order_list_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
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
    cell.headImgV.layer.cornerRadius = 8.5;
    cell.headImgV.clipsToBounds = YES;
    cell.mjModel = self.dataArray[indexPath.row];
    cell.rightOneBt.tag = indexPath.row;
    cell.rightTwoBt.tag = indexPath.row;
    [cell.rightOneBt addTarget:self action:@selector(rightOneAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightTwoBt addTarget:self action:@selector(rightTwoAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

//
- (void)rightOneAction:(UIButton *)button {
    
}

- (void)rightTwoAction:(UIButton *)button {
    
    if ([button.titleLabel.text containsString:@"发货"]) {
        [self faHuoActionWithModel:self.dataArray[button.tag]];
    }else if ([button.titleLabel.text containsString:@"查看物流"]) {
        SWTWuLiuTVC * vc =[[SWTWuLiuTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = self.dataArray[button.tag].ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([button.titleLabel.text containsString:@"退款"]) {
        //
        [self caozuoWithID:self.dataArray[button.tag].refundid withType:3];
    }else if ([button.titleLabel.text containsString:@"同意买家退货"]) {
        [self caozuoWithID:self.dataArray[button.tag].refundid withType:2];
    }else if ([button.titleLabel.text containsString:@"驳回退款"]) {
        [self caozuoWithID:self.dataArray[button.tag].refundid withType:1];
    }
}

// 售后操作
- (void)caozuoWithID:(NSString *)ID withType:(NSInteger)type {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"refundid"] = ID;
    dict[@"opt"] = @(type);
    [zkRequestTool networkingPOST:merchorderAudit_order_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}
//发货
- (void)faHuoActionWithModel:(SWTModel *)model {

    SWTMJFaHuoShowView * showV  =[[SWTMJFaHuoShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    showV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [showV.delegateSignal subscribeNext:^(NSArray * x) {
        @strongify(self);
        
        [self sendGoodWithArr:x withID:model.ID];
        
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
            self.page = 1;
            [self getData];
            
            
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
    
    SWTMineOrderDetailTVC * vc =[[SWTMineOrderDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[indexPath.row].orderid;
    vc.IDTwo = self.dataArray[indexPath.row].ID;
    vc.isMj = YES;
    if (self.type == 4) {
        vc.isShouHou = YES;
        
    }
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}


@end
