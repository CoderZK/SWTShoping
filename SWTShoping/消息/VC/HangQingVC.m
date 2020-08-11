//
//  HangQingVC.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HangQingVC.h"
#import "SWTMessageOneCell.h"
#import "SWTMessageDetailListTVC.h"
@interface HangQingVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation HangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMessageOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        
        [weakSelf getData];
    };
    
    
    [LTSCEventBus registerEvent:@"diss" block:^(id data) {
        weakSelf.tabBarController.selectedIndex  = 0;
    }];
    
}

- (void)getData {
    
    if (!ISLOGIN) {
        [self gotoLoginVC];
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"receiveid"] = [zkSignleTool shareTool].session_uid;
    //    dict[@"receiveid"] = @"1";
    [zkRequestTool networkingPOST:pushmsgList_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
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
    //    return 10;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMessageOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.nameLB.text = @"fgkodkgfeoprkgkp";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SWTModel * model = self.dataArray[indexPath.row];
    cell.timeLB.text = model.createtime;
    cell.contentLB.text = model.content;
    if (model.type.intValue == 2) {
        cell.nameLB.text = @"系统消息";
        cell.imgV.image = [UIImage imageNamed:@"369"];
    }else {
        cell.nameLB.text = model.site_name;
        [cell.imgV sd_setImageWithURL:[model.logo getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SWTMessageDetailListTVC * vc =[[SWTMessageDetailListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.sendid = self.dataArray[indexPath.row].sendid;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}



@end
