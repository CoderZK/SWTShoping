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
@interface SWTShopIntroduceTVC ()
@property(nonatomic , strong)SWTShopIntorduceHeadView *headV;
@property(nonatomic , assign)NSInteger  type;
@property(nonatomic , strong)SWTModel *dataModel;
@end

@implementation SWTShopIntroduceTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺印象";
    
    [self initHedV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceCell" bundle:nil] forCellReuseIdentifier:@"SWTShopIntroduceCell"];

     [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTShopIntroduceTwoCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTShopIntroduceThreeCell"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == 0) {
        if (section == 1) {
            return 2;
        }
        
        return 1;
    }else {
        return self.dataModel.commentlist.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 34+40;
    }else {
        return self.dataModel.commentlist[indexPath.row].HHHHHH;
    }
    return UITableViewAutomaticDimension;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        if (indexPath.section == 0) {
               SWTShopIntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceCell" forIndexPath:indexPath];
               cell.scoreLB.text =  [NSString stringWithFormat:@"%@分",self.dataModel.score];
               return cell;
           }else if (indexPath.section == 1) {
               SWTShopIntroduceTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceTwoCell" forIndexPath:indexPath];
               
               return cell;
           }else {
               SWTShopIntroduceThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceThreeCell" forIndexPath:indexPath];
               cell.timeLB.text = self.dataModel.createtime;
               cell.addressLB.text = self.dataModel.refund_address;
               cell.desLB.text = self.dataModel.des;
               return cell;
           }
    }else {
       
        SWTShopIntroducePingJiaCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroducePingJiaCell" forIndexPath:indexPath];
        
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



- (void)initHedV  {
    self.headV = [[SWTShopIntorduceHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 165)];
    self.tableView.tableHeaderView = self.headV;
    self.headV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [self.headV.delegateSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        if (x.intValue == 100) {
            
        }else if (x.intValue == 101) {
            
        }else if (x.intValue == 102) {
            self.type = 0;
            [self getData];
        }else if (x.intValue == 103) {
            self.type = 1;
            [self getData];
        }
        
    }];
}


@end
