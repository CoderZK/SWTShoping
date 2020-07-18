//
//  SWTVideoFartherVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTVideoFartherVC.h"
#import "SWTVideoSubVC.h"
#import "SWTVideoDetailTVC.h"
@interface SWTVideoFartherVC ()<TYTabPagerBarDataSource,TYTabPagerBarDelegate,TYPagerControllerDataSource,TYPagerControllerDelegate>
@property (nonatomic, strong) TYTabPagerBar *tabBar;
@property(nonatomic , strong)SWTNavitageView *naView;
@property(nonatomic , strong)UIView *headV;
@property (nonatomic, weak) TYPagerController *pagerController;
//@property(nonatomic , strong)NSArray *titleArr;
@property(nonatomic , assign)NSInteger selectIndex;
@property(nonatomic , strong)SWTModel *topModel;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;

@property(nonatomic , strong)UIButton *headBt;
@property(nonatomic , strong)UILabel *shopNameLB,*scanLB;
@property(nonatomic , strong)UIImageView *imgV;



@end

@implementation SWTVideoFartherVC

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
    self.view.backgroundColor = BackgroundColor;
    
    [self setNav];
    [self initHeadV];
    
    self.dataArray = @[].mutableCopy;
    
    
    [self addTabPageView];
    [self addPagerController];
    
    [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headV.mas_bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    [self.pagerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBar.mas_bottom);
        make.leading.bottom.trailing.equalTo (self.view);
    }];
    
    
    
}

- (void)setNav {
    
    self.naView = [[SWTNavitageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 115 + sstatusHeight + 44)];
    self.naView.rightBt.hidden = YES;
    self.naView.titleLB.text = @"精品视频";
    @weakify(self);
    [[self.naView.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.naView.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    [self.view addSubview:self.naView];
    
    
    [self getTopData];
    [self getTopTitleData];
    
    
    
}

- (void)getTopTitleData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:videoCategory_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray =[SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)getTopData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:videoTop_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.topModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            [self.headBt sd_setBackgroundImageWithURL:[self.topModel.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            self.shopNameLB.text = self.topModel.nickname;
            self.scanLB.text =  [NSString stringWithFormat:@"%@人正在观看",self.topModel.playnum];
            [self.imgV sd_setImageWithURL:[self.topModel.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        ;
        
    }];
}

- (void)initHeadV {
    
    self.headV = [[UIView alloc] init];
    self.headV.backgroundColor = WhiteColor;
    self.headV.layer.cornerRadius = 5;
    self.headV.clipsToBounds = YES;
    [self.view addSubview:self.headV];
    [self.headV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@170);
        make.top.equalTo(self.view).offset(sstatusHeight + 44);
    }];
    
    UIButton * headBt = [[UIButton alloc] init];;
    headBt.layer.cornerRadius = 15;
    [headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
    headBt.clipsToBounds = YES;
    [self.headV addSubview:headBt];
    self.headBt = headBt;
    [headBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.headV).offset(15);
        make.height.width.equalTo(@30);
    }];
    
    UILabel * nameLB =[[UILabel alloc] init];
    nameLB.font = kFont(14);
    nameLB.textColor = CharacterColor50;
    nameLB.text = @"水御堂大管家简报堵门解密";
    [self.headV addSubview:nameLB];
    self.shopNameLB = nameLB;
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headBt.mas_right).offset(5);
        make.top.equalTo(headBt).offset(-1);
        make.height.equalTo(@17);
        make.right.equalTo(self.headV).offset(-10);
    }];
    
    UILabel * numberLB =[[UILabel alloc] init];
    numberLB.font = kFont(10);
    numberLB.textColor = CharacterColor50;
    numberLB.text = @"1.56万人正在观看";
    [self.headV addSubview:numberLB];
    self.scanLB = numberLB;
    [numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headBt.mas_right).offset(5);
        make.top.equalTo(nameLB.mas_bottom);
        make.height.equalTo(@15);
        make.right.equalTo(self.headV).offset(-10);
    }];
    
    UIImageView * imgV  =[[UIImageView alloc] init];
    imgV.layer.cornerRadius = 5;
    imgV.clipsToBounds = YES;
    imgV.image = [UIImage imageNamed:@"369"];
    [self.headV addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numberLB.mas_bottom).offset(10);
        make.left.equalTo(self.headV).offset(10);
        make.bottom.right.offset(-10);
    }];
    self.imgV = imgV;
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [imgV addGestureRecognizer:tap];
    
    
    
    
    
}


- (void)tapAction {
    
    SWTVideoDetailTVC * vc =[[SWTVideoDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.videoID = self.topModel.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)addTabPageView {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc] init];
    tabBar.backgroundColor = BackgroundColor;
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
    return [self.dataArray[index].name getWidhtWithFontSize:16];
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
    
    SWTVideoSubVC   *vc = [[SWTVideoSubVC alloc] init];
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
    vc.cateID = self.dataArray[index].ID;
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
