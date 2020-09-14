//
//  SWTShopHomeVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopHomeVC.h"
#import "SWTHomeCollectionOneCell.h"
#import "SWTHomeCollectionTwoCell.h"
#import "SWTHomeCollectionThreeCell.h"
#import "SWTShopHomeHeadView.h"
#import "SWTShopIntroduceTVC.h"
@interface SWTShopHomeVC ()<XPCollectionViewWaterfallFlowLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource>@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic , strong)UICollectionView *collectionView;
//@property(nonatomic , strong)UIImageView *imagV;
@property(nonatomic , strong)SWTNavitageView *naView;
@property(nonatomic , strong)UILabel *titleLB;
@property(nonatomic , strong)SWTShopHomeHeadView *headView;
@property(nonatomic , assign)NSInteger  type;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTShopHomeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self addCollectionV];
    [self addHeadV];
    
    [self getData];
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getTwoData];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getTwoData];
         [self getData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getTwoData];
    }];
    
}

- (void)getTwoData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"id"] = self.shopId;
    dict[@"pagesize"] = @(10);
    dict[@"type"] = @(1-self.type);
    [zkRequestTool networkingPOST: merchMerchgood_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
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


- (void)getData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.shopId;
    [zkRequestTool networkingPOST:merchDetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.dataModel.storename = self.dataModel.store_name;
            [self.collectionView reloadData];
            self.naView.titleLB.text = self.dataModel.store_name;
            self.headView.model = self.dataModel;
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.collectionView.mj_header endRefreshing];;
        
    }];
}



- (void)addCollectionV {
    
    self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.layout.dataSource = self;
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44 , ScreenW, ScreenH - sstatusHeight - 44) collectionViewLayout:self.layout];;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //               self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BackgroundColor;
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[SWTHomeCollectionOneCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionTwoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionThreeCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell"];
    
    
    
    [self.view addSubview:self.collectionView];
    
}

- (void)addHeadV {
    
    CGFloat yy = 115 + 55 + (ScreenW - 30) / 345 * 150 + 50;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(yy  ,0, 0, 0);
    self.headView = [[SWTShopHomeHeadView alloc] initWithFrame:CGRectMake(0, -yy, ScreenW, yy)];
    self.headView.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [self.headView.delegateSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        self.type = x.intValue;
        
        if (x.intValue == 100) {
            SWTShopIntroduceTVC * vc =[[SWTShopIntroduceTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = self.dataModel.ID;
            vc.model = self.dataModel;
            Weak(weakSelf);
            vc.sendDataModelBlock = ^(SWTModel * _Nonnull model) {
                weakSelf.dataModel = model;
                weakSelf.headView.model = model;
            };
            [self.navigationController pushViewController:vc animated:YES];
        }else if (x.intValue == 101) {
            //点击关注
            [self gaunZhuAction];
        }else if (x.intValue == 102) {
            //竞拍
            self.type  = 0;
            self.page = 1;
            [self getTwoData];
            
        }else if (x.intValue == 103) {
            //一口价
            self.type  = 1;
            self.page = 1;
            [self getTwoData];
            
        }
    }];
    [self.collectionView addSubview:self.headView];;
    
}

- (void)setNav {
    
    self.naView = [[SWTNavitageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 115 + sstatusHeight + 44)];
    
    @weakify(self);
    [[self.naView.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.naView.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [SVProgressHUD show];
        TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:self.dataModel.imid];
        TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
        vc.navigationItem.title = self.dataModel.store_name;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view addSubview:self.naView];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SWTModel * model = self.dataArray[indexPath.row];
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





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.goodID = self.dataArray[indexPath.row].goodid;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
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
    return UIEdgeInsetsMake(0, 10.0, 10.0, 10.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}


//关注操作
- (void)gaunZhuAction {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.dataModel.ID;
    dict[@"type"] = @"1";
    dict[@"userid"] =[zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:userFollowOperate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if ([self.dataModel.isfollow isEqualToString:@"no"]) {
                [SVProgressHUD showSuccessWithStatus:@"关注店铺成功"];
                self.dataModel.isfollow = @"yes";
            }else {
                [SVProgressHUD showSuccessWithStatus:@"取消关注店铺"];
                self.dataModel.isfollow = @"no";
            }
            if ([self.dataModel.isfollow isEqualToString:@"yes"]) {
                [self.headView.guanZhuBt setBackgroundImage:[UIImage imageNamed:@"dyx24"] forState:UIControlStateNormal];
            }else {
                [self.headView.guanZhuBt setBackgroundImage:[UIImage imageNamed:@"Focus"] forState:UIControlStateNormal];
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"---\n%f",scrollView.contentOffset.y);
    
    CGFloat yy =  115 + 55 + (ScreenW - 30) / 345 * 150 + 50;
    
    
    if (scrollView.contentOffset.y<= -yy) {
        
        self.naView.imgV.mj_h = sstatusHeight + 44 +115 - (scrollView.contentOffset.y + yy );
    }else if (scrollView.contentOffset.y<= 115-yy) {
        self.naView.imgV.mj_h = sstatusHeight +  44 +115 - (scrollView.contentOffset.y + yy);
    }else {
        self.naView.imgV.mj_h = sstatusHeight + 44;
    }
    
}




@end
