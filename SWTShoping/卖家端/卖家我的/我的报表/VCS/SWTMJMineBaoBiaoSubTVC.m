//
//  SWTMJMineBaoBiaoSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineBaoBiaoSubTVC.h"
#import "SWTMineBaoBiaoHeadView.h"
#import "SWTMJMineBaoBiaoCell.h"
@interface SWTMJMineBaoBiaoSubTVC ()
@property(nonatomic , strong)NSArray *leftArr;
@property(nonatomic , strong)NSDictionary *dataDict;
@end

@implementation SWTMJMineBaoBiaoSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMineBaoBiaoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[SWTMineBaoBiaoHeadView class] forHeaderFooterViewReuseIdentifier:@"head"];
    [self getData];
    
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    NSString * url = merchreportGet_finance_report_SWT;
    if (self.type == 1) {
        url = merchreportGet_merch_report_SWT;
    }
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataDict = responseObject[@"data"];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataDict== nil) {
        return 0;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == 0) {
        if (section == 1) {
            return 2;
        }else {
            return 1;
        }
    }else if (self.type == 1) {
        return 1;
    }else {
        return 1;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJMineBaoBiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.LB3.hidden = cell.LB4.hidden = YES;
    if (self.type == 0) {
        cell.LB3.hidden = cell.LB4.hidden = NO;
        cell.LB3.text = @"数量";
        if (indexPath.section == 0) {
            cell.LB1.text = @"今日成拍:";
            cell.LB2.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"ok"][@"price"]];;
            cell.LB4.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"ok"][@"num"]];;
        }else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.LB1.text = @"今日已经付款: ";
                cell.LB2.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"pay"][@"price"]];
                cell.LB4.text = [NSString stringWithFormat:@"%@",self.dataDict[@"pay"][@"num"]];
            }else {
                cell.LB1.text = @"今日已经退款: ";
                cell.LB2.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"refund"][@"price"]];
                cell.LB4.text = [NSString stringWithFormat:@"%@",self.dataDict[@"refund"][@"num"]];
            }
        }else if (indexPath.section == 2) {
            cell.LB1.text = @"今日已收款: ";
            cell.LB2.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"earn"][@"price"]];;
            cell.LB4.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"earn"][@"num"]];;
        }
    }else  {
        cell.LB3.hidden = cell.LB4.hidden = YES;
            cell.LB3.text = @"昨日笔数:";
            if (indexPath.section == 0) {
                cell.LB1.text = @"昨日直播时长:";
                cell.LB2.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"time"]];;
            }else if (indexPath.section == 1) {
                
                cell.LB1.text = @"昨日销售额: ";
                cell.LB2.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"live"][@"price"]];;
                cell.LB3.hidden = cell.LB4.hidden = NO;
                cell.LB4.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"live"][@"num"]];;
                
            }else if (indexPath.section == 2) {
                cell.LB1.text = @"粉丝数量: ";
                cell.LB2.text =  [NSString stringWithFormat:@"%@",self.dataDict[@"follow"]];;
            }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWTMineBaoBiaoHeadView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (self.type == 0) {
        if (section == 0) {
            view.leftLB.text = @"成排报表";
        }else if (section == 1) {
             view.leftLB.text = @"销售报表";
        }else if (section == 2) {
             view.leftLB.text = @"收款报表";
        }else if (section == 3) {
             view.leftLB.text = @"待收款报表";
        }
        
    }else if (self.type == 1) {
       if (section == 0) {
            view.leftLB.text = @"直播概览";
        }else if (section == 1) {
             view.leftLB.text = @"直播销售额";
        }else if (section == 2) {
             view.leftLB.text = @"互动数据";
        }else if (section == 3) {
             view.leftLB.text = @"粉丝数";
        }
        
    }
    return view;
}

@end
