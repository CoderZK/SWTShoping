//
//  MineVC.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "MineVC.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "SWTHomeCollectionTwoCell.h"
#import "SWTHomeCollectionThreeCell.h"
#import "SWTMineTwoCell.h"
#import "SWTMineOneCell.h"
#import "SWTMineThreeCell.h"
#import "SWTMineSectionHeadView.h"
#import "SWTShopHomeVC.h"
#import "SWTMineCollectVC.h"
#import "SWTLaoYouHomeTVC.h"
#import "SWTCanPaiFarterVC.h"
#import "SWTMineWalletTVC.h"
#import "SWTMineYouHuiQuanTVC.h"
#import "SWTHelpOneTVC.h"
#import "GuanZhuVC.h"
#import "SWTMineOrderFartherVC.h"
#import "SWTMinePingLunListTVC.h"
#import "SWTSendMinePingLunTVC.h"
#import "SWTLoginOneVC.h"
#import "SWTMineZiLiaoVC.h"
@interface MineVC ()<XPCollectionViewWaterfallFlowLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic , strong)UIImageView *imagV;

@end

@implementation MineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (!ISLOGIN) {
        [self gotoLoginVC];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNav];
    
    self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.layout.dataSource = self;
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44, ScreenW, ScreenH - sstatusHeight-44) collectionViewLayout:self.layout];;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[SWTMineTwoCell class] forCellWithReuseIdentifier:@"SWTMineTwoCell"];
    [self.collectionView registerClass:[SWTMineThreeCell class] forCellWithReuseIdentifier:@"SWTMineThreeCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionTwoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTMineOneCell" bundle:nil] forCellWithReuseIdentifier:@"SWTMineOneCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionThreeCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell"];
    
    [self.collectionView registerClass:[SWTMineSectionHeadView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderView"];
    
    [self.view addSubview:self.collectionView];
    
    
    [self getData];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
    }];
    
    
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:userDetail_SWT parameters:[zkSignleTool shareTool].session_uid success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [zkSignleTool shareTool].nickname = responseObject[@"data"][@"nickname"];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}

- (void)setNav {
    
    UIImageView * vv = [[UIImageView alloc]  initWithFrame:CGRectMake(0, 0, ScreenW, 110 + sstatusHeight + 44)];
    vv.image = [UIImage  imageNamed:@"minebg"];
    self.imagV = vv;
    [self.view addSubview:vv];
    self.view.backgroundColor =  BackgroundColor;
    
    
    UILabel * titelLB  = [[UILabel alloc]  initWithFrame:CGRectMake(20, sstatusHeight, ScreenW - 40, 44)];
    titelLB.font = kFont(18);
    titelLB.textAlignment = NSTextAlignmentCenter;
    titelLB.text = @"我的";
    titelLB.textColor = WhiteColor;
    [self.view addSubview:titelLB];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"---\n%f",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y<= 0) {
        self.imagV.mj_h = sstatusHeight + 44 +110 - scrollView.contentOffset.y;
    }else if (scrollView.contentOffset.y<= 110) {
        self.imagV.mj_h = sstatusHeight +  44 +110 - scrollView.contentOffset.y;
    }else {
        self.imagV.mj_h = sstatusHeight + 44;
    }
    
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 9;
    //    return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //104 头像 105 编辑 106 问题 107 关注 100 - 103 我的竞拍...
            SWTMineOneCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTMineOneCell" forIndexPath:indexPath];
            Weak(weakSelf);
            cell.mineOneCellBlock = ^(NSInteger index) {
                if (index == 0) {
                    
                    
                    SWTCanPaiFarterVC * vc =[[SWTCanPaiFarterVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                    
                    
                    
                    
                    
                    //                    SWTMinePingLunListTVC * vc =[[SWTMinePingLunListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    //                    vc.hidesBottomBarWhenPushed = YES;
                    //                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 1) {
                    GuanZhuVC * vc =[[GuanZhuVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if (index == 2) {
                    self.tabBarController.selectedIndex = 2;
                }else if (index == 3) {
                    GuanZhuVC * vc =[[GuanZhuVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.isMineZuJi = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 4) {
                    
                }else if (index == 5) {
                    SWTMineZiLiaoVC * vc =[[SWTMineZiLiaoVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 6) {
                    
                }else if (index == 7) {
                    
                }
            };
            return cell;
        }else if (indexPath.row == 1) {
            SWTMineTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTMineTwoCell" forIndexPath:indexPath];
            Weak(weakSelf);
            cell.mineTwoCellBlock = ^(NSInteger index) {
                SWTMineOrderFartherVC * vc =[[SWTMineOrderFartherVC alloc] init];
                vc.selectIndex = index;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            };
            return cell;
        }else {
            SWTMineThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTMineThreeCell" forIndexPath:indexPath];
            Weak(weakSelf);
            cell.mineThreeCellBlock = ^(NSInteger index) {
                if (index == 0) {
                    SWTMineCollectVC * vc =[[SWTMineCollectVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else if (index == 1) {
                    SWTCanPaiFarterVC * vc =[[SWTCanPaiFarterVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else if (index == 2) {
                    SWTMineWalletTVC * vc =[[SWTMineWalletTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 3) {
                    SWTMineYouHuiQuanTVC * vc =[[SWTMineYouHuiQuanTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 4) {
                    SWTSendMinePingLunTVC* vc =[[SWTSendMinePingLunTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 5) {
                    SWTHelpOneTVC * vc =[[SWTHelpOneTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 6) {
                    SWTHelpOneTVC * vc =[[SWTHelpOneTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.isLianXiUs = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 7) {
                    SWTLaoYouHomeTVC * vc =[[SWTLaoYouHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            return cell;
        }
    }else {
        if (indexPath.row == 0) {
            SWTHomeCollectionTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell" forIndexPath:indexPath];
            return cell;
        }else {
            SWTHomeCollectionThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell" forIndexPath:indexPath];
            return cell;
        }
    }
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return nil;
    }else {
        SWTMineSectionHeadView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderView" forIndexPath:indexPath];
        headerView.titleLB.text = @"您可能喜欢";
        headerView.clipsToBounds = YES;
        return headerView;
    }
    
    
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
        if (indexPath.row == 0) {
            return 200;
        }else if (indexPath.row == 1) {
            return 95;
        }
        return 180;
    }else {
        return 150 + arc4random() % 100;
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
    if (section == 0) {
        return 0;
    }
    return 30.0;
}


@end
