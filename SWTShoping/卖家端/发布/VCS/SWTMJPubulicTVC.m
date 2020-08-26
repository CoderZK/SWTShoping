//
//  SWTMJPubulicTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJPubulicTVC.h"
#import "SWTMineFaBuOneCell.h"
#import "SWTMJMineVideoFatherVC.h"
@interface SWTMJPubulicTVC ()

@end

@implementation SWTMJPubulicTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineFaBuOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self setLeftNagate];
}

- (void)setLeftNagate {
    
    UIButton * leftBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    @weakify(self);
    [[leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
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
        cell.titleLB.text = @"视频";
        cell.imgV.image = [UIImage imageNamed:@"bbdyx60"];
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self checkRoom];
    }else {
        SWTMJMineVideoFatherVC * vc =[[SWTMJMineVideoFatherVC alloc] init];
                   vc.hidesBottomBarWhenPushed = YES;
                   [self.navigationController pushViewController:vc animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
