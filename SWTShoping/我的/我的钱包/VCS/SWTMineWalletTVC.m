//
//  SWTMineWalletTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineWalletTVC.h"
#import "SWTMineWalletCell.h"
@interface SWTMineWalletTVC ()

@end

@implementation SWTMineWalletTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的钱包";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineWalletCell" bundle:nil] forCellReuseIdentifier:@"cell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.imgV.image = [UIImage imageNamed:@"wallet_money"];
        cell.leftLB.text = @"余额";
    }else {
        cell.imgV.image = [UIImage imageNamed:@"wallet_card"];
        cell.leftLB.text = @"银行卡";
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



@end
