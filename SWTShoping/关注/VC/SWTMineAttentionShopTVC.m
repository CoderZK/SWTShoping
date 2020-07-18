//
//  SWTMineAttentionShopTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/1.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineAttentionShopTVC.h"
#import "SWTMineGuanZHuDinaPuCell.h"

@interface SWTMineAttentionShopTVC ()<SWTMineGuanZHuDinaPuCellDelegate>
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTMineAttentionShopTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[SWTMineGuanZHuDinaPuCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"1";
    [zkRequestTool networkingPOST:  [NSString stringWithFormat:@"%@/%@",userFollow_SWT,[zkSignleTool shareTool].session_uid] parameters:[zkSignleTool shareTool].session_uid success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30+134+ 15;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineGuanZHuDinaPuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.nameLB.text = @"fgkodkgfeoprkgkp";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    cell.delegate = self;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark --- 点击 cell  ----

- (void)didClickGuanZhuDianPuView:(SWTMineGuanZHuDinaPuCell *)cell withIndex:(NSInteger)index isClickHead:(BOOL)isClickHead {
    if (isClickHead) {
        //点击的是头像或者进店
        SWTShopHomeVC * vc =[[SWTShopHomeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else {
        //点击的是内部的其他信息
        
        
    }
    
    
}

@end
