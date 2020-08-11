//
//  SWTMineHeMaiOrderSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineHeMaiOrderSubTVC.h"
#import "SWTMineHeMaiOrderCell.h"
@interface SWTMineHeMaiOrderSubTVC ()
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTMineHeMaiOrderSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[SWTMineHeMaiOrderCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
    }];
    
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        
        [weakSelf getData];
    };
    
    
}

- (void)getData {
    [SVProgressHUD show];
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    //    dict[@"liveid"] = self.model.ID;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"status"] = @(1);
    [zkRequestTool networkingPOST:shareMyshare_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    SWTMineHeMaiOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.rightOneBt.tag = indexPath.row;
    [cell.rightOneBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.type = self.type;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


//点击
- (void)clickAction:(UIButton *)button {
    
    
    
}


@end
