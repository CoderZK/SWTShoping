//
//  MJHeMaiSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiSubTVC.h"
#import "MJHeMaiOrderCell.h"
#import "MJHeMaiDetailTVC.h"
#import "MJUpDatePicTVC.h"
#import "SWTMineHeMaiOrderCell.h"
@interface MJHeMaiSubTVC ()<zkPickViewDelelgate>

@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic,assign)NSInteger index;
@end

@implementation MJHeMaiSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiOrderCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[SWTMineHeMaiOrderCell class] forCellReuseIdentifier:@"cell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self getData];
    }];

    Weak(weakSelf);;
    self.noneView.clickBlock = ^{
   
        [weakSelf getData];
        
    };
    
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    dict[@"type"] = @(self.type+1);
    [zkRequestTool networkingPOST:merchsharelist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.noneView.hidden = self.dataArray.count > 0;
            [self.noneView showNoneDataViewAt:self.view img:[UIImage imageNamed:@"dyx47"] tips:@"暂无数据"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        return 165;
    }else {
        return UITableViewAutomaticDimension;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        MJHeMaiOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.centerBt.tag = indexPath.row;
        cell.leftBt.tag = indexPath.row;
        [cell.centerBt  addTarget:self action:@selector(upPicAction:) forControlEvents:UIControlEventTouchUpInside];
         [cell.leftBt  addTarget:self action:@selector(upPicActionTwo:) forControlEvents:UIControlEventTouchUpInside];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else {
        SWTMineHeMaiOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//        cell.rightOneBt.tag = indexPath.row;
//        [cell.rightOneBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        cell.type = self.type;
//        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MJHeMaiDetailTVC * vc =[[MJHeMaiDetailTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.orderID = self.dataArray[indexPath.row].orderid;
    vc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)clickAction:(UIButton *)button {
    
}


- (void)upPicAction:(UIButton *)button {
    self.index = button.tag;
    zkPickView * pickV = [[zkPickView alloc] init];
    pickV.arrayType = titleArray;
    pickV.array = @[@"上传开料结果",@"上传毛坯结果",@"上传成品结果"].mutableCopy;
    [pickV show];
    pickV.delegate = self;
}

- (void)upPicActionTwo:(UIButton *)button {
    
    MJUpDatePicTVC * vc =[[MJUpDatePicTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = 1;
    vc.goodsID = self.dataArray[button.tag].goodid;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    
    MJUpDatePicTVC * vc =[[MJUpDatePicTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = 2+leftIndex;
    vc.goodsID = self.dataArray[self.index].goodid;
    vc.dataModel = self.dataArray[self.index];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
