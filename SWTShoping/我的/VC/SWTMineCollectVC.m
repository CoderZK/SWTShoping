//
//  SWTMineCollectVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineCollectVC.h"
#import "SWTGuanZhuCollectionCell.h"
@interface SWTMineCollectVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XPCollectionViewWaterfallFlowLayoutDataSource>
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;

@end

@implementation SWTMineCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    
    self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.layout.dataSource = self;
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, ScreenW, ScreenH) collectionViewLayout:self.layout];;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //               self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTGuanZhuCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SWTGuanZhuCollectionCell"];
    
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        [weakSelf getData];
    };
    
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    [zkRequestTool networkingPOST: userFav_SWT parameters:[zkSignleTool shareTool].session_uid success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    
    return self.dataArray.count;
    
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SWTGuanZhuCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTGuanZhuCollectionCell" forIndexPath:indexPath];
    self.dataArray[indexPath.row].goodprice = self.dataArray[indexPath.row].price;
    self.dataArray[indexPath.row].goodimg = self.dataArray[indexPath.row].img;
    cell.model = self.dataArray[indexPath.row];
    cell.leftTopImgV.hidden = cell.zhiBoZhongLB.hidden = YES;
    return cell;
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.goodID = self.dataArray[indexPath.row].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    
    return 2;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenW - 30)/2 + 64;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

@end
