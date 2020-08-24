//
//  SWTMJMineChanPinListTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineChanPinListTVC.h"
#import "SWTMJSearchBt.h"
#import "SWTMJChanPinListCell.h"
#import "SWTChanPinSearchView.h"
@interface SWTMJMineChanPinListTVC ()
@property(nonatomic , strong)UIView *seacrchV;
@property(nonatomic , strong)SWTMJSearchBt *leftBt,*centerBt,*rightBt;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , strong)SWTChanPinSearchView *searhV;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *pingMingArr;
@property(nonatomic , strong)NSMutableArray<SWTModel *>*caiZhiArr,*chanPinKuArr;
@property(nonatomic , strong)NSMutableDictionary *dataDict;
@end

@implementation SWTMJMineChanPinListTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searhV dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"产品列表";
    
    [self initHeadV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJChanPinListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    
    self.pingMingArr = @[].mutableCopy;
    [self getPingMingData];
    self.chanPinKuArr = @[].mutableCopy;
    [self getChanPinKuData];
    self.dataDict = @{}.mutableCopy;

    
}

- (void)getPingMingData  {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST:merchgoodsGet_goods_cate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.pingMingArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

}



- (void)getChanPinKuData  {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchgoodsGet_warehouse_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.chanPinKuArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageindex"] = @(self.page);
    dict[@"pagesize"] = @(10);
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [dict addEntriesFromDictionary:self.dataDict];
    [zkRequestTool networkingPOST:merchgoodsGet_goods_list_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}



- (void)initHeadV  {
    self.seacrchV = [[UIView alloc] init];
    [self.view addSubview:self.seacrchV];
    self.seacrchV.backgroundColor = [UIColor whiteColor];
  
   
    
    [self.seacrchV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@50);
        
    }];
    
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenW, 0.5)];
      backV.backgroundColor = lineBackColor;
     [self.seacrchV addSubview:backV];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.seacrchV.mas_bottom);
    }];
    
    CGFloat ww = [@"我" getWidhtWithFontSize:14];
    
    CGFloat space = (ScreenW - 40 - 11*ww - 30)/2.0;
    
    self.leftBt = [[SWTMJSearchBt alloc] initWithFrame:CGRectMake(20, 5, ww * 6 + 10, 40)];
    self.leftBt.tag = 100;
    [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBt.textLB.text = @"入库时间升序";
    [self.seacrchV addSubview:self.leftBt];
    
    self.centerBt = [[SWTMJSearchBt alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBt.frame) + space, 5, ww * 3 + 10, 40)];
    self.centerBt.tag = 101;
    [self.centerBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.centerBt.textLB.text = @"产品库";
    [self.seacrchV addSubview:self.centerBt];
    
    self.rightBt = [[SWTMJSearchBt alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.centerBt.frame) + space, 5, ww * 2 + 10, 40)];
      self.rightBt.tag = 102;
      [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
      self.rightBt.textLB.text = @"筛选";
      [self.seacrchV addSubview:self.rightBt];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJChanPinListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)clickAction:(UIButton *)button {
    self.searhV  = [[SWTChanPinSearchView alloc] initWithFrame:CGRectMake(0,sstatusHeight + 50 + 44, ScreenW, ScreenH - (sstatusHeight + 50 + 44) )];
    self.searhV.canPinFenLeiArr = self.pingMingArr;
    self.searhV.canPinKuArr = self.chanPinKuArr;
    self.searhV.dataArray = @[@"入库时间升序",@"入库时间降序"];
    if (button.tag == 100) {
        
    }else if (button.tag == 101) {
        self.searhV.dataArray = @[];
        
    }else {
        self.searhV.dataArray = @[];
        
    }
    self.searhV.type = button.tag -100;
    [self.searhV show];
    self.searhV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [self.searhV.delegateSignal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.searhV.type == 0) {
             self.dataDict[@"sort"] = x;
        }else if (self.searhV.type == 1) {
            self.dataDict[@"warehouse"] = x;
        }else {
            self.dataDict = (NSMutableDictionary *)x;
        }
        
        [self.searhV dismiss];
        self.page = 1;
        [self getData];
    }];
}

@end
