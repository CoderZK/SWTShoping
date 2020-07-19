//
//  SWTEditAddressTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTEditAddressTVC.h"
#import "SWTEditeAddressCell.h"
@interface SWTEditAddressTVC ()<UITextFieldDelegate>
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)NSString *shouHuoStr,*phoneStr,*detailStr;
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
    self.shouHuoStr = self.model.realname;
    self.phoneStr = self.model.mobile;
    self.detailStr = self.model.address_info;
    
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
        
        [self.tableView endEditing:YES];
        [self editAddressAction];
        
        
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


- (void)editAddressAction {

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"realname"] = self.shouHuoStr;
    dict[@"mobile"] = self.phoneStr;
    dict[@"address"] = self.detailStr;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"province"] = @"444444";
    dict[@"district"] = @"66666";
    dict[@"city"] = @"555555";
    dict[@"id"] = self.model.ID;
    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",addressEdit_SWT,[zkSignleTool shareTool].session_uid] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"修改地址成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
    if (indexPath.row == 0) {
         cell.leftTF.text = self.model.realname;
    }else if (indexPath.row == 1) {
        cell.leftTF.text = self.model.mobile;
    }else if (indexPath.row == 2) {
        cell.leftTF.text =  [NSString stringWithFormat:@"%@%@%@",self.model.province,self.model.city,self.model.district];
    }else {
        cell.leftTF.text = self.model.address_info;
    }
    cell.leftTF.delegate = self;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTEditeAddressCell * cell = (SWTEditeAddressCell *)textField.superview.superview;
    NSIndexPath * indexPath  = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0 ) {
        self.shouHuoStr = textField.text;
        
    }else if (indexPath.row == 1){
        self.phoneStr = textField.text;
        
    }else if (indexPath.row == 3) {
        self.detailStr = textField.text;
    }
}

@end
