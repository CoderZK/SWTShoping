//
//  SWTMJAddYouHuiQuanTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJAddYouHuiQuanTVC.h"
#import "SWTAddYouHuiQuanCell.h"
#import "SWTMJAddYouHuiQuanBt.h"
@interface SWTMJAddYouHuiQuanTVC ()<UITextFieldDelegate>
@property(nonatomic , strong)UIView *headV;
@property(nonatomic , strong)UIScrollView *scrollview;
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)NSArray *titleArr;
@property(nonatomic , strong)NSString *jiaGeStr,*zheKouStr,*numberStr,*startTime,*endTime;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic,assign)BOOL isAdd;

@end

@implementation SWTMJAddYouHuiQuanTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建优惠券";
    self.titleArr = @[@"使用金额",@"折扣",@"发放张数",@"开始使用",@"结束使用"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTAddYouHuiQuanCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self addHeadV];
    self.footV.hidden = YES;
    self.dataArray = @[].mutableCopy;
    [self getDataList];
   
}

- (void)getDataList {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merch_id"] = self.merch_id;
    [zkRequestTool networkingPOST:merchcouponGet_coupon_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [self setYouHuiQuan];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
    }];
}

- (void)addHeadV {
    self.headV  =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW , 110)];
    self.headV.backgroundColor = WhiteColor;
    
    
    
    self.scrollview  =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 110)];
    self.scrollview.backgroundColor = BackgroundColor;
    [self.headV addSubview:self.scrollview];
    
    [self setYouHuiQuan];
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 70)];
    
    self.footV.backgroundColor = WhiteColor;
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(50, 20, ScreenW - 100, 40)];
    
    button.titleLabel.font = kFont(15);
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"bbdyx27"] forState:UIControlStateNormal];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //点击确定
        
        [self addYouHuiQuan];
        
    }];
    [self.footV addSubview:button];
    self.tableView.tableFooterView = self.footV;
    self.tableView.tableHeaderView = self.headV;
    
    
}

// 添加优惠券
- (void)addYouHuiQuan {
    
    
    if (self.jiaGeStr.length + self.zheKouStr.length + self.numberStr.length + self.startTime.length + self.endTime.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"信息填写不全"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merch_id"] = self.merch_id;
    dict[@"useprice"] = self.jiaGeStr;
    dict[@"rate"] = self.zheKouStr;
    dict[@"start_date"] =  [NSString stringWithFormat:@"%@ 00:00:00",self.startTime];
    dict[@"end_date"] =  [NSString stringWithFormat:@"%@ 00:00:00",self.endTime];
    dict[@"num"] = self.numberStr;
    [zkRequestTool networkingPOST:mmerchcouponAdd_coupon_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.footV.hidden = YES;
            self.isAdd = NO;
            [self getDataList];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
    
}

- (void)setYouHuiQuan {
    CGFloat ww = 106;
    CGFloat hh = 72;
    CGFloat space = 20;
    [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int  i = 0 ; i < self.dataArray.count + 1 ; i++) {
        SWTMJAddYouHuiQuanBt * bt  =[[SWTMJAddYouHuiQuanBt alloc] initWithFrame:CGRectMake(space + (space + ww) * i, 20, ww, hh)];
        bt.type = 1;
        
        [self.scrollview addSubview:bt];
        if (i  == self.dataArray.count) {
            self.scrollview.contentSize = CGSizeMake(CGRectGetMaxX(bt.frame) + 20, 110);
            bt.type = 2;
            bt.topLB.text = @"+";
            bt.bottomLB.text = @"添加";
            [bt addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            bt.topLB.text =  [NSString stringWithFormat:@"%@折",self.dataArray[i].rate];
            bt.bottomLB.text =  [NSString stringWithFormat:@"满%@元使用",self.dataArray[i].useprice];
        }
    }
}

- (void)addAction:(UIButton *)button {
    self.isAdd = YES;
    self.jiaGeStr = self.zheKouStr = self.startTime = self.endTime = self.numberStr = @"";
    self.footV.hidden = NO;
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isAdd) {
       return self.titleArr.count;
    }else {
        return 0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTAddYouHuiQuanCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.titleArr[indexPath.row];
    if (indexPath.row == 1) {
        cell.widthCons.constant = 100;
        cell.rightLB.hidden = NO;
    }else {
        cell.widthCons.constant = 300;
        cell.rightLB.hidden = YES;
    }
    if (indexPath.row < 3) {
        cell.TF.userInteractionEnabled = YES;
    }else {
        cell.TF.userInteractionEnabled = NO;
    }
    if (indexPath.row == 0) {
        cell.TF.text =  self.jiaGeStr;
        cell.TF.placeholder = @"请填写";
        cell.TF.keyboardType = UIKeyboardTypeDecimalPad;
    }else if (indexPath.row == 1) {
       cell.TF.text =  self.zheKouStr;
        cell.TF.placeholder = @"0-100资金数";
        cell.TF.keyboardType = UIKeyboardTypeNumberPad;
    }else if (indexPath.row == 2) {
       cell.TF.text =  self.numberStr;
        cell.TF.placeholder = @"请填写";
        cell.TF.keyboardType = UIKeyboardTypeNumberPad;
    }else if (indexPath.row == 3) {
        cell.TF.text = self.startTime;
        cell.TF.placeholder = @"请选择";
    }else if (indexPath.row == 4) {
        cell.TF.text = self.endTime;
        
        cell.TF.placeholder = @"请选择";
    }
    cell.TF.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTAddYouHuiQuanCell * cell = (SWTAddYouHuiQuanCell * )textField.superview.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        self.jiaGeStr = textField.text;
    }else if (indexPath.row == 1) {
        self.zheKouStr = textField.text;
    }else if (indexPath.row == 2) {
        self.numberStr = textField.text;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endEditing:YES];
    if (indexPath.row == 3) {
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.isCanSelectOld = NO;
        selectTimeV.isCanSelectToday = YES;
        Weak(weakSelf);
        selectTimeV.block = ^(NSString *timeStr) {
           
            if (weakSelf.endTime.length != 0) {
                NSTimeInterval number = [NSString pleaseInsertStarTime:[NSString stringWithFormat:@"%@ 00:00:00",timeStr] andInsertEndTime:[NSString stringWithFormat:@"%@ 00:00:00",weakSelf.endTime]];
                if (number < 0) {
                    [SVProgressHUD showErrorWithStatus:@"结束时间要大于等于开时间"];
                    return;
                }else {
                    weakSelf.startTime = timeStr;
                    [weakSelf.tableView reloadData];
                }
                           
            }else {
                weakSelf.startTime = timeStr;
                [weakSelf.tableView reloadData];
            }
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    }else if (indexPath.row == 4) {
        
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.isCanSelectOld = NO;
        selectTimeV.isCanSelectToday = YES;
        Weak(weakSelf);
        selectTimeV.block = ^(NSString *timeStr) {
            if (weakSelf.startTime.length != 0) {
                NSTimeInterval number = [NSString pleaseInsertStarTime: [NSString stringWithFormat:@"%@ 00:00:00",weakSelf.startTime] andInsertEndTime:[NSString stringWithFormat:@"%@ 00:00:00",timeStr]];
                if (number < 0) {
                    [SVProgressHUD showErrorWithStatus:@"结束时间要大于等于开时间"];
                    return;
                }else {
                    weakSelf.endTime = timeStr;
                    [weakSelf.tableView reloadData];
                }
                           
            }else {
                weakSelf.endTime = timeStr;
                [weakSelf.tableView reloadData];
            }
           
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    }
    
}


@end
