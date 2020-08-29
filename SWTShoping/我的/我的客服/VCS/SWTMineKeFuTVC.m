//
//  SWTMineKeFuTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineKeFuTVC.h"
#import "SWTMineKeFuOneCell.h"
#import "SWTMineKeFuTwoCell.h"
#import "SWTMineKeFuHeadView.h"
@interface SWTMineKeFuTVC ()
@property(nonatomic , strong)NSMutableArray *dataArray;
@property(nonatomic , strong)NSArray *reMenArr;
@property(nonatomic , assign)CGFloat cellH;
@property(nonatomic , strong)NSString *IMID;
@end

@implementation SWTMineKeFuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的客服";
    [self.tableView registerClass:[SWTMineKeFuTwoCell class] forCellReuseIdentifier:@"SWTMineKeFuTwoCell"];
    [self.tableView registerClass:[SWTMineKeFuOneCell class] forCellReuseIdentifier:@"SWTMineKeFuOneCell"];
    [self.tableView registerClass:[SWTMineKeFuHeadView class] forHeaderFooterViewReuseIdentifier:@"head"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = @[@"",@""].mutableCopy;
    [self getData];
    
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    button.titleLabel.font = kFont(13);
    [button setTitle:@"人工客服" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:self.IMID];
        TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
        vc.navigationItem.title = @"客服";
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self getIM];
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:userConsultlist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.reMenArr = responseObject[@"data"];
            CGFloat hh = 0;
            for (int i = 0 ; i < self.reMenArr.count; i++) {
                CGFloat h = [[NSString stringWithFormat:@" · %@",self.reMenArr[i]] getHeigtWithFontSize:13 lineSpace:0 width:ScreenW - 140] + 10 ;
                hh = hh + h;
            }
            self.cellH = hh;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

//获取客服IM
- (void)getIM {
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:getimid_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.IMID =  [NSString stringWithFormat:@"%@",responseObject[@"data"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.reMenArr == nil) {
        return 0;
    }
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 75;
    }else if (indexPath.row == 1) {
        return 20 + 28 + self.cellH + 10 + 10;
    }
    CGFloat hh = [self.dataArray[indexPath.row] getHeigtWithFontSize:13 lineSpace:0 width:ScreenW - 130];
    if (hh < 30) {
        hh = 30;
    }
    return 20 +  hh + 10+10;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        SWTMineKeFuTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineKeFuTwoCell" forIndexPath:indexPath];
        cell.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [cell.delegateSignal subscribeNext:^(NSString* x) {
            @strongify(self);
            
            
            [self didClickReMenActionWithTitle:x];
            
        }];
        cell.dataArray = self.reMenArr.mutableCopy;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        SWTMineKeFuOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineKeFuOneCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.titleLB.text = @"您好, 请问有什么可以帮助到您? 如果为解决问题,可以点击\"人工客服\"";
        }else {
            cell.titleLB.text = self.dataArray[indexPath.row];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)didClickReMenActionWithTitle:(NSString *)titleStr {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"title"] = titleStr;
    [zkRequestTool networkingPOST:userConsult_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [self.dataArray addObject:responseObject[@"data"]];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 52;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWTMineKeFuHeadView * headV  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    return headV;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



@end
