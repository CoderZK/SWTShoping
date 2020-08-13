//
//  SWTMJPubulicTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJPubulicTVC.h"
#import "SWTMineFaBuOneCell.h"
@interface SWTMJPubulicTVC ()

@end

@implementation SWTMJPubulicTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineFaBuOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self setLeftNagate];
}

- (void)setLeftNagate {
    
    UIButton * leftBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    @weakify(self);
    [[leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineFaBuOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.titleLB.text = @"直播";
        cell.imgV.image = [UIImage imageNamed:@"bbdyx59"];
    }else {
        cell.titleLB.text = @"视频";
        cell.imgV.image = [UIImage imageNamed:@"bbdyx60"];
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
