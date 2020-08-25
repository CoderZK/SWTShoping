//
//  SWTMJZhiBoHomeTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJZhiBoHomeTVC.h"
#import "SWTMineFaBuOneCell.h"
#import "SWTMJAddZhiBoShangPinTVC.h"
@interface SWTMJZhiBoHomeTVC ()

@end

@implementation SWTMJZhiBoHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"直播";
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineFaBuOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineFaBuOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleLB.text = @"直播";
        cell.imgV.image = [UIImage imageNamed:@"bbdyx59"];
    }else {
        cell.titleLB.text = @"添加商品";
        cell.imgV.image = [UIImage imageNamed:@"bbdyx60"];
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
    }else {
       
        [self checkRoom];
    }
    
}

- (void)checkRoom  {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchliveCheck_room_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            NSString * status = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"status"]];
            if (status.intValue == 1) {
                [SVProgressHUD showErrorWithStatus:@"直播未申请"];
            }else if (status.intValue == 2) {
                [SVProgressHUD showErrorWithStatus:@"直播等待审核中"];
            }else if (status.intValue == 3) {
                
                SWTMJAddZhiBoShangPinTVC * vc =[[SWTMJAddZhiBoShangPinTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.liveid = responseObject[@"data"][@"liveid"];
                [self.navigationController pushViewController:vc animated:YES];
            }else if (status.intValue == 4) {
                [SVProgressHUD showErrorWithStatus:@"直播间被禁用"];
            }
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

}


@end
