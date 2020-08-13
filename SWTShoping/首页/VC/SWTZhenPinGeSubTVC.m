//
//  SWTZhenPinGeSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhenPinGeSubTVC.h"
#import "SWTMineGuanZHuDinaPuCell.h"
@interface SWTZhenPinGeSubTVC ()<SWTMineGuanZHuDinaPuCellDelegate>
@property(nonatomic , strong)UIImageView *imgV;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;

@end

@implementation SWTZhenPinGeSubTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tableView registerClass:[SWTMineGuanZHuDinaPuCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addImgV];
    
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
    
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        weakSelf.page = 1;
        [weakSelf getData];
      };
    
}

- (void)getTopImgStr  {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"4";
    [zkRequestTool networkingPOST:topimg_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        if ([responseObject[@"code"] intValue]== 200) {
            [self.imgV sd_setImageWithURL:[ [NSString stringWithFormat:@"%@",responseObject[@"data"]] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pagesize"] = @(10);
    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",merchList_SWT,self.cateID] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
- (void)addImgV {
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    self.imgV.image =[UIImage imageNamed:@"369"];
    [self.view addSubview:self.imgV];
    
    [self.view bringSubviewToFront:self.tableView];
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30+134+ 15;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineGuanZHuDinaPuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.nameLB.text = @"fgkodkgfeoprkgkp";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    cell.delegate = self;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark --- 点击 cell  ----

- (void)didClickGuanZhuDianPuView:(SWTMineGuanZHuDinaPuCell *)cell withIndex:(NSInteger)index isClickHead:(BOOL)isClickHead {
    if (isClickHead) {
        //点击的是头像或者进店
         NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
        SWTShopHomeVC * vc =[[SWTShopHomeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.shopId = self.dataArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else {
        //点击的是内部的其他信息
        NSIndexPath * indexPath  = [self.tableView indexPathForCell:cell];
        
        
        SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.goodID = self.dataArray[indexPath.row].goodNeiList[index].goodid;
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"---\n%f",scrollView.contentOffset.y);
    CGFloat yy =  120;
    if (scrollView.contentOffset.y<= -yy) {
        self.imgV.mj_y = 0;
        self.imgV.mj_h = 150 - (scrollView.contentOffset.y + yy );
    }else if (scrollView.contentOffset.y<= 150-yy) {
        self.imgV.mj_y =  -(scrollView.contentOffset.y + yy);
    }else {
        self.imgV.mj_y = - 200;
    }
    
}

@end
