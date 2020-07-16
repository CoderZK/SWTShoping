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
@property(nonatomic , strong)NSString *ID;
@end

@implementation SWTHelpSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTongYongTwoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.titleArr = @[@"发货时间",@"发货快递公司",@"运费问题",@"怎么联系商家"];
    @weakify(self);
    [LTSCEventBus registerEvent:@"helpsub" block:^(NSDictionary * dict) {
       @strongify(self);
        if ([dict.allKeys containsObject:@"ID"]) {
            self.ID = dict[@"ID"];
        }
        if ([dict.allKeys containsObject:@"type"]) {
            if ([dict[@"type"] intValue] == self.type) {
                [self getData];
            }
        }
        
        
        
    }];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:helpList_SWT parameters:self.ID success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTTongYongTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.titleArr[indexPath.row];
    cell.rightLB.text = @"";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
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
