//
//  SWTTiJiaoOrderTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTiJiaoOrderTVC.h"
#import "SWTLaoYouOneCell.h"
#import "SWTTongYongOneCell.h"
#import "SWTChooseAddcell.h"
#import "SWTMineAddressTVC.h"
#import "SWTPayVC.h"
@interface SWTTiJiaoOrderTVC ()
@property(nonatomic , strong)NSArray *arrOne;
@property(nonatomic , strong)NSArray *arrTwo;
@property(nonatomic , strong)UIView *bottomView;
@property(nonatomic , strong)UILabel *numberLB,*moneyLB;
@property(nonatomic , strong)UIButton *tijiaoBt;
@property(nonatomic , strong)NSString *timeStr;
@property(nonatomic , strong)SWTModel *addressModel;
@property(nonatomic , assign)CGFloat zheKouMoney;
@property(nonatomic , strong)NSString *zheKouID;
@end

@implementation SWTTiJiaoOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat allMoney = self.model.price.floatValue * self.numStr.intValue;
    for (int i = 0 ; i < self.model.youHuiQuanList.count; i++) {
        if (allMoney >= self.model.youHuiQuanList[i].useprice.floatValue) {
            self.zheKouMoney = allMoney * (100-self.model.youHuiQuanList[i].rate.floatValue)/100.0;
            self.zheKouID = self.model.youHuiQuanList[i].ID;
            break;
        }
        
    }
    
    self.navigationItem.title = @"提交订单";
    [self.tableView registerClass:[SWTLaoYouOneCell class] forCellReuseIdentifier:@"SWTLaoYouOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTongYongOneCell" bundle:nil] forCellReuseIdentifier:@"SWTTongYongOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTChooseAddcell" bundle:nil] forCellReuseIdentifier:@"SWTChooseAddcell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.arrOne = @[@"发货保障",@"退货无忧",@"配送方式",@"商铺优惠券",@""];
    self.arrTwo = @[@"72小时不发货可申请退款",@"7天包退",@"卖家包邮",@"商铺优惠券",@""];
    [self initBview];
    
    
    [self getData];
   
   
    
}


- (void)initBview {
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = WhiteColor;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@50);
        if (sstatusHeight > 20) {
            make.bottom.equalTo(self.view).offset(-34);
        }else {
            make.bottom.equalTo(self.view);
        }
        
        
    }];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.5)];
    backV.backgroundColor = lineBackColor;
    [self.bottomView  addSubview:backV];
    
    self.tijiaoBt = [[UIButton alloc] init];;
    self.tijiaoBt.layer.cornerRadius = 12.5;
    self.tijiaoBt.clipsToBounds = YES;
    [self.tijiaoBt setTitle:@"提交订单" forState:UIControlStateNormal];
    self.tijiaoBt.titleLabel.font = kFont(14);
    [self.tijiaoBt setBackgroundImage:[UIImage imageNamed:@"shop_submit"] forState:UIControlStateNormal];
    @weakify(self);
    [[self.tijiaoBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //点击提交订单
        
        [self addOrderAction];
        
    }];
    
    
    [self.bottomView addSubview: self.tijiaoBt];
    [self.tijiaoBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView).offset(-20);
        make.width.equalTo(@80);
        make.height.equalTo(@25);
    }];
    
    self.moneyLB = [[UILabel alloc] init];
    self.moneyLB.textColor = RedColor;
    self.moneyLB.font = kFont(13);
    [self.bottomView addSubview:self.moneyLB];
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%0.2f",self.model.price.floatValue * self.numStr.intValue - self.zheKouMoney];
    
    self.numberLB = [[UILabel alloc] init];
    self.numberLB.textColor = CharacterColor50;
    self.numberLB.font = kFont(13);
    [self.bottomView addSubview:self.numberLB];
    self.numberLB.text =  [NSString stringWithFormat:@"共%@件, 合计: ",self.numStr];
    
    [self.moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.tijiaoBt.mas_left).offset(-20);
        make.height.equalTo(@25);
    }];
    
    [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.right.equalTo(self.moneyLB.mas_left).offset(-5);
        make.height.equalTo(@25);
    }];
    
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(1);
    dict[@"pagesize"] = @(2);
    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",addressList_SWT,[zkSignleTool shareTool].session_uid] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (arr.count > 0) {
                if (arr[0].is_default) {
                    self.addressModel = arr[0];
                    [self.tableView reloadData];
                }
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}



- (void)addOrderAction {
    
    if (self.addressModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择收货地址"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"goodid"] = self.goodID;
    dict[@"merchid"] = self.merchID;
    dict[@"num"] = self.numStr;
    dict[@"price"] =  [NSString stringWithFormat:@"%0.2f",self.model.price.doubleValue * self.numStr.doubleValue - self.zheKouMoney];;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"merchid"] = self.merchID;
    dict[@"goodid"] = self.goodID;
    dict[@"couponid"] = self.zheKouID;
    dict[@"addressid"] = self.addressModel.ID;
    [zkRequestTool networkingPOST: orderSubmit_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
//            [SVProgressHUD showSuccessWithStatus:@"提交订单成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
            
            SWTPayVC * vc =[[SWTPayVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.orderID = responseObject[@"data"];
            vc.priceStr = [NSString stringWithFormat:@"%0.2f",self.model.price.doubleValue * self.numStr.doubleValue - self.zheKouMoney];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 401) {
            // 优惠券失效
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            self.zheKouMoney = 0;
            self.zheKouID = nil;
            self.moneyLB.text =  [NSString stringWithFormat:@"￥%0.2f",self.model.price.floatValue * self.numStr.intValue - self.zheKouMoney];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0 ) {
        return 2;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 79;
        }
        return 132;
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SWTChooseAddcell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTChooseAddcell" forIndexPath:indexPath];
            cell.model = self.addressModel;
    
            return cell;
        }else {
            SWTLaoYouOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouOneCell" forIndexPath:indexPath];
            cell.model = self.model;
            cell.leftTwoLb.text = self.timeStr;
            cell.rightImgV.hidden = YES;
            [cell.leftimgV sd_setImageWithURL:[self.model.goodimg getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            return cell;
        }
        
    }else {
        SWTTongYongOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTongYongOneCell" forIndexPath:indexPath];
        cell.leftTwoLB.hidden = YES;
        cell.leftLB.text = self.arrOne[indexPath.row];
        if (indexPath.row == 4) {
            cell.rightTwoLB.text  =  [NSString stringWithFormat:@"￥%@",[self.model.price getPriceAllStr]];;
            cell.rightLB.text = @"小计:  ";
        }else if (indexPath.row == 3) {
            cell.rightLB.text = @"";
            cell.leftLB.text = self.arrOne[indexPath.row];
            cell.rightTwoLB.text  =  [NSString stringWithFormat:@"-￥%0.2f",self.zheKouMoney];
        }else {
            cell.rightLB.text = self.arrTwo[indexPath.row];
            cell.rightTwoLB.text = @"";
        }
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        SWTMineAddressTVC * vc =[[SWTMineAddressTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        Weak(weakSelf);
        vc.sendAddressModelBlock = ^(SWTModel * _Nonnull model) {
            weakSelf.addressModel = model;
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}

@end
