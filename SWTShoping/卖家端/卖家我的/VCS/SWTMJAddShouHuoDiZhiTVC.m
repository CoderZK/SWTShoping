//
//  SWTMJAddShouHuoDiZhiTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJAddShouHuoDiZhiTVC.h"
#import "SWTMineTwoAddCell.h"
@interface SWTMJAddShouHuoDiZhiTVC ()<UITextFieldDelegate,zkPickViewDelelgate>
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)NSArray *leftArr;
@property(nonatomic , strong)NSString *shouHuoStr,*phoneStr,*detailStr;
@property(nonatomic , strong)UIView *tableFootV;
@property(nonatomic , strong)UISwitch *switchBt;
@property(nonatomic , strong)NSString *pStr,*cStr,*aStr,*addStr;
@property(nonatomic , strong)NSMutableArray<zkPickModel *> *cityArr;

@end

@implementation SWTMJAddShouHuoDiZhiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"添加收货地址";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineTwoAddCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //       self.tableView.rowHeight = UITableViewAutomaticDimension;
    //       self.tableView.estimatedRowHeight = 40;
    self.leftArr = @[@"收货人",@"手机号",@"地区",@"详细地址"];
    
    [self initFootV];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self.view);
        make.bottom.equalTo(self.footV.mas_top);
    }];
    
    self.cityArr = @[].mutableCopy;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"City" ofType:@"plist"];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    
    for (int i = 0 ; i < arr.count; i++) {
        zkPickModel * model = [zkPickModel mj_objectWithKeyValues:arr[i]];
        [self.cityArr insertObject:model atIndex:0];
    }
    
    [self initTFootV];
    
}

- (void)addAddressAction {
    
//    [SVProgressHUD show];
//    NSMutableDictionary * dict = @{}.mutableCopy;
//    dict[@"realname"] = self.shouHuoStr;
//    dict[@"mobile"] = self.phoneStr;
//    dict[@"address"] = self.detailStr;
//    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
//    dict[@"province"] = self.pStr;
//    dict[@"district"] = self.aStr;
//    dict[@"city"] = self.cStr;
//    if (self.switchBt.on) {
//        dict[@"is_deafult"] = @"1";
//    }else {
//        dict[@"is_deafult"] = @"0";
//    }
//    [zkRequestTool networkingPOST: [NSString stringWithFormat:@"%@/%@",addressAdd_SWT,[zkSignleTool shareTool].session_uid] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [SVProgressHUD dismiss];
//        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
//            [SVProgressHUD showSuccessWithStatus:@"添加地址成功"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//        }else {
//            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//    }];
    
    
    
}



- (void)initTFootV  {
    
    self.tableFootV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 45)];
    self.tableFootV.backgroundColor = WhiteColor;
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
    lb.font = kFont(14);
    lb.text = @"设为默认地址";
    [self.tableFootV addSubview:lb];
    self.switchBt = [[UISwitch alloc] init];
    self.switchBt.mj_x = ScreenW - 70;
    self.switchBt.mj_y = 7.5;
    self.switchBt.on = NO;
    [self.tableFootV addSubview:self.switchBt];
    self.tableView.tableFooterView = self.tableFootV;
}

- (void)initFootV  {
    
    self.footV = [[UIView alloc] init];
    [self.view addSubview:self.footV];
    
    UIButton * loginOutBt  =[[UIButton alloc] init];
    [loginOutBt setBackgroundImage:[UIImage imageNamed:@"bbdyx27"] forState:UIControlStateNormal];
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
        cell.rightTF.text = self.addStr;
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
        zkPickView * pickV  =[[zkPickView alloc] init];
        pickV.arrayType = ArerArrayNormal;
        pickV.array = self.cityArr;
        [pickV show];
        pickV.delegate = self;
    }
    
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    self.pStr = self.cityArr[leftIndex].areaname;
    self.cStr = self.cityArr[leftIndex].cityList[centerIndex].areaname;
    self.aStr = self.cityArr[leftIndex].cityList[centerIndex].areaList[rightIndex].areaname;
    self.addStr =  [NSString stringWithFormat:@"%@%@%@",self.pStr,self.cStr,self.aStr];
    [self.tableView reloadData];
    
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
