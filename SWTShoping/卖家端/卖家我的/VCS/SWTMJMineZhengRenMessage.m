//
//  SWTMJMineZhengRenMessage.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineZhengRenMessage.h"
#import "SWTMJRenZhengCell.h"
#import "SWTMineShopSettingSectionV.h"
@interface SWTMJMineZhengRenMessage ()
@property(nonatomic , strong)NSArray *leftTitleArr;
@property(nonatomic , strong)UIView *footV;
@end

@implementation SWTMJMineZhengRenMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺认证信息";
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJRenZhengCell" bundle:nil] forCellReuseIdentifier:@"cell"];
       [self.tableView registerClass:[SWTMineShopSettingSectionV class] forHeaderFooterViewReuseIdentifier:@"head"];
    
    self.leftTitleArr = @[@[@"实名认证",@"证件有效期"],@[@"姓名",@"电话",@"省份证",@"省份证照认证"],@[@"店铺名称",@"店铺简介",@"店铺LOGO"]];
    
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(40, 20, ScreenW - 80, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"bbdyx27"] forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    [button setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.footV addSubview:button];
    self.tableView.tableFooterView = self.footV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.leftTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftTitleArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWTMineShopSettingSectionV * headV  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
   if (section == 0) {
        headV.titelLB.text = @"基本信息";
    }else if (section == 1) {
        headV.titelLB.text = @"个人信息";
    }else {
        headV.titelLB.text = @"店铺信息";
    }
    return headV;;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJRenZhengCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.leftTitleArr[indexPath.section][indexPath.row];
    cell.rightImgV.hidden = YES;
    if ((indexPath.section == 1 && indexPath.row == 3)|| (indexPath.section == 2 && indexPath.row == 2)) {
        cell.rightImgV.hidden = NO;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



@end
