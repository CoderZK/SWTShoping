//
//  SWTShopSettingTVC.m
//  SWTZBMH
//
//  Created by kunzhang on 2020/8/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopSettingTVC.h"
#import "SWTMineShopSettingCell.h"
#import "SWTMineShopSettingSectionV.h"
@interface SWTShopSettingTVC ()
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)NSArray *titleArr;
@end

@implementation SWTShopSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺设置";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineShopSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[SWTMineShopSettingSectionV class] forHeaderFooterViewReuseIdentifier:@"head"];
    
    self.titleArr = @[@[@"联系人",@"手机号码"],@[@"竞拍设置",@"买家出价条件",@"定金设置"],@[@"粉丝",@"黑名单"],@[@"固定[我的]为卖家中心"]];
    [self initFootV];

}


- (void)initFootV {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    self.tableView.tableFooterView = self.footV;
    self.footV.backgroundColor = WhiteColor;
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(50, 10, ScreenW - 100, 40)];
    button.titleLabel.font = kFont(15);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //点击退出登录
        
    }];
    [self.footV addSubview:button];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else {
        return 45;
    }
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.titleArr[indexPath.section][indexPath.row];
    cell.swithBt.hidden = YES;
    cell.leftwoLB.hidden = YES;
    cell.rightTF.hidden = NO;
    if (indexPath.section == 1) {
        if (indexPath.row == 2) {
            cell.rightTF.hidden = YES;
            cell.swithBt.hidden = NO;
            cell.leftwoLB.hidden = NO;
            cell.leftwoLB.text = @"(订单金额 >= 2万可用)";
        }
    }else if (indexPath.section == 3) {
        cell.rightTF.hidden = YES;
        cell.swithBt.hidden = NO;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWTMineShopSettingSectionV * headV  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (section == 0) {
        
    } else if (section == 1) {
        headV.titelLB.text = @"竞拍设置";
    }else if (section == 2) {
        headV.titelLB.text = @"用户设置";
    }else {
        headV.titelLB.text = @"高级设置";
    }
    return headV;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



@end
