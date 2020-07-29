//
//  SWTMineWalletTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineWalletTVC.h"
#import "SWTMineWalletCell.h"
@interface SWTMineWalletTVC ()
@property(nonatomic , strong)NSString *moneyStr;

@end

@implementation SWTMineWalletTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的钱包";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineWalletCell" bundle:nil] forCellReuseIdentifier:@"cell"];


    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      
        [self getData];
    }];

}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:userMypackage_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.moneyStr = responseObject[@"data"];
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
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.imgV.image = [UIImage imageNamed:@"wallet_money"];
        cell.leftLB.text = @"余额";
        cell.rightLB.text = [self.moneyStr getPriceAllStr];
    }else {
        cell.imgV.image = [UIImage imageNamed:@"wallet_card"];
        cell.rightLB.text = @"";
        cell.leftLB.text = @"银行卡";
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



@end
