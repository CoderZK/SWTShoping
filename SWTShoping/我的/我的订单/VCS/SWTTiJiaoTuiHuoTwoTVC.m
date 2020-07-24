//
//  SWTTiJiaoTuiHuoTwoTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTiJiaoTuiHuoTwoTVC.h"
#import "SWTTuiHuiOneCell.h"
#import "SWTTuiHuoAddressCell.h"
#import "SWTTuiHuoDesCell.h"
#import "SWTTuiHuoThreeCell.h"
#import "SWTTuiHuoKuaiDiDanHaoVC.h"
@interface SWTTiJiaoTuiHuoTwoTVC ()

@end

@implementation SWTTiJiaoTuiHuoTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请退货";
    [self.tableView registerClass:[SWTTuiHuiOneCell class] forCellReuseIdentifier:@"SWTTuiHuiOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoAddressCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoAddressCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoDesCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoDesCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoThreeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 40;
    
   
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 119;
    }
    if (indexPath.row == 1) {
        return 115;
    }
    return UITableViewAutomaticDimension;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SWTTuiHuoThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoThreeCell" forIndexPath:indexPath];
        @weakify(self);
        
        [[cell.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
        }];
        [[cell.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                 @strongify(self);
            SWTTuiHuoKuaiDiDanHaoVC * vc =[[SWTTuiHuoKuaiDiDanHaoVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        return cell;
    }else {
        if (indexPath.row == 0) {
            SWTTuiHuoAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoAddressCell" forIndexPath:indexPath];
               return cell;
        }else if (indexPath.row == 1) {
            SWTTuiHuiOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuiOneCell" forIndexPath:indexPath];
            cell.lineV.hidden = YES;
               return cell;
        }else {
            SWTTuiHuoDesCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoDesCell" forIndexPath:indexPath];
               return cell;
        }
    }
    
    
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}




@end
