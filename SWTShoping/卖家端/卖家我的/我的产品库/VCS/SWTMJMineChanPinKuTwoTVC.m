//
//  SWTMJMineChanPinKuTwoTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineChanPinKuTwoTVC.h"
#import "SWTMineShopSettingSectionV.h"
#import "SWTMJMineChanPinListTVC.h"
#import "SWTAddMineChanPinKuTVC.h"
#import "SWTMJMineChanPinKuOneCell.h"
#import "SWTMJMineChanPinListTVC.h"
@interface SWTMJMineChanPinKuTwoTVC ()
@property(nonatomic , strong)UIView *headView;
@property(nonatomic , strong)UIButton *headBt;
@property(nonatomic , strong)UIButton *addBt;
@property(nonatomic , strong)UILabel *numberOneLB,*numberTwoLB;
@property(nonatomic , strong)SWTModel *dataModel;

@end

@implementation SWTMJMineChanPinKuTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"产品库";
    [self initHeadV];
    
     [self.tableView registerClass:[SWTMineShopSettingSectionV class] forHeaderFooterViewReuseIdentifier:@"head"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMineChanPinKuOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getData];
   
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchStatic_warehouse_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
            self.numberOneLB.text = self.dataModel.goodsnum.length == 0? 0:self.dataModel.goodsnum;
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)initHeadV {
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 160)];
    self.headView.backgroundColor = [UIColor clearColor];
    
    UIImageView * imgV  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
    imgV.image = [UIImage imageNamed:@"minebg"];
    [self.headView addSubview:imgV];
    
    self.headBt  = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 60, 60)];
    self.headBt.layer.cornerRadius = 30;
    self.headBt.clipsToBounds = YES;
    [self.headBt sd_setBackgroundImageWithURL:[self.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [self.headView addSubview:self.headBt];
    
    self.addBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 100, CGRectGetMinY(self.headBt.frame) + 20, 85, 30)];
    [self.addBt setTitle:@"添加产品>" forState:UIControlStateNormal];
    [self.addBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.addBt.titleLabel.font = kFont(14);
    [self.addBt addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.addBt];
    
    UIView * whV  =[[UIView alloc] initWithFrame:CGRectMake(20, 100, ScreenW - 40, 60)];
    whV.clipsToBounds = YES;
    whV.layer.cornerRadius = 5;
    whV.backgroundColor = WhiteColor;
    [self.headView addSubview:whV];

    
    
    self.numberOneLB = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, ScreenW - 100, 20)];
    self.numberOneLB.font = kFont(14);
    self.numberOneLB.text = @"20";
    self.numberOneLB.textAlignment = NSTextAlignmentCenter;
    [whV addSubview:self.numberOneLB];
    
    UILabel * lb1  = [[UILabel alloc] initWithFrame:CGRectMake(30, 35, ScreenW - 100, 20)];
    lb1.font = kFont(14);
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.text = @"产品";
    [whV addSubview:lb1];
    
    
    self.numberOneLB.userInteractionEnabled = lb1.userInteractionEnabled = YES;
    
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, ScreenW - 100, 60)];
    [whV addSubview:button1];
    button1.tag = 100;
    [button1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.numberTwoLB = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW - 40)/2 + 10, 10, (ScreenW - 40 - 70)/2, 20)];
//    self.numberTwoLB.font = kFont(14);
//    self.numberTwoLB.text = @"40";
//    self.numberTwoLB.textAlignment = NSTextAlignmentCenter;
//    [whV addSubview:self.numberTwoLB];
//
//    UILabel * lb2  = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW - 40)/2 + 10, 35, (ScreenW - 40 - 70)/2, 20)];
//    lb2.font = kFont(14);
//    lb2.textAlignment = NSTextAlignmentCenter;
//    lb2.text = @"产品库";
//    [whV addSubview:lb2];
//
//    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 40)/2 + 10, 0, (ScreenW - 40 - 70)/2, 60)];
//       [whV addSubview:button2];
//       button2.tag = 101;
//       [button2 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableHeaderView = self.headView;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJMineChanPinKuOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.left1.text = @"待发货";
        cell.left2.text = self.dataModel.orderpay.length == 0 ? @"0":self.dataModel.orderpay;
        cell.rigth1.text = @"待确认退款";
        cell.right2.text = self.dataModel.orderrefund.length == 0?@"0":self.dataModel.orderrefund;
    }else {
        cell.left1.text = @"本月";
        cell.left2.text = self.dataModel.orderprice_curr.length == 0 ? @"0":self.dataModel.orderprice_curr;
        cell.rigth1.text = @"上月";
        cell.right2.text = self.dataModel.orderprice_last.length == 0?@"0":self.dataModel.orderprice_last;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SWTMineShopSettingSectionV * headV  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (section == 0) {
        headV.titelLB.text = @"订单";
    } else if (section == 1) {
        headV.titelLB.text = @"收货款";
    }
    return headV;;
}

- (void)clickAction:(UIButton *)button {

        //点击产品
        SWTMJMineChanPinListTVC * vc =[[SWTMJMineChanPinListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)addAction:(UIButton *)button {
    SWTAddMineChanPinKuTVC * vc =[[SWTAddMineChanPinKuTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
