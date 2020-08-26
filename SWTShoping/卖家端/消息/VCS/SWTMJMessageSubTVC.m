//
//  SWTMJMessageSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMessageSubTVC.h"
#import "SWTMJMessageOneCell.h"
@interface SWTMJMessageSubTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTMJMessageSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMessageOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    if (self.type == 0) {
        
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
            
            
            [weakSelf getData];
        };
    }else {
        
    }
    
    
    
}



- (void)getData {
    
    if (!ISLOGIN) {
        [self gotoLoginVC];
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"memberid"] = [zkSignleTool shareTool].session_uid;
    dict[@"pageindex"] = @(self.page);
    dict[@"pagesize"] = @(20);
    [zkRequestTool networkingPOST:merchmsgGet_msg_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
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
            self.page++;
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
    return 80;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJMessageOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
