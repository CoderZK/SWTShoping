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
@interface SWTTiJiaoOrderTVC ()
@property(nonatomic , strong)NSArray *arrOne;
@property(nonatomic , strong)NSArray *arrTwo;
@property(nonatomic , strong)UIView *bottomView;
@property(nonatomic , strong)UILabel *numberLB,*moneyLB;
@property(nonatomic , strong)UIButton *tijiaoBt;
@end

@implementation SWTTiJiaoOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交订单";
    [self.tableView registerClass:[SWTLaoYouOneCell class] forCellReuseIdentifier:@"SWTLaoYouOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTongYongOneCell" bundle:nil] forCellReuseIdentifier:@"SWTTongYongOneCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.arrOne = @[@"发货保障",@"退货无忧",@"配送方式"];
    self.arrTwo = @[@"72小时不发货可申请退款",@"7天包退",@"卖家包邮"];
    [self initBview];
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
    self.moneyLB.text = @"￥1234";
    
    self.numberLB = [[UILabel alloc] init];
    self.numberLB.textColor = CharacterColor50;
    self.numberLB.font = kFont(13);
    [self.bottomView addSubview:self.numberLB];
    self.numberLB.text = @"共一件, 合计: ";
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 132;
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SWTLaoYouOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouOneCell" forIndexPath:indexPath];
        return cell;
    }else {
        SWTTongYongOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTongYongOneCell" forIndexPath:indexPath];
        if (indexPath.row == 3) {
            cell.leftLB.hidden = YES;
            cell.rightTwoLB.text  = @"145";
            cell.rightLB.text = @"小计:  ";
        }else {
            cell.leftLB.text = self.arrOne[indexPath.row];
            cell.rightLB.text = self.arrTwo[indexPath.row];
            cell.rightTwoLB.text = @"";
        }
        return cell;
    }
    
    
    
    SWTLaoYouOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



@end
