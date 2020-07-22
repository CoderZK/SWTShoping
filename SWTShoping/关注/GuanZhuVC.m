//
//  GuanZhuVC.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "GuanZhuVC.h"
#import "SWTMineAttentionZhiBoVC.h"
#import "SWTMineAttentionShopTVC.h"
#import "SWTMienZuJiSubVC.h"
@interface GuanZhuVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate,UIScrollViewDelegate>



@property (nonatomic, weak) TYPagerController *pagerController;
@property (nonatomic, strong) TYTabPagerBar *tabBar;
@property(nonatomic , assign)NSInteger selectIndex;
@property(nonatomic , strong)NSArray *titleArr;

@end

@implementation GuanZhuVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    self.titleArr = @[@"直播",@"店铺"];
    if (self.isMineZuJi) {
        self.navigationItem.title = @"足迹";
        self.titleArr = @[@"直播",@"商品"];
    }
    self.view.backgroundColor = BackgroundColor;
   
    
    
       [self addTabPageView];
       [self addPagerController];
       
       [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.top.right.equalTo(self.view);
           make.height.equalTo(@40);
       }];
       
       [self.pagerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.tabBar.mas_bottom);
           make.leading.bottom.trailing.equalTo (self.view);
       }];
       [self reloadData];
    
//    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.bottom.equalTo(self.view);
//    }];
    
}


- (void)addTabPageView {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.collectionView.bounces = NO;
    tabBar.contentInset = UIEdgeInsetsMake(0,100, 5, 100);
        tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
    tabBar.layout.normalTextFont = [UIFont systemFontOfSize:15];
    tabBar.layout.normalTextColor = CharacterColor50;
    tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:15];
    tabBar.layout.selectedTextColor = CharacterColor50;
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
    return (ScreenW - 240) / 2.0;
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
    
    
    if (index == 0) {
        SWTMineAttentionZhiBoVC * vc1 = [[SWTMineAttentionZhiBoVC alloc] init];
        vc1.isMineZuJi = self.isMineZuJi;
        return vc1;
    }else {
        if (self.isMineZuJi) {
            SWTMienZuJiSubVC * vc2 = [[SWTMienZuJiSubVC alloc] init];
            return vc2;
        }else {
           SWTMineAttentionShopTVC * vc2 = [[SWTMineAttentionShopTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            return vc2;
        }
    }

    
}

#pragma mark - TYPagerControllerDelegate

- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
    
    self.selectIndex = toIndex;
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex animate:animated];
    
}

-(void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
    
}





@end
