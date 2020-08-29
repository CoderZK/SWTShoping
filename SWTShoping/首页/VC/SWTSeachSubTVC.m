//
//  SWTSeachSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTSeachSubTVC.h"
#import "SWTMineGuanZHuDinaPuCell.h"

@interface SWTSeachSubTVC ()<SWTMineGuanZHuDinaPuCellDelegate>
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , strong)NSString *searchWord;
@end

@implementation SWTSeachSubTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[SWTMineGuanZHuDinaPuCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
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

    [LTSCEventBus registerEvent:@"search" block:^(NSString * data) {
        weakSelf.searchWord = data;
        weakSelf.page = 1;
        [weakSelf getData];
    }];
    
}

- (void)getData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pagesize"] = @(10);
    dict[@"type"] = @"1";
    dict[@"name"] = self.searchWord;
    [zkRequestTool networkingPOST:[NSString stringWithFormat:@"%@/%@",search_SWT,[zkSignleTool shareTool].session_uid] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTModel * model = self.dataArray[indexPath.row];
    if (model.goodNeiList.count == 0) {
        return 50;
    }
    return 30+134+ 15;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineGuanZHuDinaPuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.nameLB.text = @"fgkodkgfeoprkgkp";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    cell.delegate = self;
    cell.clipsToBounds = YES;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark --- 点击 cell  ----

- (void)didClickGuanZhuDianPuView:(SWTMineGuanZHuDinaPuCell *)cell withIndex:(NSInteger)index isClickHead:(BOOL)isClickHead {
    if (isClickHead) {
        //点击的是头像或者进店
        
        NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        
        SWTShopHomeVC * vc =[[SWTShopHomeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.shopId = self.dataArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else {
        //点击的是内部的其他信息
        NSIndexPath * indexPath  = [self.tableView indexPathForCell:cell];
        
        
        SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.goodID = self.dataArray[indexPath.row].goodNeiList[index].goodid;
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }
    
    
}

@end
