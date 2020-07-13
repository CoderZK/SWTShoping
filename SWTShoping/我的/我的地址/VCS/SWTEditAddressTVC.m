//
//  SWTEditAddressTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTEditAddressTVC.h"
#import "SWTEditeAddressCell.h"
@interface SWTEditAddressTVC ()
@property(nonatomic , strong)UIView *footV;
@end

@implementation SWTEditAddressTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"编辑地址";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTEditeAddressCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //       self.tableView.rowHeight = UITableViewAutomaticDimension;
    //       self.tableView.estimatedRowHeight = 40;
    
    [self initFootV];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self.view);
        make.bottom.equalTo(self.footV.mas_top);
    }];
    
}

- (void)initFootV  {
    
    self.footV = [[UIView alloc] init];
    [self.view addSubview:self.footV];
    
    UIButton * loginOutBt  =[[UIButton alloc] init];
    [loginOutBt setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    [loginOutBt setTitle:@"确认" forState:UIControlStateNormal];
    loginOutBt.titleLabel.font = kFont(14);
    loginOutBt.layer.cornerRadius = 22.5;
    loginOutBt.clipsToBounds = YES;
    [self.footV addSubview:loginOutBt];
    
    UIButton * loginOutBtTwo  =[[UIButton alloc] init];
    [loginOutBtTwo setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    [loginOutBtTwo setTitle:@"删除地址" forState:UIControlStateNormal];
    loginOutBtTwo.titleLabel.font = kFont(14);
    loginOutBtTwo.layer.cornerRadius = 22.5;
    loginOutBtTwo.clipsToBounds = YES;
    [self.footV addSubview:loginOutBtTwo];
    
    [[loginOutBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
        
        
    }];
    
    
    [[loginOutBtTwo rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
           
           
           
       }];
    
    [self.footV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(34+45 + 30));
    }];
    
    [loginOutBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.left.equalTo(self.footV).offset(15);
        make.width.equalTo(@((ScreenW - 100)/2));
        make.top.equalTo(self.footV).offset(30);
    }];
    
    [loginOutBtTwo mas_makeConstraints:^(MASConstraintMaker *make) {
          make.height.equalTo(@45);
          make.right.equalTo(self.footV).offset(-15);
          make.width.equalTo(@((ScreenW - 100)/2));
          make.top.equalTo(self.footV).offset(30);
      }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTEditeAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 2) {
        cell.rightImgV.hidden = NO;
    }else {
        cell.rightImgV.hidden = YES;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}
@end
