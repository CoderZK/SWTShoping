//
//  SWTGoodsDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailTVC.h"
#import "SWTGoodsDetailHeadV.h"
#import "SWTGoodsDetailTableViewContentCollCell.h"
#import "SWTGoodsDetailTwoCell.h"
#import "SWTGoodsDetailThreeCell.h"
#import "SWTGoodsDetailFourCell.h"
#import "SWTGoodsDetailFiveCell.h"
#import "SWTGoodSDetailBottomView.h"
#import "SWTGoodsDetailChuJiaView.h"
#import "SWTGouMaiShowView.h"
#import "SWTTiJiaoOrderTVC.h"
#import "SWTVideoDetailOneCell.h"
#import "SWTGouMaiShowView.h"
#import "SWTYiKouJiaGoodDetailCell.h"
@interface SWTGoodsDetailTVC ()
@property(nonatomic , strong)SWTNavitageView *naView;
@property(nonatomic , strong)SWTGoodsDetailHeadV *headV;
@property(nonatomic , strong)SWTGoodSDetailBottomView  *bottomView;
@property(nonatomic , strong)SWTGoodsDetailChuJiaView *chuJiaView;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , strong)NSString *bayNumber;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTGoodsDetailTVC
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
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BackgroundColor;
    
    [self setNav];
    [self addHeadV];
    [self initBottomV];
    
    [self.tableView registerClass:[SWTGoodsDetailTableViewContentCollCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTGoodsDetailTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTGoodsDetailThreeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailFiveCell" bundle:nil] forCellReuseIdentifier:@"SWTGoodsDetailFiveCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTYiKouJiaGoodDetailCell" bundle:nil] forCellReuseIdentifier:@"SWTYiKouJiaGoodDetailCell"];
    [self.tableView registerClass:[SWTGoodsDetailFourCell class] forCellReuseIdentifier:@"SWTGoodsDetailFourCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 40;
    

   
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getJingXuanData];
       
    }];

    
}


- (void)addHeadV {
    self.headV  = [[SWTGoodsDetailHeadV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.headV.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headV;
 
    
}

- (void)setNav {
    
    self.naView = [[SWTNavitageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 115 + sstatusHeight + 44)];
    
    @weakify(self);
    [[self.naView.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.naView.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
       }];
    [self.view addSubview:self.naView];
    
    [self.view bringSubviewToFront:self.tableView];
}

- (void)initBottomV {
    
    self.bottomView = [[SWTGoodSDetailBottomView alloc] init];
    [self.view addSubview:self.bottomView];
    
    self.bottomView.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [self.bottomView.delegateSignal subscribeNext:^(NSNumber *x) {
        @strongify(self);
        //点击出价店铺私信等
        
        if (x.intValue == 100) {
            //点击店铺
            
        }else if (x.intValue == 101) {
            
            //点击私信
        }else if (x.intValue == 102) {
            if (self.isYiKouJia) {
                SWTGouMaiShowView * gouMaiV  = [[SWTGouMaiShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                gouMaiV.model = self.dataModel;
                gouMaiV.delegateSignal = [[RACSubject alloc] init];
                @weakify(self);
                [gouMaiV.delegateSignal subscribeNext:^(NSString * x) {
                    @strongify(self);
                   //点击购买
                  SWTTiJiaoOrderTVC * vc =[[SWTTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                  vc.hidesBottomBarWhenPushed = YES;
//                    vc.moneyStr =  [NSString stringWithFormat:@"%0.2f",x.intValue * self.dataModel.price.floatValue];
                    vc.numStr = x;
                    vc.goodID = self.goodID;
                    vc.merchID = self.dataModel.merch_id;
                    vc.model = self.dataModel;
                  [self.navigationController pushViewController:vc animated:YES];
                    
                }];
                [gouMaiV show];
            }else {
                //点击出价
                self.chuJiaView  = [[SWTGoodsDetailChuJiaView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                [self.chuJiaView show];
            }
            
        }
        
        
    }];
    
    if (self.isYiKouJia) {
        [self.bottomView.chujiaBt setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (sstatusHeight > 20) {
           make.bottom.equalTo(self.view).offset(-(34));
        }else {
           make.bottom.equalTo(self.view);
        }
        make.height.equalTo(@60);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(sstatusHeight + 44);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];

    
}

- (void)getData {
    
    [SVProgressHUD show];
       NSMutableDictionary * dict = @{}.mutableCopy;
       dict[@"tag"] = self.dataModel.tag;
    [zkRequestTool networkingPOST:goodDetail_SWT parameters:self.goodID success:^(NSURLSessionDataTask *task, id responseObject) {
           
           [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
           if ([responseObject[@"code"] intValue]== 200) {
               self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
               self.dataModel.merch_id = self.dataModel.merchid;
               [self.headV.imgV sd_setImageWithURL:[self.dataModel.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
               if ([self.dataModel.type isEqualToString:@"0"]) {
                   self.isYiKouJia = YES;
               }else {
                   self.isYiKouJia = NO;
               }
               [self.tableView reloadData];
               
               [self getJingXuanData];
               
           }else {
               [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
           }
           
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           
           [self.tableView.mj_header endRefreshing];;
           
       }];
}


- (void)getJingXuanData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pagesize"] = @(10);
    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",goodMerchants_SWT,self.dataModel.merchid] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isYiKouJia) {
        return 3;
    }
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isYiKouJia) {
        if (indexPath.section == 0) {
            return 70;
        }else {
        return UITableViewAutomaticDimension;
        }
    }
    
    if (indexPath.section == 2) {
        return 30 + 40*3;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (self.isYiKouJia){
        if (section == 2 || section == 1) {
            return 0.01;
        }
        return 10;
    }else {
        if (section == 4) {
            return 0.01;
        }
        return 10;
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [tableView dequeueReusableCellWithIdentifier:@"head"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.backgroundColor = BackgroundColor;
    }
    return view;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isYiKouJia) {
        if (indexPath.section == 0) {
            
            SWTYiKouJiaGoodDetailCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTYiKouJiaGoodDetailCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.dataModel;
            cell.collectBt.tag = 100;
            [cell.collectBt addTarget:self action:@selector(collection:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else if (indexPath.section == 1) {
            SWTGoodsDetailFiveCell  *cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailFiveCell" forIndexPath:indexPath];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.dataModel;
            [cell.gaunzhuBt addTarget:self action:@selector(gaunZhuAction) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else {
            SWTGoodsDetailTableViewContentCollCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.dataArray = self.dataArray;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegateSignal = [[RACSubject alloc] init];
            @weakify(self);
            [cell.delegateSignal subscribeNext:^(NSString * x) {
                @strongify(self);
                
                SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.isYiKouJia = YES;
                vc.goodID = x;
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            return cell;
        }
    }else {
        if (indexPath.section == 0) {
            
            SWTGoodsDetailTwoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailTwoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.dataModel;
            cell.delegateSignal = [[RACSubject alloc] init];
            @weakify(self);
            [self.bottomView.delegateSignal subscribeNext:^(NSNumber * x) {
                @strongify(self);
                
                NSLog(@"%@",x);
                
            }];
            return cell;
            
        }else if (indexPath.section == 1) {
            SWTGoodsDetailThreeCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailThreeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.clipsToBounds = YES;
            return cell;
        }else if (indexPath.section == 2) {
            SWTGoodsDetailFourCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailFourCell" forIndexPath:indexPath];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.section == 3) {
            SWTGoodsDetailFiveCell  *cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailFiveCell" forIndexPath:indexPath];
            cell.clipsToBounds = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.dataModel;
            [cell.gaunzhuBt addTarget:self action:@selector(gaunZhuAction) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else {
            SWTGoodsDetailTableViewContentCollCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.dataArray = self.dataArray;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegateSignal = [[RACSubject alloc] init];
            @weakify(self);
            [cell.delegateSignal subscribeNext:^(NSString * x) {
                @strongify(self);
                
                SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                vc.isYiKouJia = YES;
                vc.goodID = x;
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            return cell;
        }
    }
    
    

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y<= 0) {
        
        self.naView.imgV.mj_h = sstatusHeight + 44 +115 - (scrollView.contentOffset.y);
    }else if (scrollView.contentOffset.y<= 115) {
        self.naView.imgV.mj_h = sstatusHeight +  44 +115 - (scrollView.contentOffset.y );
    }else {
        self.naView.imgV.mj_h = sstatusHeight + 44;
    }
    
 

}

//收藏操作
- (void)collection:(UIButton *)button {
 
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"favid"] = @"-1";
    dict[@"id"] = self.goodID;
    dict[@"type"] = @"0";
    dict[@"operation"] = [self.dataModel.isfav isEqualToString:@"no"] ? @"ADD":@"DELETE";
    dict[@"userid"] =[zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:userFavOperate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
       
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if ([self.dataModel.isfav isEqualToString:@"no"]) {
                [SVProgressHUD showSuccessWithStatus:@"收藏商品成功"];
                self.dataModel.isfav = @"yes";
            }else {
                [SVProgressHUD showSuccessWithStatus:@"取消收藏商品成功"];
                self.dataModel.isfav = @"no";
            }
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];

    
    
    
}

//关注操作
- (void)gaunZhuAction {
 
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"followid"] = @"-1";
    dict[@"id"] = self.dataModel.merch_id;
    dict[@"type"] = @"1";
    dict[@"operation"] = [self.dataModel.isfollow isEqualToString:@"no"] ? @"ADD":@"DELETE";
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
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];

    
    
    
}


@end
