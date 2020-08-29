//
//  SWTSearchFatherVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTSearchFatherVC.h"
#import "SWTSeachSubTVC.h"
#import "SWTSearchSubVC.h"
@interface SWTSearchFatherVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate,UITextFieldDelegate>
@property (nonatomic, strong) TYTabPagerBar *tabBar;//顶部菜单栏

@property (nonatomic, weak) TYPagerController *pagerController;
@property(nonatomic , strong)NSArray *titleArr;
@property(nonatomic , assign)NSInteger  selectIndex;
@property(nonatomic , strong)ALCSearchView *searchTitleView;

@end

@implementation SWTSearchFatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"拍品",@"店铺",@"直播"];
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
    
    UIButton * backBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [backBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    [backBt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [backBt addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBt];
    
    [self initHeadV];
    
}

- (void)initHeadV {
    
    self.searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(50, 0, ScreenW - 100, 35)];
    self.searchTitleView.searchTF.delegate = self;
    
    self.searchTitleView.isPush = NO;
    self.searchTitleView.isBlack = YES;
    self.searchTitleView.searchTF.placeholder = @"请输入内容";
    
    
    @weakify(self);

    [[self.searchTitleView.searchTF rac_newTextChannel] subscribeNext:^(NSString * _Nullable x) {
         [LTSCEventBus sendEvent:@"search" data:x];
    }];
    self.navigationItem.titleView = self.searchTitleView;
    
}

- (void)goback:(UIButton *)button {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)addTabPageView {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.collectionView.bounces = NO;
    tabBar.contentInset = UIEdgeInsetsMake(0, 15, 5, 15);
    //    tabBar.layout.barStyle = TYPagerBarStyleProgressElasticView;
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
    
    [_pagerController scrollToControllerAtIndex:self.selectIndex animate:YES];
    
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
    return (ScreenW - 70)/3.0;
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
    
    if (index == 0 || index == 2) {
        SWTSearchSubVC * vc = [[SWTSearchSubVC alloc] init];
        vc.type = index;
        return vc;
    }else {
        SWTSeachSubTVC * tvc = [[SWTSeachSubTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        return tvc;
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
