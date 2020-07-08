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
#import "SWTLaoYouPinLeiCell.h"
#import "SWTLaoYouKaiDianLiuChengCell.h"
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
      [self.tableView registerClass:[SWTLaoYouPinLeiCell class] forCellReuseIdentifier:@"SWTLaoYouPinLeiCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTLaoYouKaiDianLiuChengCell" bundle:nil] forCellReuseIdentifier:@"SWTLaoYouKaiDianLiuChengCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB(182, 142, 101);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
}

- (void)initAddHeadV{
    self.headV =[[SWTLaoYouHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    
    self.tableView.tableHeaderView = self.headV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 190;
        }
        return UITableViewAutomaticDimension;
    }else if (indexPath.section == 1){
        return 180;
    }else {
        return 52+(ScreenW - 20)/5.0;
    }
    
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SWTLaoYouTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouTwoCell" forIndexPath:indexPath];
            return cell;
        }else {
            SWTLaoYouThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouThreeCell" forIndexPath:indexPath];
            cell.type = indexPath.row+1;
            cell.dataArray = @[@"文以及那里解放前哦我软件过期偶奇偶军分区的从教",@"金佛群文件费",@"起飞前噢ifIQ日期融进去偶然放入哦确认机器机器融券若干哦过情人节公积金哦解耦前夹肉融"].mutableCopy;
            [cell layoutIfNeeded];
            return cell;
        }
    }else if (indexPath.section == 1) {
        
        SWTLaoYouPinLeiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouPinLeiCell" forIndexPath:indexPath];
        return cell;
    }else {
        SWTLaoYouKaiDianLiuChengCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouKaiDianLiuChengCell" forIndexPath:indexPath];
               return cell;
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
