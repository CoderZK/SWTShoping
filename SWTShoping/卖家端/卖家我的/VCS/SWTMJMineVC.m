//
//  SWTMJMineVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineVC.h"
#import "SWTMJMineOneCell.h"
#import "SWTMJMineTwoCell.h"
#import "SWTMJMineThreeCell.h"
#import "SWTShopSettingTVC.h"
#import "SWTMJMineZhengRenMessage.h"
#import "SWTMJMineMoneyVC.h"
#import "SWTMJMineOrderFatherVC.h"
#import "SWTMJMineJingPaiFatherVC.h"
#import "SWTMJMineBaoBiaoVC.h"
#import "SWTMJMineVideoFatherVC.h"
#import "SWTMJMineChanPinKuOneVC.h"
#import "SWTMJMineChanPinKuTwoTVC.h"
#import "SWTMJAddYouHuiQuanTVC.h"
#import "SWTMJHomeVC.h"
#import "SWTMJZhiBoHomeTVC.h"
#import "SWTMJShenQingZhiBoVC.h"
@interface SWTMJMineVC ()<UITabBarControllerDelegate>
@property(nonatomic , strong)NSArray *leftArr;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic,assign)BOOL isOpenChanPinKu;
@property(nonatomic , strong)NSString *jingPaiNumebr;
@end

@implementation SWTMJMineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
    [self merchCheckOpen];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"卖家中心";
    self.leftArr = @[@"总资产",@"拍品管理",@"产品库",@"优惠券",@"直播",@"视频"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMineOneCell" bundle:nil] forCellReuseIdentifier:@"SWTMJMineOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMineThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTMJMineThreeCell"];
    [self.tableView registerClass:[SWTMJMineTwoCell class] forCellReuseIdentifier:@"SWTMJMineTwoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setLeftNagate];
    
    [self getData];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
   
    self.tabBarController.delegate = self;
    [self tongjiAction];
}

- (void)setLeftNagate {
    
    UIButton * leftBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    @weakify(self);
    [[leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
        [LTSCEventBus sendEvent:@"diss" data:nil];
    }];
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchGet_merchinfo_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.dataModel.merchinfo.merch_id = [zkSignleTool shareTool].selectShopID;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

//获取是否开启产品库
- (void)merchCheckOpen {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchCheck_open_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            NSString * status =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"status"]];
            if ([status isEqualToString:@"1"]) {
                self.isOpenChanPinKu = NO;
            }else {
                self.isOpenChanPinKu = YES;
            }
            
            
        }else {
            //            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)getJingPaiNumber  {
  
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchCheck_open_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.jingPaiNumebr = responseObject[@"data"][@"num"];
            [self.tableView reloadData];
            
            
        }else {
            //            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return self.leftArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 100;
        }
        return 95;
    }
    if  (indexPath.row == 4) {
        if (self.dataModel.merchinfo.islive) {
            return 50;
        }else {
            return 0;
        }
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if(indexPath.row == 0) {
            SWTMJMineOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMJMineOneCell" forIndexPath:indexPath];
            cell.delegateSignal = [[RACSubject alloc] init];
            @weakify(self);
            [cell.delegateSignal subscribeNext:^(NSNumber * x) {
                @strongify(self);
                if (x.intValue == 100) {
                    //点击是编辑
                    SWTMJMineZhengRenMessage * vc =[[SWTMJMineZhengRenMessage alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.dataModel = self.dataModel.merchinfo;
                    Weak(weakSelf);
                    vc.upshopMessageBlock = ^(SWTModel * _Nonnull model) {
                        weakSelf.dataModel.merchinfo = model;
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (x.intValue== 101) {
                    //点击的是设置
                    SWTShopSettingTVC * vc =[[SWTShopSettingTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.dataModel = self.dataModel.merchinfo;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
                
            }];
            cell.model = self.dataModel.merchinfo;
            cell.clipsToBounds = YES;
            return cell;
        }else {
            SWTMJMineTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMJMineTwoCell" forIndexPath:indexPath];
            Weak(weakSelf);
            cell.mineTwoCellBlock = ^(NSInteger index) {
                if (index == 5) {
                    //点击店铺报表
                    SWTMJMineBaoBiaoVC * vc =[[SWTMJMineBaoBiaoVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    
                    SWTMJMineOrderFatherVC * vc =[[SWTMJMineOrderFatherVC alloc] init];
                    vc.selectIndex = index;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
            };
            cell.clipsToBounds = YES;
            return cell;
        }
    }else {
        SWTMJMineThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMJMineThreeCell" forIndexPath:indexPath];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.leftImgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"bbdyx%d",11+indexPath.row]];
        if (indexPath.row == 0) {
            cell.rightLB.text =  [NSString stringWithFormat:@"%0.2f元",self.dataModel.credit.floatValue];
        }else if (indexPath.row == 1) {
            cell.rightLB.text =  [NSString stringWithFormat:@"竞拍中%d单",self.jingPaiNumebr.intValue];
        }else {
            cell.rightLB.text = @"";
        }
        cell.clipsToBounds = YES;
        return cell;
    }
    
}

- (void)tongjiAction {

    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchauctionCount_auction_goods_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.jingPaiNumebr =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"num"]];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            //总资产
            SWTMJMineMoneyVC * vc =[[SWTMJMineMoneyVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.money = self.dataModel.credit;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            SWTMJMineJingPaiFatherVC * vc =[[SWTMJMineJingPaiFatherVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = self.dataModel.merchinfo;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            if (self.isOpenChanPinKu) {
                SWTMJMineChanPinKuTwoTVC * vc =[[SWTMJMineChanPinKuTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.member_id = self.dataModel.merchinfo.merch_id;
                vc.avatar = self.dataModel.merchinfo.avatar;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                SWTMJMineChanPinKuOneVC * vc =[[SWTMJMineChanPinKuOneVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else if (indexPath.row == 3) {
            SWTMJAddYouHuiQuanTVC * vc =[[SWTMJAddYouHuiQuanTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            vc.merch_id = self.dataModel.merchinfo.merch_id;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 4) {
            
//            SWTMJShenQingZhiBoVC * vc =[[SWTMJShenQingZhiBoVC alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
            
            if (self.dataModel.merchinfo.islive) {
                //可以直播,检查直播间状态
                [self checkRoom];
                
            }else {
                //不可以直播,去生情
                SWTMJShenQingZhiBoVC * vc =[[SWTMJShenQingZhiBoVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
            
        }else if (indexPath.row == 5) {
            SWTMJMineVideoFatherVC * vc =[[SWTMJMineVideoFatherVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}

- (void)checkRoom  {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchliveCheck_room_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            NSString * status = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"status"]];
            if (status.intValue == 1) {
                SWTMJShenQingZhiBoVC * vc =[[SWTMJShenQingZhiBoVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else if (status.intValue == 2) {
                [SVProgressHUD showErrorWithStatus:@"直播间等待审核中"];
            }else if (status.intValue == 3) {
               SWTMJZhiBoHomeTVC * vc =[[SWTMJZhiBoHomeTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else if (status.intValue == 4) {
                [SVProgressHUD showErrorWithStatus:@"直播间被禁用"];
            }
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    BaseNavigationController * navc = (BaseNavigationController *)viewController;
    
    if ([navc.childViewControllers[0] isKindOfClass:[SWTMJHomeVC class]]) {
        [LTSCEventBus sendEvent:@"diss" data:nil];
        [self dismissViewControllerAnimated:NO completion:nil];
        return NO;
    }
    return YES;
}

- (void)setDingJinAction {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchUpd_merchinfo_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
