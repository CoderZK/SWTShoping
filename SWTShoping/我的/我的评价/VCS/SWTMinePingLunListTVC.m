//
//  SWTMinePingLunListTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMinePingLunListTVC.h"
#import "SWTMinePingLunListCell.h"
@interface SWTMinePingLunListTVC ()

@end

@implementation SWTMinePingLunListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的评论";
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMinePingLunListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMinePingLunListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
