//
//  SWTMineZiLiaoVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineZiLiaoVC.h"
#import "SWTMineZiLiaoCell.h"
#import "SWTMineAddressTVC.h"
#import "SWTEditPasswordVC.h"
@interface SWTMineZiLiaoVC ()<zkPickViewDelelgate>
@property(nonatomic , strong)NSArray *leftArr;
@property(nonatomic , strong)UIView *footV;
@end

@implementation SWTMineZiLiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineZiLiaoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.leftArr = @[@"头像",@"昵称",@"性别",@"收货地址",@"支付安全",@"修改密码"];
    [self initFV];
}

- (void)initFV {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    UIButton * loginOutBt  =[[UIButton alloc] initWithFrame:CGRectMake(40, 40, ScreenW - 80, 45)];
    [loginOutBt setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    loginOutBt.layer.cornerRadius = 22.5;
    loginOutBt.clipsToBounds = YES;
    [self.footV addSubview:loginOutBt];
    [loginOutBt setTitle:@"退出登录" forState:UIControlStateNormal];
    loginOutBt.titleLabel.font = kFont(14);
    [[loginOutBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        
        
        
    }];
    self.tableView.tableFooterView = self.footV;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineZiLiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.leftArr[indexPath.row];
    cell.rightLB.hidden = NO;
    cell.rightImgV.hidden = YES;
    cell.rightLB.hidden = YES;
    if (indexPath.row == 0) {
        cell.rightImgV.hidden = NO;
    }else if (indexPath.row == 1){
        cell.rightLB.hidden = NO;
        cell.rightLB.text = [zkSignleTool shareTool].nickname;
    }else if (indexPath.row == 2){
        cell.rightLB.hidden = NO;
        if (self.genderStr.length == 0 ) {
            cell.rightLB.text = @"去设置";
        }else if (self.genderStr.intValue == 1) {
            cell.rightLB.text = @"男";
        }else {
            cell.rightLB.text = @"女";
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    if (indexPath.row == 1) {
        
        [self editNickName];
    }else if (indexPath.row == 2) {
        zkPickView * pickV = [[zkPickView alloc] init];
        pickV.arrayType = titleArray;
        pickV.array = @[@"男",@"女"].mutableCopy;
        [pickV show];
        pickV.delegate = self;
    }else if (indexPath.row == 3) {
        SWTMineAddressTVC * vc =[[SWTMineAddressTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4) {
        
    }else if (indexPath.row == 5) {
        SWTEditPasswordVC * vc =[[SWTEditPasswordVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    
    
    
}


- (void)editNickName  {
    
    UIAlertController  * alertVC = [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField*userNameTF = alertController.textFields.firstObject;
           
            
            
        }]];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
            
            textField.placeholder=@"请输入昵称";
            
            
            
        }];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];

    }];
    
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    
}

@end
