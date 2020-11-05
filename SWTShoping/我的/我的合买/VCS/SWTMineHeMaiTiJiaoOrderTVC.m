//
//  SWTMineHeMaiTiJiaoOrderTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineHeMaiTiJiaoOrderTVC.h"
#import "SWTLaoYouOneCell.h"
#import "SWTHeMaiTwoCell.h"
#import "SWTDingJinShowView.h"
#import "SWTHeMaiMineDingZhiShowView.h"
#import "SWTHeMaiDianPuShowVIew.h"
#import "SWTHeMaiMineDingZhiShowView.h"
#import "SWTMineAddressTVC.h"
#import "SWTChooseAddcell.h"
#import "SWTMineHeMaiOrderFatherVC.h"
@interface SWTMineHeMaiTiJiaoOrderTVC ()
@property(nonatomic , strong)UIView *bottomV;
@property(nonatomic , strong)UIButton *leftBt,*rightBt,*gouBt;
@property(nonatomic , strong)SWTModel *addressModel;
@property(nonatomic,assign)BOOL isYuFuDingJin;
@property(nonatomic,assign)CGFloat payMoney;
@property(nonatomic,strong)NSArray *dictArray;
@end

@implementation SWTMineHeMaiTiJiaoOrderTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [LSTTimer addTimerForTime:7200 identifier:@"listTimer" handle:nil];
//              //配置通知发送和计时任务绑定 没有配置 就不会有通知发送
//    [LSTTimer setNotificationForName:@"ListChangeNF" identifier:@"listTimer" changeNFType:LSTTimerSecondChangeNFTypeMS];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [LSTTimer removeTimerForIdentifier:@"listTimer"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交订单";
    
    [self.tableView registerClass:[SWTLaoYouOneCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTHeMaiTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTHeMaiTwoCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTChooseAddcell" bundle:nil] forCellReuseIdentifier:@"SWTChooseAddcell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BackgroundColor;
    
    [self initBottomView];
    [self getData];
    self.isYuFuDingJin = NO;
    [self getDictData];
    
}



- (void)dealloc {
//    [LSTTimer removeAllTimer];
}

- (void)initBottomView {
    
    self.bottomV = [[UIView alloc] init];
    self.bottomV.backgroundColor = BackgroundColor;
    [self.view addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (sstatusHeight > 20) {
            make.bottom.equalTo(self.view).offset(-34);
        }else {
            make.bottom.equalTo(self.view);
        }
        make.height.equalTo(@150);
    }];
    
    UIView * whiteV  =[[UIView alloc] init];
    whiteV.backgroundColor = WhiteColor ;
    [self.bottomV addSubview:whiteV];
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.bottomV);
        make.height.equalTo(@55);
    }];
    
    UIButton * leftBt  =[[UIButton alloc] init];
    [leftBt setTitleColor:RedColor forState:UIControlStateNormal];
    leftBt.titleLabel.font = kFont(15);
    [leftBt setTitle: [NSString stringWithFormat:@"￥%@",self.model.price] forState:UIControlStateNormal];
    if (self.model.num.intValue == 1) {
        [leftBt setTitle: [NSString stringWithFormat:@"￥%0.2f",self.model.price.doubleValue * 1.05] forState:UIControlStateNormal];
    }
    [whiteV addSubview:leftBt];
    [leftBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(whiteV);
        make.width.equalTo(@(ScreenW /2));
    }];
    
    UIButton * rightBt  =[[UIButton alloc] init];
    [rightBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    [rightBt setBackgroundColor:RedColor];
    
    rightBt.titleLabel.font = kFont(15);
    [rightBt setTitle:@"提交订单" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    rightBt.tag = 100;

    [whiteV addSubview:rightBt];
    [rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(whiteV);
        make.width.equalTo(@(ScreenW /2));
    }];
    
    UIButton * gouBt  =[[UIButton alloc] init];
    [gouBt setImage:[UIImage imageNamed:@"gou"] forState:UIControlStateSelected];
    [gouBt setImage:[UIImage imageNamed:@"goun"] forState:UIControlStateNormal];
    [self.bottomV addSubview:gouBt];
    gouBt.tag = 99;
    [gouBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.gouBt = gouBt;
    
    UILabel * lb  =[[UILabel alloc] init];
    lb.text = @"同意";
    lb.font = kFont(14);
    [self.bottomV addSubview:lb];
    
    
    UIButton * leftBt1  =[[UIButton alloc] init];
    [leftBt1 setTitleColor:RedColor forState:UIControlStateNormal];
    leftBt1.titleLabel.font = kFont(14);
    [leftBt1 setTitle:@"《合买协议》" forState:UIControlStateNormal];
    leftBt1.tag = 101;
    [leftBt1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomV addSubview:leftBt1];
    
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomV).offset(-10);
        make.bottom.equalTo(whiteV.mas_top).offset(-40);
        make.height.equalTo(@20);
        
    }];
    
    [gouBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lb);
        make.right.equalTo(lb.mas_left);
        make.height.width.equalTo(@30);
    }];
    [leftBt1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lb);
        make.left.equalTo(lb.mas_right).offset(8);
        make.height.equalTo(@30);
    }];
    
    
    
    
}
//提交订单
- (void)clickAction:(UIButton *)button {
    if (button.tag == 99) {
        button.selected = !button.selected;
    }else if (button.tag == 100) {
        //提交订单
        
        if (self.gouBt.selected == NO) {
            [SVProgressHUD showErrorWithStatus:@"请勾选买卖协议"];
            return;
        }
        [self tiJiaoDingDanAction];
    }else if (button.tag == 101) {
        //合买协议
        
    }
    
}

- (void)getDictData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:orderdict_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
  
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dictArray = responseObject[@"data"];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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

//提交订单

- (void)tiJiaoDingDanAction {
    
    if (self.addressModel == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择收货地址"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"addressid"] = self.addressModel.ID;
    dict[@"goodid"] = self.model.ID;
    dict[@"merchid"] = self.model.merchid;
    dict[@"num"] = @"1";
    
    SWTHeMaiTwoCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (self.isYuFuDingJin) {
        dict[@"isprepay"] = @"1";
    }else {
        dict[@"isprepay"] = @"0";
    }
    
    
    dict[@"price"] = self.model.price;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:shareSubmit_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        if ([responseObject[@"code"] intValue]== 200) {
          [SVProgressHUD showSuccessWithStatus:@"合买订单成功"];
        
            SWTPayVC * vc =[[SWTPayVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.orderID = responseObject[@"data"];
            vc.merchID = self.model.merchid;
            vc.priceStr = self.model.price;
            [self.navigationController pushViewController:vc animated:YES];
            
          
            
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
    if (section == 0) {
        return 1;
    }
    if (self.model.num.intValue == 1) {
        return 5;
    }
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 79;
    }else {
        if (indexPath.row == 0) {
            return 132;
        }else if (indexPath.row == 2) {
            return 0;
        }
        return 50;
    }
    
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SWTChooseAddcell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTChooseAddcell" forIndexPath:indexPath];
        cell.model = self.addressModel;
        
        return cell;
    }else {
        if (indexPath.row == 0) {
            SWTLaoYouOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.timeInterval = [NSString pleaseInsertEndTime:self.model.endtime] > 0 ? [NSString pleaseInsertEndTime:self.model.endtime]:0;
            cell.leftOneLB.text = self.model.name;
            cell.leftTwoLb.text = @"x1";
            cell.moneyLB.text =  [NSString stringWithFormat:@"￥%@",self.model.price.getPriceStr];
            cell.moneyLB.textAlignment = NSTextAlignmentRight;
            cell.rightImgV.hidden = YES;
            cell.leftThreeLB.textColor = CharacterColor102;
            [cell.shopNameBt setTitle:self.model.store_name forState:UIControlStateNormal];
            [cell.leftimgV sd_setImageWithURL:[self.model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            cell.leftTwoLb.text =@"";
            if (self.dictArray.count >2) {
                  cell.leftTwoLb.text = [NSString stringWithFormat:@"剩余支付时间:%@小时",[self.dictArray[1] objectForKey:@"value"]];;
            }
               return cell;
        }else {
           SWTHeMaiTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SWTHeMaiTwoCell" forIndexPath:indexPath];
            cell.swithBt.hidden = YES;
            cell.rightLB.hidden = NO;
            cell.leftTwoLB.hidden = NO;
            cell.leftBt.hidden = YES;
            cell.clipsToBounds = YES;
            if (indexPath.row == 1) {
                cell.leftTwoLB.hidden = YES;
                cell.leftOneLB.text = @"配送方式";
                cell.rightLB.text = @"";
                if (self.dictArray.count >1){
                    cell.rightLB.text = [NSString stringWithFormat:@"%@",[self.dictArray[1] objectForKey:@"value"]];;
                }
                cell.rightLB.textColor = CharacterColor50;
                
            }else if (indexPath.row == 2) {
                cell.leftTwoLB.hidden = YES;
                cell.leftOneLB.text = @"地址";
                if (self.addressModel == nil) {
                    cell.rightLB.text = @"请选择地址";
                }else {
                    cell.rightLB.text = self.addressModel.address_info;
                }
                
                cell.rightLB.textColor = CharacterColor50;
                
                
            } else if (indexPath.row == 3) {
                cell.leftBt.hidden =  cell.swithBt.hidden = NO;
                cell.swithBt.on = self.isYuFuDingJin;
                cell.rightLB.hidden = YES;
                cell.swithBt.userInteractionEnabled = NO;
                
                cell.leftOneLB.text = @"预付定金";
                cell.leftTwoLB.text = @"尾款支付, 不支持退款";

                [cell.yiwenbt  addTarget:self action:@selector(TTTTAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }else if (indexPath.row == 4) {
                cell.leftOneLB.text = @"私人定制费";
                cell.leftTwoLB.text = @"(贷款金额5%)";
                cell.rightLB.text = [NSString stringWithFormat:@"%0.2f",self.model.price.doubleValue * 0.05];
                cell.rightLB.textColor = RedLightColor;
            }
           return cell;
        }
    }
    
  
}

- (void)TTTTAction:(UIButton *)button {
    SWTDingJinShowView  * showV  =[[SWTDingJinShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                   [showV show];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 0) {
        
     
            
            SWTMineAddressTVC * vc =[[SWTMineAddressTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            Weak(weakSelf);
            vc.sendAddressModelBlock = ^(SWTModel * _Nonnull model) {
                weakSelf.addressModel = model;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];

    }
    
    if (indexPath.section == 1 && indexPath.row == 3) {
        self.isYuFuDingJin = !self.isYuFuDingJin;
        [self.tableView reloadData];
    }
  
}




@end
