//
//  MJPublicHeMaiGoodsTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJPublicHeMaiGoodsTVC.h"
#import "SWTMineShopSettingCell.h"
@interface MJPublicHeMaiGoodsTVC ()<UITextFieldDelegate>
@property(nonatomic,strong)NSString *nameStr,*caiLiaoStr,*fenShuStr,*pingjunMoney,*allMoneyStr,*startTime,*endTimeStr;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)UIButton  *timeSBt,*timeEBt,*queRenBt;
@end

@implementation MJPublicHeMaiGoodsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布合买商品";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineShopSettingCell" bundle:nil] forCellReuseIdentifier:@"SWTMineShopSettingCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    self.footView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = self.footView;
    
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    lb.font = kFont(14);
    lb.text = @"合买时间";
    [self.footView addSubview:lb];
    
    self.timeEBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 100, 10, 90, 30)];
    self.timeEBt.titleLabel.font = kFont(12);
    [self.timeEBt setTitle:@"合买结束时间" forState:UIControlStateNormal];
    [self.timeEBt setTitleColor:CharacterColor102 forState:UIControlStateNormal];
    [self.footView addSubview:self.timeEBt];
    self.timeEBt.tag = 100;
    [self.timeEBt addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.timeSBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 90 - 100 - 20, 10, 90, 30)];
    self.timeSBt.titleLabel.font = kFont(12);
    [self.timeSBt setTitle:@"合买开始时间" forState:UIControlStateNormal];
    [self.timeSBt setTitleColor:CharacterColor102 forState:UIControlStateNormal];
    [self.footView addSubview:self.timeSBt];
    self.timeSBt.tag = 101;
    [self.timeSBt addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(ScreenW - 120, 24.5, 20, 1)];
    lineV.backgroundColor = CharacterColor102;
    [self.footView addSubview:lineV];
    
    
    self.queRenBt = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, ScreenW - 60, 45)];
       [self.queRenBt setTitle:@"发布合买商品" forState:UIControlStateNormal];
       self.queRenBt.titleLabel.font = kFont(14);
       self.queRenBt.layer.cornerRadius = 22.5;
       self.queRenBt.clipsToBounds = YES;
       self.queRenBt.backgroundColor = RedColor;
       [self.footView  addSubview:self.queRenBt];
    
    
    
}

- (void)timeAction:(UIButton *)button {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return 60;
    }
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineShopSettingCell" forIndexPath:indexPath];
    cell.rightTF.userInteractionEnabled = YES;
    cell.rightImgV.hidden = YES;
    cell.leftwoLB.hidden = YES;
    cell.swithBt.hidden = YES;
    cell.rightTF.placeholder = @"请填写";
    cell.rightTF.delegate = self;
    if (indexPath.row == 0) {
        cell.leftLB.text = @"合买物品";
        cell.rightTF.text = self.nameStr;
    }else if (indexPath.row == 1){
        cell.rightTF.text = self.caiLiaoStr;
        cell.leftLB.text = @"物品品种";
        cell.rightTF.placeholder = @"请选择";
        cell.rightTF.userInteractionEnabled = NO;
    }else if (indexPath.row == 2){
        cell.rightTF.text = self.fenShuStr;
        cell.leftLB.text = @"合买分数";
    }else if (indexPath.row == 3){
        cell.rightTF.text = self.allMoneyStr;
        cell.desLB.hidden = NO;
        cell.desLB.text = @"一人合买总价乘以1.05 (定制费)";
        cell.leftLB.text = @"合买总价";
    }else if (indexPath.row == 4){
        cell.rightTF.text = self.pingjunMoney;
        cell.leftLB.text = @"平均价格";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

@end
