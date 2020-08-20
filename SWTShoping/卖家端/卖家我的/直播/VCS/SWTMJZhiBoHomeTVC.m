//
//  SWTMJZhiBoHomeTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJZhiBoHomeTVC.h"
#import "SWTMineFaBuOneCell.h"
#import "SWTMJAddZhiBoShangPinTVC.h"
@interface SWTMJZhiBoHomeTVC ()

@end

@implementation SWTMJZhiBoHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"直播";
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineFaBuOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineFaBuOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleLB.text = @"直播";
        cell.imgV.image = [UIImage imageNamed:@"bbdyx59"];
    }else {
        cell.titleLB.text = @"添加商品";
        cell.imgV.image = [UIImage imageNamed:@"bbdyx60"];
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
    }else {
        SWTMJAddZhiBoShangPinTVC * vc =[[SWTMJAddZhiBoShangPinTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



@end
