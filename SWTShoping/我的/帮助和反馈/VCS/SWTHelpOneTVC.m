//
//  SWTHelpOneTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHelpOneTVC.h"
#import "SWTMineWalletCell.h"
#import "SWTHelpFarVC.h"
@interface SWTHelpOneTVC ()

@end

@implementation SWTHelpOneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助与反馈";
    if (self.isLianXiUs) {
        self.navigationItem.title = @"联系我们";
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineWalletCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = BackgroundColor;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineWalletCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (self.isLianXiUs) {
        if (indexPath.row == 0) {
            cell.imgV.image = [UIImage imageNamed:@"tel"];
            cell.leftLB.text = @"电话0519-******";
        }else {
            cell.imgV.image = [UIImage imageNamed:@"fax"];
            cell.leftLB.text = @"传真";
        }
        cell.rightImgV.hidden = YES;
        cell.rightLB.text = @"";
        return cell;
    }else {
        if (indexPath.row == 0) {
            cell.imgV.image = [UIImage imageNamed:@"help"];
            cell.leftLB.text = @"帮助";
        }else {
            cell.imgV.image = [UIImage imageNamed:@"help1"];
            cell.leftLB.text = @"反馈";
        }
        cell.rightLB.text = @"";
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isLianXiUs) {
        
    }else {
        if (indexPath.row == 0) {
            SWTHelpFarVC * vc =[[SWTHelpFarVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}
@end
