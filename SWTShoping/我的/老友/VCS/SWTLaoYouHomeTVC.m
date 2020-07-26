//
//  SWTLaoYouHomeTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouHomeTVC.h"
#import "SWTLaoYouHomeHeadView.h"
#import "SWTLaoYouTwoCell.h"
#import "SWTLaoYouThreeCell.h"
#import "SWTLaoYouPinLeiCell.h"
#import "SWTLaoYouKaiDianLiuChengCell.h"
#import "SWTLaoYouSectionHeadView.h"
#import "SWTLaoYouDianPuInfoOneTVC.h"
@interface SWTLaoYouHomeTVC ()
@property(nonatomic , strong)SWTLaoYouHomeHeadView *headV;
@property(nonatomic , strong)UIView*footV;
@property(nonatomic , strong)NSDictionary *dataDict;
@end

@implementation SWTLaoYouHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要开店";
    [self initAddHeadV];
    
    [self.tableView registerClass:[SWTLaoYouTwoCell class] forCellReuseIdentifier:@"SWTLaoYouTwoCell"];
    [self.tableView registerClass:[SWTLaoYouThreeCell class] forCellReuseIdentifier:@"SWTLaoYouThreeCell"];
      [self.tableView registerClass:[SWTLaoYouPinLeiCell class] forCellReuseIdentifier:@"SWTLaoYouPinLeiCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTLaoYouKaiDianLiuChengCell" bundle:nil] forCellReuseIdentifier:@"SWTLaoYouKaiDianLiuChengCell"];
    
    [self.tableView registerClass:[SWTLaoYouSectionHeadView class] forHeaderFooterViewReuseIdentifier:@"head"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB(182, 142, 101);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
    [self initFootV];
 
    
    [self getData];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:registerGet_info_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataDict = responseObject[@"data"];
            self.headV.dataDict = self.dataDict;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)initFootV {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    self.footV.backgroundColor = WhiteColor;
    
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(30, 50, ScreenW - 60, 40)];
    [button setTitle:@"立即开店" forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 20;
    button.clipsToBounds = YES;
    [self.footV addSubview:button];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        SWTLaoYouDianPuInfoOneTVC * vc =[[SWTLaoYouDianPuInfoOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    self.tableView.tableFooterView = self.footV;
    
}

- (void)initAddHeadV{
    self.headV =[[SWTLaoYouHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    
    self.tableView.tableHeaderView = self.headV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 190;
        }
        return UITableViewAutomaticDimension;
    }else if (indexPath.section == 1){
        return 180;
    }else {
        return 52+(ScreenW - 20)/5.0;
    }
    
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SWTLaoYouTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouTwoCell" forIndexPath:indexPath];
            cell.dataDict = self.dataDict;
            return cell;
        }else {
            SWTLaoYouThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouThreeCell" forIndexPath:indexPath];
            cell.type = indexPath.row+1;
            cell.dataArray = @[@"文以及那里解放前哦我软件过期偶奇偶军分区的从教",@"金佛群文件费",@"起飞前噢ifIQ日期融进去偶然放入哦确认机器机器融券若干哦过情人节公积金哦解耦前夹肉融"].mutableCopy;
            [cell layoutIfNeeded];
            return cell;
        }
    }else if (indexPath.section == 1) {
        
        SWTLaoYouPinLeiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouPinLeiCell" forIndexPath:indexPath];
        return cell;
    }else {
        SWTLaoYouKaiDianLiuChengCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouKaiDianLiuChengCell" forIndexPath:indexPath];
               return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else if (section == 1) {
        return 50;
    }else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWTLaoYouSectionHeadView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (section == 1) {
        view.titleLB.text = @"品类招聘";
    }else if (section == 2){
       view.titleLB.text = @"快速开店";
    }
    view.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
