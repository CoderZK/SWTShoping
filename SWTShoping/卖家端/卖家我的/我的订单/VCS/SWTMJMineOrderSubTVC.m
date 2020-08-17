//
//  SWTMJMineOrderSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineOrderSubTVC.h"
#import "SWTMineOrderCell.h"
#import "SWTMJFaHuoShowView.h"
@interface SWTMJMineOrderSubTVC ()

@end

@implementation SWTMJMineOrderSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SWTMineOrderCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SWTMJFaHuoShowView * showV  =[[SWTMJFaHuoShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [showV show];
    
}


@end
