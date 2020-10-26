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
#import "SWTMineCollectFatherVC.h"
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
#import "SWTChengZhangShowView.h"
#import "SWTMineKeFuTVC.h"
#import "SWTMineHeMaiOrderFatherVC.h"
#import "SWTMJTabbarVC.h"
#import "SWTMineFourCell.h"
#import "HangQingVC.h"
@interface MineVC ()<XPCollectionViewWaterfallFlowLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource,zkPickViewDelelgate>
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic , strong)UIImageView *imagV;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *likeArr;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *leverArr;
@property(nonatomic , strong)SWTModel *userDataModel;
@end

@implementation MineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (!ISLOGIN) {
        [self gotoLoginVC];
    }else {
       [self getData];
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTMineFourCell" bundle:nil] forCellWithReuseIdentifier:@"SWTMineFourCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionThreeCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell"];
    
    [self.collectionView registerClass:[SWTMineSectionHeadView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionHeaderView"];
    
    [self.view addSubview:self.collectionView];
    
    
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
    }];
    
    
    if (ISLOGIN) {
        self.likeArr = @[].mutableCopy;
        [self getUserLikeData];
    }
    self.leverArr = @[].mutableCopy;
    [self getVipListData];
    Weak(weakSelf);
    [LTSCEventBus registerEvent:@"diss" block:^(id data) {
        weakSelf.tabBarController.selectedIndex  = 0;
    }];

      
}


- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:userDetail_SWT parameters:[zkSignleTool shareTool].session_uid success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {
            
            if ([responseObject[@"data"] isKindOfClass:[NSString class]] ){
                return;
            }
            if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]] &&  responseObject[@"data"] == nil){
                return;
            }
            [zkSignleTool shareTool].nickname = responseObject[@"data"][@"nickname"];
            NSString * str = [zkSignleTool shareTool].nickname;
            [zkSignleTool shareTool].level =  responseObject[@"data"][@"levelcode"];
            [zkSignleTool shareTool].levelname = responseObject[@"data"][@"levelname"];
            [zkSignleTool shareTool].avatar = responseObject[@"data"][@"headimg"];
            
//            V2TIMUserFullInfo * info = [[V2TIMUserFullInfo alloc] init];
//               NSMutableDictionary * dict  = @{}.mutableCopy;
//               dict[@"nickname"] = [zkSignleTool shareTool].nickname;
//               dict[@"levelname"] = [zkSignleTool shareTool].levelname;
//               dict[@"levelcode"] = [zkSignleTool shareTool].level;
//            NSLog(@"\n nickName ====%@",[dict mj_JSONString]);
//               info.nickName = [dict mj_JSONString];
               
//               [[V2TIMManager sharedInstance] setSelfInfo:info succ:^{
//                  NSLog(@"%@",@"修改逆臣成功");
//               } fail:^(int code, NSString *desc) {
//                    NSLog(@"%@",@"修改逆臣失败");
//               }];
            
            self.userDataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.collectionView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
         [self.collectionView.mj_header endRefreshing];
        
    }];
}


- (void)getVipListData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:levelList_SWT parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.leverArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
         [self.collectionView.mj_header endRefreshing];
        
    }];
}



- (void)getUserLikeData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:userLike_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.likeArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.collectionView reloadData];
            
            
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
    if (self.likeArr.count == 0) {
        return 1;
    }else {
        return 2;
    }
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return self.likeArr.count;
    //    return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //104 头像 105 编辑 106 问题 107 关注 100 - 103 我的竞拍...
            SWTMineOneCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTMineOneCell" forIndexPath:indexPath];
            cell.model = self.userDataModel;
            cell.clipsToBounds = YES;
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
//                    self.tabBarController.selectedIndex = 2;
                    
                    HangQingVC * vc =[[HangQingVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 3) {
                    GuanZhuVC * vc =[[GuanZhuVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.isMineZuJi = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 4) {
                    
                }else if (index == 5) {
                    SWTMineZiLiaoVC * vc =[[SWTMineZiLiaoVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.genderStr = self.userDataModel.gender;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 6) {
                    SWTChengZhangShowView * chengzhangV = [[SWTChengZhangShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                    chengzhangV.leverArr = self.leverArr;
                    [chengzhangV show];
                }else if (index == 7) {
                    
                    
                    SWTZhiBoDetailVC * vc =[[SWTZhiBoDetailVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    self.userDataModel.ID = self.userDataModel.liveid;
                    vc.model = self.userDataModel;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
            };
            return cell;
        }else if (indexPath.row == 1) {
            SWTMineTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTMineTwoCell" forIndexPath:indexPath];
            Weak(weakSelf);
            cell.mineTwoCellBlock = ^(NSInteger index) {
                SWTMineOrderFartherVC * vc =[[SWTMineOrderFartherVC alloc] init];
                vc.selectIndex = index;
                if (index == 5) {
                    vc.selectIndex = 6;
                }
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            };
            return cell;
        }else if (indexPath.row == 2){
            SWTMineThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTMineThreeCell" forIndexPath:indexPath];
            Weak(weakSelf);
            cell.mineThreeCellBlock = ^(NSInteger index) {
                if (index == 0) {
                    SWTMineCollectFatherVC * vc =[[SWTMineCollectFatherVC alloc] init];
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
                    
                    SWTMineHeMaiOrderFatherVC * vc =[[SWTMineHeMaiOrderFatherVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
//                    SWTMineYouHuiQuanTVC * vc =[[SWTMineYouHuiQuanTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
//                    vc.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:vc animated:YES];
                }else if (index == 4) {
                    
                    
                    SWTMineKeFuTVC* vc =[[SWTMineKeFuTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
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
                    
                    
//                    SWTMJTabbarVC * vc =[[SWTMJTabbarVC alloc] init];
//                    [self presentViewController:vc  animated:YES completion:nil];
//                    vc.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            return cell;
        }else  {
             SWTMineFourCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTMineFourCell" forIndexPath:indexPath];
            cell.backgroundColor = WhiteColor;
            return cell;
        }
    }else {
        
        SWTHomeCollectionThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell" forIndexPath:indexPath];
        cell.model = self.likeArr[indexPath.row];
       
        return cell;
        
//        if (indexPath.row == 0) {
//            SWTHomeCollectionTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell" forIndexPath:indexPath];
//            return cell;
//        }else {
//            SWTHomeCollectionThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell" forIndexPath:indexPath];
//            return cell;
//        }
    }
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
           
            NSMutableArray * arr = @[].mutableCopy;
            for (SWTModel * model in self.userDataModel.merchlist) {
                [arr addObject: [NSString stringWithFormat:@"%@-%@",model.store_name,model.type]];
                   }
                   zkPickView * pickV = [[zkPickView alloc] init];
                   pickV.arrayType = titleArray;
                   pickV.array = arr;
                   [pickV show];
                   pickV.delegate = self;
            
            
            
        }
    }else if (indexPath.section == 1) {
        SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.goodID = self.likeArr[indexPath.row].goodid;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
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
            if (self.userDataModel.liveid.length == 0) {
                return 150;
            }
            return 200;
        }else if (indexPath.row == 1) {
            return 95;
        }else if (indexPath.row == 2) {
           return 180;
        }else {
            if (self.userDataModel.merchlist.count == 0) {
                return 0;
            }
            return 50;
        }
        
    }else {
        CGFloat imgH  =   (ScreenW - 30)/2 * 3/4;
        SWTModel * model = self.likeArr[indexPath.row];
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
    if (section == 0) {
        return 0;
    }
    return 30.0;
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {

    SWTMJTabbarVC * vc =[[SWTMJTabbarVC alloc] init];
    vc.selectedIndex = 3;
    [zkSignleTool shareTool].selectShopID = self.userDataModel.merchlist[leftIndex].ID;
    if ([self.userDataModel.merchlist[leftIndex].type isEqualToString:@"合买店铺"]) {
        [zkSignleTool shareTool].isHeMaiDianPu = YES;
    }else {
        [zkSignleTool shareTool].isHeMaiDianPu = NO;
    }
    [self presentViewController:vc  animated:YES completion:nil];

}

@end
