//
//  MJUpDatePicTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJUpDatePicTVC.h"
#import "MJHeMaiPicCell.h"
@interface MJUpDatePicTVC ()
@property(nonatomic,strong)UIView *headV,*footV;
@property(nonatomic,strong)UIButton *queRenBt;
@property(nonatomic,strong)UILabel *titleLB;

@end

@implementation MJUpDatePicTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * str1 = @"";
    NSString * str2 = @"";
    if (self.type ==0) {
        self.navigationItem.title = @"发布开料结果";
        str1 = @"请上传开料结果图片或视频";
        str2 = @"确认发布开料结果";
    }else if (self.type == 1) {
        self.navigationItem.title = @"发布毛坯结果";
        str1 = @"请上传毛坯结果图片或视频";
        str2 = @"确认发布毛坯结果";
    }else  {
         self.navigationItem.title = @"发布成品结果";
        str1 = @"请上传成品结果图片或视频";
        str2 = @"确认发布成品结果";
    }
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    self.tableView.tableHeaderView = self.headV;
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, ScreenW - 30, 20)];
    self.headV.backgroundColor = WhiteColor;
    self.titleLB.text = str1;
    [self.headV addSubview:self.titleLB];
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.tableView.tableFooterView = self.footV;
    self.queRenBt = [[UIButton alloc] initWithFrame:CGRectMake(30, 120, ScreenW - 60, 45)];
    [self.queRenBt setTitle:str2 forState:UIControlStateNormal];
    self.queRenBt.titleLabel.font = kFont(14);
    self.queRenBt.layer.cornerRadius = 22.5;
    self.queRenBt.clipsToBounds = YES;
    self.queRenBt.backgroundColor = RedColor;
    [self.footV  addSubview:self.queRenBt];
    
    [self.tableView registerClass:[MJHeMaiPicCell class] forCellReuseIdentifier:@"MJHeMaiPicCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return (ScreenW - 60)/4 * 3 + 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MJHeMaiPicCell * cell =[tableView dequeueReusableCellWithIdentifier:@"MJHeMaiPicCell" forIndexPath:indexPath];
    cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
