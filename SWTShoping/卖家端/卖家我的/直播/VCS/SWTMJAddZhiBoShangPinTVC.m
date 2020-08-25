//
//  SWTMJAddZhiBoShangPinTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJAddZhiBoShangPinTVC.h"
#import "SWTMJAddVideoTypeShowView.h"
#import "SWTMJAddZhiBoShangPinCell.h"
@interface SWTMJAddZhiBoShangPinTVC ()
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *goodListArr;
@end

@implementation SWTMJAddZhiBoShangPinTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品管理";
    
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    button.titleLabel.font = kFont(13);
    [button setTitle:@"添加" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //点击提交
        
        SWTMJAddVideoTypeShowView * showV  =[[SWTMJAddVideoTypeShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        showV.dataArray = self.goodListArr;
        showV.type = 1;
        showV.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [showV.delegateSignal subscribeNext:^(NSString * x) {
            @strongify(self);
            
            for (SWTModel * model  in self.dataArray) {
                if ([model.ID isEqualToString:x]) {
                    [SVProgressHUD showErrorWithStatus:@"该场频已经在值间里面了"];
                    return;
                }
            }
            
            [self addWidthID:x];
            
            
        }];
        [showV show];
        
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.dataArray = @[].mutableCopy;
    self.goodListArr = @[].mutableCopy;
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJAddZhiBoShangPinCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getDataList];
    [self getData];
    

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
        [self getDataList];
    }];

    
}

//添加操作
- (void)addWidthID:(NSString *)ID{
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"liveid"] = self.liveid;
    dict[@"good_id"] = ID;
    [zkRequestTool networkingPOST:merchliveAdd_live_goods_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"添加直播间商品成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getDataList];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}
//获取已经添加的列表
- (void)getDataList {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"liveid"] =self.liveid;
    [zkRequestTool networkingPOST:merchliveGet_live_goods_list_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}
//获取产品
- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageindex"] = @(1);
    dict[@"pagesize"] = @(1000);
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchgoodsGet_goods_list_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
   
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            self.goodListArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
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
    return 90;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJAddZhiBoShangPinCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
       
        
        [self delectWithIndex:indexPath];
        
    }
}

- (void)delectWithIndex:(NSIndexPath *)indexPath {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.dataArray[indexPath.row].ID;
    [zkRequestTool networkingPOST:merchliveDel_live_goods_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [self.dataArray removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
    
}



@end
