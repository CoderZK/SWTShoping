//
//  SWTHelpSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHelpSubTVC.h"
#import "SWTTongYongTwoCell.h"
@interface SWTHelpSubTVC ()
@property(nonatomic , strong)NSArray *titleArr;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTHelpSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTongYongTwoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
//    @weakify(self);
//    [LTSCEventBus registerEvent:@"helpsub" block:^(NSDictionary * dict) {
//       @strongify(self);
//        if ([dict.allKeys containsObject:@"ID"]) {
//            self.ID = dict[@"ID"];
//        }
//        if ([dict.allKeys containsObject:@"type"]) {
//            if ([dict[@"type"] intValue] == self.type) {
//                [self getData];
//            }
//        }
//
//
//
//    }];
    
    self.tableView.backgroundColor = BackgroundColor;
    
     [self getData];
    
}

- (void)getData {
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:helpList_SWT parameters:self.ID success:^(NSURLSessionDataTask *task, id responseObject) {
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
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTTongYongTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.dataArray[indexPath.row].name;
    cell.rightLB.text = @"";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self getContentDataWithID:self.dataArray[indexPath.row].ID];
    
}


- (void)getContentDataWithID:(NSString *)ID {
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:helpList_SWT parameters:ID success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            SWTModel * mm = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];

            SWTXiYieVC * vc =[[SWTXiYieVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.titleStr = mm.title;
            vc.contentStr = mm.content;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
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
