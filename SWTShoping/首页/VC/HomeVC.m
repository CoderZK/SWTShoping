//
//  HomeVC.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HomeVC.h"
#import "SWTHomeHeadView.h"
#import "SWTHomeCollectionHeadView.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "SWTHomeCollectionOneCell.h"
#import "SWTHomeCollectionTwoCell.h"
#import "SWTHomeCollectionThreeCell.h"
#import "SWTFenLeiFirstVC.h"
#import "SWTVideoFartherVC.h"
#import "SWTZhenPinGeFatherVC.h"
#import "SWTZhiBoDetailVC.h"
#import "SWTHeMaiFatherVC.h"
#import "SWTSearchFatherVC.h"
#import "SWTShowLoginView.h"
@interface HomeVC ()<UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,XPCollectionViewWaterfallFlowLayoutDataSource,SWTHomeHeadViewDelegate,SDCycleScrollViewDelegate>
@property(nonatomic , strong)SWTHomeHeadView *headView;
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic , strong)NSArray<SWTModel *> *bannerArr;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *recommendArr;
@property(nonatomic , assign)NSInteger  page;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *hotArr;
@property(nonatomic , strong)SWTShowLoginView *showLoginV;

@end

@implementation HomeVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self scrollViewDidScroll:self.collectionView];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    //    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //        self.page++;
    //        [self getData];
    //    }];
    
    if (ISLOGIN) {
        self.showLoginV.hidden = YES;
    }else {
        self.showLoginV.hidden = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"wbg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(SWTShowLoginView *)showLoginV {
    if (_showLoginV == nil) {
        _showLoginV = [[SWTShowLoginView alloc] init];
    }
    return _showLoginV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bannerArr = @[];
    self.recommendArr = @[].mutableCopy;
    self.hotArr = @[].mutableCopy;
    
    self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.layout.dataSource = self;
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -sstatusHeight - 44, ScreenW, ScreenH) collectionViewLayout:self.layout];;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //               self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[SWTHomeCollectionOneCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionTwoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionThreeCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell"];
    
    [self.collectionView registerClass:[SWTHomeCollectionHeadView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderView"];
    
    [self.view addSubview:self.collectionView];
    
    [self setNavigateView];
    [self setheadViewVV];
    
    self.page = 1;
    [self getData];
    [self getDataHotData];
    [self getRecommendData];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getDataHotData];
        [self getRecommendData];
    }];
  
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getRecommendData];
    }];
    
    [self.view addSubview:self.showLoginV];
    [self.showLoginV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@50);
        if (sstatusHeight > 20) {
            make.bottom.equalTo(self.view).offset(-83);
        }else {
            make.bottom.equalTo(self.view).offset(-49);
        }
    }];
    
    [self.showLoginV.rightBt addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loginAction {
    [self gotoLoginVC];
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @(1);
    [zkRequestTool networkingPOST:lideshow_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.bannerArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            NSMutableArray * picArr  = @[].mutableCopy;
            for (SWTModel * model  in self.bannerArr) {
                [picArr addObject:model.pic];
                
            }
            self.headView.sdView.imageURLStringsGroup = picArr;
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

- (void)getDataHotData {
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:indexHot_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.hotArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.collectionView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)getRecommendData {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @(1);
    dict[@"page"] = @(self.page);
    dict[@"pagesize"] = @(10);
    [zkRequestTool networkingPOST:indexRecommend_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {
            NSArray<SWTModel *> * arr =  [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.page == 1) {
                [self.recommendArr removeAllObjects];
            }
             [self.recommendArr addObjectsFromArray:arr];
            [self.collectionView reloadData];
            //            self.headView.sdView.imageURLStringsGroup = picArr;
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    }];
    
}
- (void)setNavigateView {
    
    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 120, 44)];
    searchTitleView.searchTF.delegate = self;
    searchTitleView.isPush = YES;
    
    self.navigationItem.titleView = searchTitleView;
    @weakify(self);
    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        @strongify(self);
        if (value.length > 0) {
            return YES;
        }else {
            return NO;
        }
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"======\n%@",x);
    }];
    
    [searchTitleView.clickBt addTarget:self action:@selector(goSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = searchTitleView;
    
    UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 56, 19)];
    //    submitBtn.layer.cornerRadius = 22;
    //    submitBtn.layer.masksToBounds = YES;
    // [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    [submitBtn setImage:[UIImage imageNamed:@"jkgl1"] forState:UIControlStateNormal];
    submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [submitBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
//    [submitBtn setTitle:@"滴雨轩" forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    
    //    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:nil];
    
    
}

- (void)goSearch:(UIButton *)button {
    SWTSearchFatherVC * vc =[[SWTSearchFatherVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setheadViewVV{
    
    self.collectionView.contentInset = UIEdgeInsetsMake(sstatusHeight + 44 + 10 + (ScreenW) / 345 * 150 +110 ,0, 0, 0);
    self.headView = [[SWTHomeHeadView alloc] initWithFrame:CGRectMake(0, -( sstatusHeight + 44 + 10 + (ScreenW ) / 345 * 150 +110), ScreenW, sstatusHeight + 44 + 10 + (ScreenW ) / 345 * 150 +110)];
    self.headView.delegate = self;
    self.headView.sdView.delegate = self;
    [self.collectionView addSubview:self.headView];;
    
}


#pragma mark ----- 点击轮播图或者下面的按钮 ----

- (void)didClickHomeHeadViewWithIndex:(NSInteger)index andIsLunBoTu:(BOOL)isLunBo {
    
    NSLog(@"%d ---- %d",index,isLunBo);
    
    if (isLunBo) {
        
    }else {
        if (index == 0) {
            
            SWTHeMaiFatherVC * vc =[[SWTHeMaiFatherVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.isHeMai = NO;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 1) {
            SWTZhenPinGeFatherVC * vc =[[SWTZhenPinGeFatherVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 2) {
            SWTVideoFartherVC * vc =[[SWTVideoFartherVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (index == 3) {
            SWTFenLeiFirstVC * vc =[[SWTFenLeiFirstVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    //    return 9;
    return self.recommendArr.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SWTHomeCollectionOneCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.delegateSignal = [[RACSubject alloc] init];
        cell.clipsToBounds = YES;
        @weakify(self);
        //点击今日热门
        [cell.delegateSignal subscribeNext:^(NSNumber * x) {
            @strongify(self);
            SWTModel * neiModel = self.hotArr[x.intValue];
            if ([neiModel.type isEqualToString:@"share"]) {
                SWTHeMaiFatherVC * vc =[[SWTHeMaiFatherVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.isHeMai = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                SWTZhiBoDetailVC * vc =[[SWTZhiBoDetailVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.model = self.hotArr[x.intValue];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
        }];
        cell.dataArray = self.hotArr;
        return cell;
    }else {
        
        SWTModel * model = self.recommendArr[indexPath.row];
        
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
        
        
    }
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SWTModel * model = self.recommendArr[indexPath.row];
    
    if ([model.showtype isEqualToString:@"live"]) {
        SWTZhiBoDetailVC * vc =[[SWTZhiBoDetailVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isHeMai = YES;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.goodID = self.recommendArr[indexPath.row].goodid;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 复用SectionHeaderView,SectionHeaderView是xib创建的
    SWTHomeCollectionHeadView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderView" forIndexPath:indexPath];
    headerView.clipsToBounds = YES;
    if (indexPath.section == 0) {
        headerView.titleLB.text = @"今日热门";
    }else {
       headerView.titleLB.text = @"精品推荐";
    }
    return headerView;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 2;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.hotArr.count == 0) {
            return 0;
        }
        return 160;
    }else {
        
        CGFloat imgH  =   (ScreenW - 30)/2 * 3/4;
        SWTModel * model = self.recommendArr[indexPath.row];
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

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout referenceHeightForHeaderInSection:(NSInteger)section {
    return 40.0;
 
    
}





- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    CGFloat HH = 130 ;
    
    
   CGFloat yy = -(sstatusHeight + 44 + 10 + (ScreenW) / 345 * 150 +110 + 88*2);
    
    CGFloat offsetY = point.y;
    
    NSLog(@"\n===%lf",offsetY);
    
    CGFloat alpha = (offsetY - yy) / 44 > 1.0f ? 1 : ((offsetY-yy)/ 44);
    
    if (point.y <= yy) {
        
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //去掉透明后导航栏下边的黑边
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }else  {
        
        UIImage * img = [PublicFuntionTool  imageWithColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1"]] colorWithAlphaComponent:alpha]];
        
        [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
    }
    
}

//点击录播图

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    if (self.bannerArr[index].merchid.length == 0) {
        return;
    }
    
    SWTShopHomeVC * vc =[[SWTShopHomeVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.shopId = self.bannerArr[index].merchid;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}




@end
