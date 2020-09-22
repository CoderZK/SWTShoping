//
//  MJHeMaiSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiSubTVC.h"
#import "MJHeMaiOrderCell.h"
#import "MJHeMaiDetailTVC.h"
#import "MJUpDatePicTVC.h"
@interface MJHeMaiSubTVC ()<zkPickViewDelelgate>

@end

@implementation MJHeMaiSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiOrderCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 165;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJHeMaiOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.centerBt  addTarget:self action:@selector(upPicAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MJHeMaiDetailTVC * vc =[[MJHeMaiDetailTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)upPicAction:(UIButton *)button {
    zkPickView * pickV = [[zkPickView alloc] init];
    pickV.arrayType = titleArray;
    pickV.array = @[@"上传开料结果",@"上传毛坯结果",@"上传成品结果"].mutableCopy;
    [pickV show];
    pickV.delegate = self;
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    
    MJUpDatePicTVC * vc =[[MJUpDatePicTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.type = leftIndex;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
