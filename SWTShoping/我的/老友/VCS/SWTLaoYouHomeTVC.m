//
//  SWTLaoYouHomeTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouHomeTVC.h"
#import "SWTLaoYouHomeHeadView.h"
#import "SWTLaoYouTwoCell.h"
#import "SWTLaoYouThreeCell.h"
@interface SWTLaoYouHomeTVC ()
@property(nonatomic , strong)SWTLaoYouHomeHeadView *headV;
@end

@implementation SWTLaoYouHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要开店";
    [self initAddHeadV];
    
    [self.tableView registerClass:[SWTLaoYouTwoCell class] forCellReuseIdentifier:@"SWTLaoYouTwoCell"];
    [self.tableView registerClass:[SWTLaoYouThreeCell class] forCellReuseIdentifier:@"SWTLaoYouThreeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB(182, 142, 101);
    self.tableView.estimatedRowHeight = 40;
    
}

- (void)initAddHeadV{
    self.headV =[[SWTLaoYouHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    
    self.tableView.tableHeaderView = self.headV;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 190;
    }
    return UITableViewAutomaticDimension;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SWTLaoYouTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouTwoCell" forIndexPath:indexPath];
        return cell;
    }else {
        SWTLaoYouThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouThreeCell" forIndexPath:indexPath];
        cell.type = indexPath.row;
        cell.dataArray = @[@"文以及那里解放前哦我软件过期偶奇偶军分区的从教",@"金佛群文件费",@"起飞前噢ifIQ日期融进去偶然放入哦确认机器机器融券若干哦过情人节公积金哦解耦前夹肉融"].mutableCopy;
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
