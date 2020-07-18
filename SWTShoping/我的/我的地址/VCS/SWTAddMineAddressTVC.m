//
//  SWTAddMineAddressTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAddMineAddressTVC.h"
#import "SWTMineTwoAddCell.h"
@interface SWTAddMineAddressTVC ()<UITextFieldDelegate>
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)NSArray *leftArr;
@property(nonatomic , strong)NSString *shouHuoStr,*phoneStr,*detailStr;

@end

@implementation SWTAddMineAddressTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"添加地址";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineTwoAddCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//       self.tableView.rowHeight = UITableViewAutomaticDimension;
//       self.tableView.estimatedRowHeight = 40;
       self.leftArr = @[@"收货人",@"手机号",@"地区",@"详细地址"];
    
    [self initFootV];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self.view);
        make.bottom.equalTo(self.footV.mas_top);
    }];
    
}

- (void)addAddressAction {

    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"realname"] = self.shouHuoStr;
    dict[@"mobile"] = self.phoneStr;
    dict[@"address"] = self.detailStr;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"province"] = @"1111";
    dict[@"district"] = @"3333";
    dict[@"city"] = @"2222";
    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",addressAdd_SWT,[zkSignleTool shareTool].session_uid] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"添加地址成功"];
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
    @weakify(self);
    [[loginOutBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.tableView endEditing:YES];
        [self addAddressAction];
        
    }];
    
    [self.footV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(34+45 + 30));
    }];
    
    [loginOutBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.footV);
        make.height.equalTo(@45);
        make.width.equalTo(@(ScreenW - 100));
        make.top.equalTo(self.footV).offset(30);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineTwoAddCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.rightTF.delegate = self;
    if (indexPath.row == 2) {
        cell.rightImgV.hidden = cell.rightTF.userInteractionEnabled =NO;
        cell.cons.constant = 25;
        cell.rightTF.placeholder = @"请选择";
    }else {
        cell.rightImgV.hidden = cell.rightTF.userInteractionEnabled =YES;
               cell.cons.constant = 10;
               cell.rightTF.placeholder = @"请填写";
    }
    cell.leftLB.text  = self.leftArr[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        [self.tableView endEditing:YES];
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTMineTwoAddCell * cell = (SWTMineTwoAddCell *)textField.superview.superview;
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
