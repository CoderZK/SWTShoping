//
//  MJAddGuanLiYuanTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJAddGuanLiYuanTVC.h"
#import "SWTMJAddDianPuGRenYunaCell.h"
#import "SWTMJAddRenYuanVC.h"
@interface MJAddGuanLiYuanTVC ()
@property(nonatomic,strong)UIView *headV,*footV;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;

@end

@implementation MJAddGuanLiYuanTVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺管理员";
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    self.headV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel * lb  = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];;
    lb.font  = kFont(14);
    lb.textColor = CharacterColor102;
    lb.text = @"";
    self.titleLB = lb;
    lb.text = @"店铺管理员 (1/5) ";
    self.tableView.tableHeaderView = self.headV;
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    self.footV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel * lb1  = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];;
    lb1.font  = kFont(14);
    lb1.textColor = CharacterColor102;
    lb1.text = @"";
    lb1.text = @"店铺管理员可以拥有管理店铺权限";
    self.tableView.tableFooterView = self.footV;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJAddDianPuGRenYunaCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataArray = @[].mutableCopy;
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchadmin_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            self.titleLB.text = [NSString stringWithFormat:@"店铺管理员(%ld/5)",self.dataArray.count];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count == 5 ? 5:self.dataArray.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJAddDianPuGRenYunaCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row < self.dataArray.count) {
        cell.leftLB.text = [NSString stringWithFormat:@"管理员账户:%@",self.dataArray[indexPath.row].mobile];
        cell.rigtBt.hidden = NO;
        cell.rightIgV.hidden = YES;
        cell.rigtBt.tag = indexPath.row;
        [cell.rigtBt addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        cell.leftLB.text = @"+ 添加管理员";
        cell.rigtBt.hidden = YES;
        cell.rightIgV.hidden = NO;
    }
    return cell;
    
}

- (void)delectAction:(UIButton *)button {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"memberid"] = self.dataArray[button.tag].memberid;
    dict[@"merchid"] = self.dataArray[button.tag].merchid;
    [zkRequestTool networkingPOST:merchdelete_admin_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            [self.dataArray removeObjectAtIndex:button.tag];
            self.titleLB.text = [NSString stringWithFormat:@"店铺管理员(%ld/5)",self.dataArray.count];
            [self.tableView reloadData];
            
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
    
    if (indexPath.row == self.dataArray.count ){
        
        SWTMJAddRenYuanVC * vc =[[SWTMJAddRenYuanVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
@end
