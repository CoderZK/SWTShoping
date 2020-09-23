//
//  SWTHeMaiDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaiDetailTVC.h"
#import "MJHeMaiOrderCell.h"
#import "SWTHeMaidetailCell.h"
@interface SWTHeMaiDetailTVC ()

@end

@implementation SWTHeMaiDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiOrderCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerClass:[SWTHeMaidetailCell class] forCellReuseIdentifier:@"SWTHeMaidetailCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    return 165;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MJHeMaiOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        return cell;
    }else {
        SWTHeMaidetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SWTHeMaidetailCell" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
    
    
}

- (void)upPicAction:(UIButton *)button {
//    zkPickView * pickV = [[zkPickView alloc] init];
//    pickV.arrayType = titleArray;
//    pickV.array = @[@"上传开料结果",@"上传毛坯结果",@"上传成品结果"].mutableCopy;
//    [pickV show];
//    pickV.delegate = self;
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    
    
    
}

@end
