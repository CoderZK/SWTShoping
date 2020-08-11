//
//  SWTMineAddressTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineAddressTVC.h"
#import "SWTMienAddressCell.h"
#import "SWTMienAddressCell.h"
#import "SWTAddMineAddressTVC.h"
#import "SWTEditAddressTVC.h"
@interface SWTMineAddressTVC ()
@property(nonatomic , strong)UIView *footV;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTMineAddressTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 1;
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收货地址";
    [self initFootV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMienAddressCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self.view);
        make.bottom.equalTo(self.footV.mas_top);
    }];
    
    
    self.dataArray = @[].mutableCopy;
   
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    Weak(weakSelf);
       self.noneView.clickBlock = ^{
           
           weakSelf.page = 1;
           [weakSelf getData];
         };
    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pagesize"] = @(10);
    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",addressList_SWT,[zkSignleTool shareTool].session_uid] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
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


- (void)initFootV  {
    
    self.footV = [[UIView alloc] init];
    [self.view addSubview:self.footV];
    
    UIButton * loginOutBt  =[[UIButton alloc] init];
    [loginOutBt setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    [loginOutBt setTitle:@"添加地址" forState:UIControlStateNormal];
    loginOutBt.titleLabel.font = kFont(14);
    loginOutBt.layer.cornerRadius = 22.5;
    loginOutBt.clipsToBounds = YES;
    [self.footV addSubview:loginOutBt];
    [[loginOutBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        SWTAddMineAddressTVC * vc =[[SWTAddMineAddressTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    [self.footV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(34+45 + 30));
    }];
    
    [loginOutBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.footV);
        make.height.equalTo(@45);
        make.width.equalTo(@(ScreenW - 100));
        make.top.equalTo(self.footV).offset(30);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMienAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    @weakify(self);
    [[cell.editBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        SWTEditAddressTVC * vc =[[SWTEditAddressTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];;
    }];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.sendAddressModelBlock  != nil) {
        self.sendAddressModelBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}


@end
