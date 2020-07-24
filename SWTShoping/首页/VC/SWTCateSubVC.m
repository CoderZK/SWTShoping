//
//  SWTCateSubVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTCateSubVC.h"
#import "SWTCateSearchView.h"
#import "SWTHomeCollectionTwoCell.h"
#import "SWTHomeCollectionThreeCell.h"
#import "SWTShaiXuanRightView.h"
#import "SWTZhiBoDetailVC.h"
@interface SWTCateSubVC ()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,XPCollectionViewWaterfallFlowLayoutDataSource>
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic , strong)SWTCateSearchView *headV;
@property(nonatomic , strong)NSString *cateID,*upOrDown;
@property(nonatomic , assign)NSInteger  paiMaiOrYiKouJia,jiaGeOrTimeType; // 0 拍卖  1一口价  // 1 价格 2 时间
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *titleArr;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *caiZhiArr;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic , strong)NSArray *caiLiaoIDArr;
@property(nonatomic , strong)NSDictionary *fuwuDict;
@property(nonatomic , strong)NSString *lowMoneyStr,*heightMoneyStr;
@property(nonatomic , assign)NSInteger  type;


@end

@implementation SWTCateSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.naStr;
    [self addheadV];
    self.cateID = @"0";
    self.view.backgroundColor = BackgroundColor;
    [self addCollectionView];
    
    self.dataArray = @[].mutableCopy;
    
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
    [self getScondCaterData];
    self.caiZhiArr = @[].mutableCopy;
    [self getCaiZhiData];
    
}

- (void)getScondCaterData {
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:goodChildcategory_SWT parameters:self.ID success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.titleArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.headV.selectIndex = 0;
            self.headV.dataArray = self.titleArr;
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        
    }];
    
}

- (void)getCaiZhiData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:goodMaterial_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.caiZhiArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}


- (void)addheadV {
    self.headV = [[SWTCateSearchView alloc] init];
    self.headV.selectIndex = 0;
    self.headV.dataArray = self.titleArr;
    [self.view addSubview:self.headV];
    [self.headV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    self.headV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [self.headV.delegateSignal subscribeNext:^(NSNumber  *value) {
        @strongify(self);
        
        NSInteger tag = value.intValue;
        
        if (tag == 0) {
            //拍卖
            self.paiMaiOrYiKouJia = 0;
        }else if (tag == 1) {
            //一口价
            self.paiMaiOrYiKouJia = 1;
        }else if (tag == 2) {
            //筛选
            SWTShaiXuanRightView * shaiXuanView = [[SWTShaiXuanRightView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) withArr:self.caiZhiArr];
            Weak(weakSelf);
            shaiXuanView.shaiXuanBlock = ^(NSString * _Nonnull lowMoneyStr, NSString * _Nonnull heightMoneyStr, NSArray * _Nonnull caiLiaoIDarr, NSDictionary * _Nonnull fuwuDict) {
                NSLog(@"%@\n%@\n%@\n%@",lowMoneyStr,heightMoneyStr,caiLiaoIDarr,fuwuDict);
                weakSelf.lowMoneyStr = lowMoneyStr;
                weakSelf.heightMoneyStr = heightMoneyStr;
                weakSelf.fuwuDict = fuwuDict;
                weakSelf.caiLiaoIDArr = caiLiaoIDarr;
                weakSelf.page = 1;
                [weakSelf getData];
                
            };
            [shaiXuanView show];
        }else if (tag == 3) {
            //最新
            self.jiaGeOrTimeType = 1;
            if (self.headV.jiaGeClickNumber % 3 == 1) {
                self.upOrDown = @"up";
            }else if (self.headV.jiaGeClickNumber % 3 == 2) {
                self.upOrDown = @"down";
            }else {
                self.upOrDown = @"";
            }
        }else if (tag == 4) {
            //价格
            self.jiaGeOrTimeType = 2;
            if (self.headV.timeNumber % 3 == 1) {
                self.upOrDown = @"up";
            }else if (self.headV.timeNumber % 3 == 2) {
                self.upOrDown = @"down";
            }else {
                self.upOrDown = @"";
            }
        }else {
            //点击类型 tag 从100 开始
            if (tag == 100) {
                self.cateID = @"0";
            }else {
                self.cateID = self.titleArr[tag - 101].ID;
            }
            
        }
        self.page = 1;
        [self getData];
        
    }];
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"sorttype"] = @(self.jiaGeOrTimeType);
    dict[@"sortway"] = self.upOrDown;
    dict[@"page"] = @(self.page);
    dict[@"pagesize"] = @(10);
    [dict addEntriesFromDictionary:self.fuwuDict];
    dict[@"material"] = [self.caiLiaoIDArr componentsJoinedByString:@","];
    dict[@"lowprice"] = self.lowMoneyStr;
    dict[@"topprice"] = self.heightMoneyStr;
    dict[@"type"] = @(self.paiMaiOrYiKouJia);
    dict[@"categoryid"] =  self.cateID;
    dict[@"pid"] = self.ID;
    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",goodList_SWT,self.cateID] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
            [self.collectionView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    }];
}

- (void)addCollectionView {
    
    self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.layout.dataSource = self;
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -sstatusHeight - 44, ScreenW, ScreenH + sstatusHeight) collectionViewLayout:self.layout];;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //               self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.collectionView];
    
    
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionTwoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionThreeCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell"];
    
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headV.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
    //    return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SWTModel * model = self.dataArray[indexPath.row];
    model.playnum = model.watchnum;
    
    if ([model.showtype isEqualToString:@"live"]) {
        SWTHomeCollectionTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell" forIndexPath:indexPath];
        model.playnum = model.watchnum;
        cell.model = model;
        return cell;
    }else {
        SWTHomeCollectionThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell" forIndexPath:indexPath];
        model.goodprice = model.price;
        cell.model = model;
        return cell;
    }
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SWTModel * model = self.dataArray[indexPath.row];
    
    if ([model.showtype isEqualToString:@"live"]) {
        SWTZhiBoDetailVC * vc =[[SWTZhiBoDetailVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.goodID = self.dataArray[indexPath.row].goodid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}



- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    
    return 2;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150 + arc4random() % 100;
    
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
