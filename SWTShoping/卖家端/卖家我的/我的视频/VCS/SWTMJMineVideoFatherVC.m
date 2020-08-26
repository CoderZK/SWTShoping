//
//  SWTMJMineVideoFatherVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineVideoFatherVC.h"
#import "SWTMJUploadVideoTVC.h"
#import "SWTMJMineVideSubTVC.h"
@interface SWTMJMineVideoFatherVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>
@property (nonatomic, strong) TYTabPagerBar *tabBar;//顶部菜单栏

@property (nonatomic, weak) TYPagerController *pagerController;
//@property(nonatomic , strong)NSArray *titleArr;
@property(nonatomic , assign)NSInteger  selectIndex;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;


@end

@implementation SWTMJMineVideoFatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频";
    
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    button.titleLabel.font = kFont(13);
    [button setTitle:@"上传" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        
        SWTMJUploadVideoTVC * vc =[[SWTMJUploadVideoTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
   
    
//    self.titleArr = @[@"全部",@"分类1",@"分类2",@"分类3",@"分类4"];
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
//    [self reloadData];
    self.dataArray = @[].mutableCopy;
    [self getData];
    
//    UIButton * backBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//    [backBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
//    [backBt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBt addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBt];
    
}

//- (void)goback:(UIButton *)button {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

//获取去视屏分类
- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchvideoGet_video_cate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
            SWTModel * model = [[SWTModel alloc] init];
            model.name= @"全部";
            [self.dataArray insertObject:model atIndex:0];
            
            [self reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
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
    return self.dataArray.count;
    
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    
    cell.titleLabel.text = self.dataArray[index].name;
    return cell;
    
    
}
#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    //        return (ScreenW - 110)/5;
    return [self.dataArray[index].name getWidhtWithFontSize:15] + 10;
}
- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    self.selectIndex = index;
    [_pagerController scrollToControllerAtIndex:index animate:YES];
    
    
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController {
    
    return self.dataArray.count;
    
    
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    
    SWTMJMineVideSubTVC *vc = [[SWTMJMineVideSubTVC alloc] init];
    vc.type = index;
    vc.ID = self.dataArray[index].ID;
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

