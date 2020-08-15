//
//  SWTMJMineFenSiTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineFenSiTVC.h"
#import "SWTMJMineFenSiCell.h"
@interface SWTMJMineFenSiTVC ()

@end

@implementation SWTMJMineFenSiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的粉丝";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMineFenSiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJMineFenSiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
