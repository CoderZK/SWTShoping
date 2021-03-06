//
//  SWTMineAttentionZhiBoVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/1.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineAttentionZhiBoVC.h"
#import "SWTHomeCollectionTwoCell.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
@interface SWTMineAttentionZhiBoVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XPCollectionViewWaterfallFlowLayoutDataSource>
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;

@property(nonatomic , strong)UICollectionView *collectionView;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTMineAttentionZhiBoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.layout.dataSource = self;
    
    CGRect frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 - 40 - 49);
    if (sstatusHeight > 20) {
        frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 - 40 - 49 - 34);
    }

    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.layout];;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //               self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionTwoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    

    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
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
    NSString * url =  [NSString stringWithFormat:@"%@/%@",userFollow_SWT,[zkSignleTool shareTool].session_uid];
    dict[@"type"] = @"0";
    if (self.isMineZuJi) {
        url =  [NSString stringWithFormat:@"%@/%@",userTrace_SWT,[zkSignleTool shareTool].session_uid];
        dict[@"type"] = @"1";
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
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
            
            
            [self.collectionView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        
        
    }];
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    return 9;
    return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SWTHomeCollectionTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell" forIndexPath:indexPath];
    self.dataArray[indexPath.row].img = self.dataArray[indexPath.row].liveimg;
    self.dataArray[indexPath.row].name = self.dataArray[indexPath.row].livename;
    self.dataArray[indexPath.row].playnum = self.dataArray[indexPath.row].watchnum;
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if  (self.isMineZuJi) {
        
        SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.goodID = self.dataArray[indexPath.row].ID;
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else {
        SWTZhiBoDetailVC * vc =[[SWTZhiBoDetailVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           vc.model = self.dataArray[indexPath.row];
        if ([self.dataArray[indexPath.row].type isEqualToString:@"share"]) {
            vc.isHeMai = YES;
        }
           [self.navigationController pushViewController:vc animated:YES];
    }
    
   
}



- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    
    return 2;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenW -30)/2;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10.0, 10.0, 10.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}


@end
