//
//  SWTSearchSubVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTSearchSubVC.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "SWTHomeCollectionTwoCell.h"
#import "SWTHomeCollectionThreeCell.h"
@interface SWTSearchSubVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XPCollectionViewWaterfallFlowLayoutDataSource>
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , strong)NSString *searchWord;

@end

@implementation SWTSearchSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.layout.dataSource = self;
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:self.layout];;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //               self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        if (sstatusHeight > 20) {
           make.bottom.equalTo(self.view).offset(-34);
        }else {
            make.bottom.equalTo(self.view).offset(0);
        }
        
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionTwoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionThreeCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell"];
    
    [self.view addSubview:self.collectionView];
    
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
    [LTSCEventBus registerEvent:@"search" block:^(NSString * data) {
        weakSelf.searchWord = data;
        weakSelf.page = 1;
        [weakSelf getData];
    }];
    
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
    dict[@"name"] = self.searchWord;
    dict[@"type"] = @(self.type+1);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:search_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
    
    
    
    SWTModel * model = self.dataArray[indexPath.row];
    model.goodprice = model.price;
    if (self.type == 0) {
        if ([model.showtype isEqualToString:@"live"]) {
            SWTHomeCollectionTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell" forIndexPath:indexPath];
            model.playnum = model.watchnum;
            cell.model = model;
            return cell;
        }else {
            SWTHomeCollectionThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell" forIndexPath:indexPath];
            
            cell.model = model;
            return cell;
        }
    }else {
        SWTHomeCollectionTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell" forIndexPath:indexPath];
        model.playnum = model.watchnum;
        cell.model = model;
        return cell;
    }
    
    
    
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
   
    
    SWTModel * model = self.dataArray[indexPath.row];
    
    if (self.type == 2) {
        SWTZhiBoDetailVC * vc =[[SWTZhiBoDetailVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.model = model;
        if ([model.type isEqualToString:@"share"]) {
            vc.isHeMai = YES;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if ([model.showtype isEqualToString:@"live"]) {
            SWTZhiBoDetailVC * vc =[[SWTZhiBoDetailVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            if ([model.type isEqualToString:@"share"]) {
                vc.isHeMai = YES;
            }
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.goodID = self.dataArray[indexPath.row].goodid;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
    
    
    
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    
    return 2;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGFloat imgH  =   (ScreenW - 30)/2 * 3/4;
    SWTModel * model = self.dataArray[indexPath.row];
    if ([model.showtype isEqualToString:@"live"]) {
        
        return  (ScreenW - 30)/2;
    }else {
        NSArray * arr = [model getTypeLBArr];
        if (arr.count == 0) {
            return imgH + 39;
        }else {
            return imgH + 59;
        }
    }
    
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
