//
//  MJHeMaiDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiDetailTVC.h"
#import "MJHeadView.h"
#import "MJHeMaiOrderCell.h"
#import "MJHeMaiQianHaoCell.h"
#import "MJHeMaiPicCell.h"
@interface MJHeMaiDetailTVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MJHeadView *headV;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MJHeMaiDetailTVC

- (void)viewDidLoad {
    self.navigationItem.title = @"合买详情";
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.headV = [[MJHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    self.tableView.tableHeaderView = self.headV;
    [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiOrderCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiQianHaoCell" bundle:nil] forCellReuseIdentifier:@"MJHeMaiQianHaoCell"];
    [self.tableView registerClass:[MJHeMaiPicCell class] forCellReuseIdentifier:@"MJHeMaiPicCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView reloadData];
    
//    self.view.backgroundColor = UIColor.greenColor;
    self.tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 165;
    }else if (indexPath.section == 1) {
        return 40;
    }
    return (ScreenW - 60)/4 * 3 + 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MJHeMaiOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
        return cell;
    }else if (indexPath.section == 1) {
        MJHeMaiQianHaoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"MJHeMaiQianHaoCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.LB1.font = cell.LB2.font =cell.LB3.font =cell.LB4.font = kFont(14);
            cell.LB1.textColor = cell.LB2.textColor =cell.LB3.textColor = CharacterColor50;
            [cell.leftBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
            [cell.rigthBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        }else {
            cell.LB1.font = cell.LB2.font =cell.LB3.font = kFont(13);
            cell.leftBt.titleLabel.font = cell.rigthBt.titleLabel.font = kFont(13);
            cell.LB1.textColor = cell.LB2.textColor =cell.LB3.textColor = CharacterColor50;
      
        }
        cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
        return cell;
    }
    MJHeMaiPicCell * cell =[tableView dequeueReusableCellWithIdentifier:@"MJHeMaiPicCell" forIndexPath:indexPath];
    cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
@end
