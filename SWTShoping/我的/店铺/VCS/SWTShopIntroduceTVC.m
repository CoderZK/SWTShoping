//
//  SWTShopIntroduceTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopIntroduceTVC.h"
#import "SWTShopIntorduceHeadView.h"
#import "SWTShopIntroduceCell.h"
#import "SWTShopIntroduceThreeCell.h"
#import "SWTShopIntroduceTwoCell.h"
#import "SWTShopIntroducePingJiaCell.h"
#import "SWTDianPuYinXiangCell.h"
@interface SWTShopIntroduceTVC ()
@property(nonatomic , strong)SWTShopIntorduceHeadView *headV;
@property(nonatomic , assign)NSInteger  type;
@property(nonatomic , strong)SWTModel *dataModel;
@end

@implementation SWTShopIntroduceTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.sendDataModelBlock != nil) {
        self.sendDataModelBlock(self.model);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺印象";
    
    [self initHedV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceCell" bundle:nil] forCellReuseIdentifier:@"SWTShopIntroduceCell"];

     [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTShopIntroduceTwoCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceThreeCell" bundle:nil]
          forCellReuseIdentifier:@"SWTShopIntroduceThreeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTDianPuYinXiangCell" bundle:nil]
    forCellReuseIdentifier:@"SWTDianPuYinXiangCell"];
    [self.tableView registerClass:[SWTShopIntroducePingJiaCell class] forCellReuseIdentifier:@"SWTShopIntroducePingJiaCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight = 40;
    [self getData];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merchid"] = self.ID;
    dict[@"type"] = @(self.type + 1);
    [zkRequestTool networkingPOST:merchImpression_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.headV.model = self.dataModel;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataModel == nil) {
        return 0;
    }
    if (self.type == 0) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == 0) {
        if (section == 1) {
            return 2;
        }
        
        return 1;
    }else {
        if (section == 0) {
            return 1;
        }
        return self.dataModel.commentlist.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        if (indexPath.section == 0) {
            return 34+40;
        }else {
            return UITableViewAutomaticDimension;
        }
    }else {
     
        if (indexPath.section == 0) {
            return 40;
        }else {
          NSLog(@"%@----%f",@"222333",self.dataModel.commentlist[indexPath.row].HHHHHH);
            return self.dataModel.commentlist[indexPath.row].HHHHHH;
        }
            
        
    }
    
    
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        if (indexPath.section == 0) {
               SWTShopIntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceCell" forIndexPath:indexPath];
               cell.scoreLB.text =  [NSString stringWithFormat:@"%@分",self.dataModel.score];
            [cell.vipBt setTitle:self.dataModel.levelcode forState:UIControlStateNormal];
               return cell;
           }else if (indexPath.section == 1) {
               SWTShopIntroduceTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceTwoCell" forIndexPath:indexPath];
               cell.backgroundColor = WhiteColor;
               if (indexPath.row == 0) {
                   cell.titleLB.text = @"店铺保证金";
                   cell.contentLB.text = [NSString stringWithFormat:@"该店铺已缴纳%@元店铺保证金, 货款在买家确认收货后结算给商家。",self.model.margin.getPriceAllStr];
               }else {
                  cell.titleLB.text = @"个人认证";
                   cell.contentLB.text = @"该商家已通过个人认证, 身份信息已在滴滴雨轩备案";
               }
               return cell;
           }else {
               SWTShopIntroduceThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceThreeCell" forIndexPath:indexPath];
               cell.timeLB.text = self.dataModel.createtime;
               cell.addressLB.text = self.dataModel.refund_address;
               cell.desLB.text = self.dataModel.des;
               
               return cell;
           }
    }else {
       
        if (indexPath.section == 0) {
            SWTDianPuYinXiangCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTDianPuYinXiangCell" forIndexPath:indexPath];
            [cell.leftBt setTitle:[NSString stringWithFormat:@"全部%@",self.dataModel.allnum] forState:UIControlStateNormal];
            cell.leftCons.constant = [cell.leftBt.titleLabel.text getWidhtWithFontSize:13] + 15;
            
            
            [cell.rightBt setTitle:[NSString stringWithFormat:@"有图%@",self.dataModel.imgnum] forState:UIControlStateNormal];
            cell.rightCons.constant = [cell.rightBt.titleLabel.text getWidhtWithFontSize:13] + 15;
            cell.clipsToBounds = YES;
            return cell;
        }else {
            SWTShopIntroducePingJiaCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroducePingJiaCell" forIndexPath:indexPath];
            cell.model = self.dataModel.commentlist[indexPath.row];
            cell.clipsToBounds = YES;
            return cell;
        }
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



- (void)initHedV  {
    self.headV = [[SWTShopIntorduceHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 165)];
    self.tableView.tableHeaderView = self.headV;
    self.headV.delegateSignal = [[RACSubject alloc] init];
    if ([self.model.isfollow isEqualToString:@"yes"]) {
       
        [self.headV.gaunZhuBt setTitle:@"已关注" forState:UIControlStateNormal];
    }else {
        [self.headV.gaunZhuBt setTitle:@"关注卖家" forState:UIControlStateNormal];
    }
    @weakify(self);
    [self.headV.delegateSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        if (x.intValue == 100) {
            //联系卖家
            TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:self.model.imid];
                   TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
                   vc.navigationItem.title = self.model.store_name;
                   [self.navigationController pushViewController:vc animated:YES];
        }else if (x.intValue == 101) {
            //关注
            [self gaunZhuAction];
        }else if (x.intValue == 102) {
            self.type = 0;
            [self getData];
        }else if (x.intValue == 103) {
            self.type = 1;
            [self getData];
        }
        
    }];
}


//关注操作
- (void)gaunZhuAction {
    
    if (!ISLOGIN) {
        [self gotoLoginVC];
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    dict[@"type"] = @"1";
    dict[@"userid"] =[zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:userFollowOperate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if ([self.model.isfollow isEqualToString:@"no"]) {
                [SVProgressHUD showSuccessWithStatus:@"关注店铺成功"];
                self.model.isfollow = @"yes";
                [self.headV.gaunZhuBt setTitle:@"已关注" forState:UIControlStateNormal];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"取消关注店铺"];
                self.model.isfollow = @"no";
                [self.headV.gaunZhuBt setTitle:@"关注卖家" forState:UIControlStateNormal];
            }
            
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
    
}

@end
