//
//  SWTZhenPinGeFatherVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhenPinGeFatherVC.h"
#import "SWTZhenPinGeSubTVC.h"
@interface SWTZhenPinGeFatherVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>
@property (nonatomic, strong) TYTabPagerBar *tabBar;
@property(nonatomic , strong)SWTNavitageView *naView;
@property(nonatomic , strong)UIView *headV;
@property (nonatomic, weak) TYPagerController *pagerController;
@property(nonatomic , strong)NSArray *titleArr;
@property(nonatomic , assign)NSInteger selectIndex;
@end

@implementation SWTZhenPinGeFatherVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"推荐",@"玉翠珠宝",@"书画篆刻",@"文玩首饰",@"紫砂陶瓷"];
    
    [self setNav];
    
    [self addTabPageView];
    [self addPagerController];
       
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(self.view);
           make.top.equalTo(self.view).offset(sstatusHeight + 44);
           make.height.equalTo(@40);
    }];
       
    [self.pagerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.tabBar.mas_bottom);
           make.leading.bottom.trailing.equalTo (self.view);
       }];
    [self reloadData];
   
}


- (void)setNav {
    
    self.naView = [[SWTNavitageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, sstatusHeight + 44+40)];
    self.naView.rightBt.hidden = YES;
    self.naView.titleLB.text = @"珍品阁";
    [self.view addSubview:self.naView];
    @weakify(self);
       [[self.naView.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
           [self.navigationController popViewControllerAnimated:YES];
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
    tabBar.layout.progressColor = WhiteColor;
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
   
        SWTZhenPinGeSubTVC   *vc = [[SWTZhenPinGeSubTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
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



@end
