//
//  SWTZhenPinGeSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhenPinGeSubTVC.h"
#import "SWTMineGuanZHuDinaPuCell.h"
@interface SWTZhenPinGeSubTVC ()<SWTMineGuanZHuDinaPuCellDelegate>
@property(nonatomic , strong)UIImageView *imgV;
@end

@implementation SWTZhenPinGeSubTVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tableView registerClass:[SWTMineGuanZHuDinaPuCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addImgV];
    
}

- (void)addImgV {
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    self.imgV.image =[UIImage imageNamed:@"369"];
    [self.view addSubview:self.imgV];
    
    [self.view bringSubviewToFront:self.tableView];
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30+134+ 15;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineGuanZHuDinaPuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.nameLB.text = @"fgkodkgfeoprkgkp";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    cell.delegate = self;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark --- 点击 cell  ----

- (void)didClickGuanZhuDianPuView:(SWTMineGuanZHuDinaPuCell *)cell withIndex:(NSInteger)index isClickHead:(BOOL)isClickHead {
    if (isClickHead) {
        //点击的是头像或者进店
        SWTShopHomeVC * vc =[[SWTShopHomeVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else {
        //点击的是内部的其他信息
        
        
    }
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"---\n%f",scrollView.contentOffset.y);
    
    CGFloat yy =  120;
    
    CGFloat yyy = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y<= -yy) {
        self.imgV.mj_y = 0;
        self.imgV.mj_h = 150 - (scrollView.contentOffset.y + yy );
    }else if (scrollView.contentOffset.y<= 150-yy) {
        self.imgV.mj_y =  -(scrollView.contentOffset.y + yy);
    }else {
        self.imgV.mj_y = - 200;
    }

}

@end
