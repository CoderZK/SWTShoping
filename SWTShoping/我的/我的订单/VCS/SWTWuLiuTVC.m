//
//  SWTWuLiuTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTWuLiuTVC.h"
#import "SWTWuLiuOneCell.h"
@interface SWTWuLiuTVC ()
@property(nonatomic , strong)NSMutableArray<SWTWuLiuModel *> *dataArray;
@end

@implementation SWTWuLiuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的物流";
  
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTWuLiuOneCell" bundle:nil] forCellReuseIdentifier:@"SWTWuLiuOneCell"];
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
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:expressg_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            NSArray * arr = @[];
            NSDictionary * dict = [responseObject[@"data"] mj_JSONObject];
            if ([dict.allKeys containsObject:@"data"]) {
                arr = dict[@"data"];
            }
            self.dataArray = [SWTWuLiuModel mj_objectArrayWithKeyValuesArray:arr];
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

    SWTWuLiuOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTWuLiuOneCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.topLineV.hidden = YES;
    }else {
        cell.topLineV.hidden = NO;
    }
    if (indexPath.row+1 == self.dataArray.count ) {
        cell.bottomLineV.hidden = YES;
    }else {
        cell.bottomLineV.hidden = NO;
    }
    SWTWuLiuModel * model = self.dataArray[indexPath.row];
    
    cell.timeLB.text = model.time.length >= 16 ? [model.time substringWithRange:NSMakeRange(5, 11)]: model.time;
    cell.contentLB.text = model.context;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end


@implementation SWTWuLiuModel



@end
