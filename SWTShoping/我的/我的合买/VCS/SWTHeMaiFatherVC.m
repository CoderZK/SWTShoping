//
//  SWTHeMaiFatherVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaiFatherVC.h"
#import "SWTHeMaiSubVC.h"
@interface SWTHeMaiFatherVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>
@property (nonatomic, strong) TYTabPagerBar *tabBar;
@property(nonatomic , strong)SWTNavitageView *naView;
@property(nonatomic , strong)UIView *headV;
@property (nonatomic, weak) TYPagerController *pagerController;
@property(nonatomic , strong)NSMutableArray *titleArr;
@property(nonatomic , assign)NSInteger selectIndex;
@property(nonatomic , strong)NSArray<SWTModel *> *dataArray;




@end

@implementation SWTHeMaiFatherVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];

    self.titleArr = @[@"关注",@"热门"].mutableCopy;
    [self addTabPageView];
    [self addPagerController];
    
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(sstatusHeight+44);
        make.height.equalTo(@40);
    }];
    
    [self.pagerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBar.mas_bottom);
        make.leading.bottom.trailing.equalTo (self.view);
    }];
   

    [self getTopTitleData];
    
    
}


- (void)getTopTitleData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    NSString * url = liveTopcategory_SWT;
    if (self.isHeMai) {
        url = shareTopcategory_SWT;
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray  =[SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            for (SWTModel * nn  in self.dataArray) {
                [self.titleArr addObject:nn.name];
            }
            [self reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)addTabPageView {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc] init];
    tabBar.backgroundColor = [UIColor clearColor];
    tabBar.collectionView.bounces = NO;
    tabBar.contentInset = UIEdgeInsetsMake(0, 15, 5, 15);
    //    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.layout.normalTextFont = [UIFont systemFontOfSize:15];
    tabBar.layout.normalTextColor = WhiteColor;
    tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:15];
    tabBar.layout.selectedTextColor = WhiteColor;
    tabBar.layout.progressColor = RedColor;
    tabBar.layout.cellSpacing = 20;
    tabBar.dataSource = self;
    tabBar.delegate = self;
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    
    //    self.tabBar = [[TYTabPagerBar alloc] init];
    //    self.tabBar.backgroundColor = UIColor.yellowColor;
    //    self.tabBar.delegate = self;
    //    self.tabBar.dataSource = self;
    //    self.tabBar.layout.adjustContentCellsCenter = YES;
    //    self.tabBar.layout.progressColor = RedColor;
    //    self.tabBar.layout.textColorProgressEnable = NO;
    //    self.tabBar.layout.selectedTextColor = UIColor.blackColor;
    //    self.tabBar.layout.normalTextColor = CharacterColor50;
    //    self.tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:15];
    //    self.tabBar.layout.normalTextFont = [UIFont systemFontOfSize:15];
    //    self.tabBar.layout.progressVerEdging = 10;
    //    self.tabBar.layout.progressHeight = 3;
    //    self.tabBar.layout.progressWidth = 35;
    //    self.tabBar.layout.cellWidth = floor(ScreenW/5.0);
    //    self.tabBar.layout.cellSpacing = 0;
    //    [self.tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    //
    [self.view addSubview:tabBar];
    self.tabBar = tabBar;
}

- (void)addPagerController {
    TYPagerController *pagerController = [[TYPagerController alloc] init];
    pagerController.view.backgroundColor = CharacterColor50;
    pagerController.layout.prefetchItemCount = 1;
    //pagerController.layout.autoMemoryCache = NO;
    // 只有当scroll滚动动画停止时才加载pagerview，用于优化滚动时性能
    pagerController.layout.addVisibleItemOnlyWhenScrollAnimatedEnd = YES;
    pagerController.dataSource = self;
    pagerController.delegate = self;
    [self addChildViewController:pagerController];
    [self.view addSubview:pagerController.view];
    _pagerController = pagerController;
}

- (void)reloadData {
    [_tabBar reloadData];
    [_pagerController reloadData];
}

- (NSInteger)numberOfItemsInPagerTabBar {
    return self.titleArr.count;
    
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.titleArr[index];
    return cell;
    
    
}
#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    return [self.titleArr[index] getWidhtWithFontSize:15];
}
- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    
    self.selectIndex = index;
    [_pagerController scrollToControllerAtIndex:index animate:YES];
    
    
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController {
    
    return self.titleArr.count;
    
    
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    
    SWTHeMaiSubVC *vc = [[SWTHeMaiSubVC alloc] init];
    //        LTSCCateModel *model = [LTSCCateModel new];
    //        if (index == 0) {
    //            model.pid = self.cateModel.pid;
    //        }else {
    //            model = self.secondCateArr[index - 1];
    //        }
    //        vc.type = self.type;
    //        vc.shopId = self.shopId;
    //        vc.cateModel = model;
    vc.type = index;
    vc.isHeMai = self.isHeMai;
    if (index>=2) {
        vc.pidId = self.dataArray[index - 2].ID;
    }
    return vc;
    
}

#pragma mark - TYPagerControllerDelegate

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    
    self.selectIndex = toIndex;
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
    
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
    
}

- (void)setNav {
    
    self.naView = [[SWTNavitageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 115 + sstatusHeight + 44)];
    self.naView.rightBt.hidden = YES;
    self.naView.titleLB.text = @"直播";
    if (self.isHeMai) {
       self.naView.titleLB.text = @"合买定制";
    }
    @weakify(self);
    [[self.naView.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
//    [[self.naView.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:@"17"];
//        TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
    [self.view addSubview:self.naView];

}


@end
