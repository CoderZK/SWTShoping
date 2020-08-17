//
//  SWTAddMineChanPinKuTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAddMineChanPinKuTVC.h"
#import "SWTMineShopSettingCell.h"
#import "SWTAddChanPinOneCellCell.h"
#import "SWTAddChanPinHeadView.h"
@interface SWTAddMineChanPinKuTVC ()<UITextFieldDelegate>
@property(nonatomic , strong)NSString *bianHaoStr,*kuCunStr,*diJiaStr,*jiaJiaStr,*timeStr;
@end

@implementation SWTAddMineChanPinKuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增产品";
    
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
          button.titleLabel.font = kFont(13);
          [button setTitle:@"提交" forState:UIControlStateNormal];
          button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
          [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
          @weakify(self);
          [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
              @strongify(self);
              //点击提交
              
         
              
              
          }];
          
          self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineShopSettingCell" bundle:nil] forCellReuseIdentifier:@"SWTMineShopSettingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTAddChanPinOneCellCell" bundle:nil] forCellReuseIdentifier:@"SWTAddChanPinOneCellCell"];
    
    [self addHeadV];

    
}

- (void)addHeadV  {
    SWTAddChanPinHeadView * headV  = [[SWTAddChanPinHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    headV.mj_h = headV.HHHH;
    headV.picArr = @[].mutableCopy;
    headV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [headV.delegateSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        
        if (x.intValue < 150) {
            if (x.intValue == 100) {
                //产品类别
            }else if (x.intValue == 101) {
                //品名
            }
        }else {
           if (x.intValue == 198) {
                //添加视频
            }else if (x.intValue == 199) {
                //添加图片
            }else {
                //删除图片
            }
        }
        
    }];
    self.tableView.tableHeaderView = headV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;;
    }else if (section == 1) {
        return 2 + 2;
    }else {
        return 4;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 40;
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineShopSettingCell" forIndexPath:indexPath];
        cell.rightTF.userInteractionEnabled = YES;
        cell.rightImgV.hidden = YES;
        cell.leftwoLB.hidden = YES;
        cell.swithBt.hidden = YES;
        cell.rightTF.placeholder = @"请填写";
        cell.rightTF.delegate = self;
        if (indexPath.row == 0) {
            cell.leftLB.text = @"编号";
            cell.rightTF.text = self.bianHaoStr;
        }else {
            cell.rightTF.text = self.kuCunStr;
            cell.leftLB.text = @"库存";
        }
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return cell;
    }else if (indexPath.section == 1) {
        SWTAddChanPinOneCellCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTAddChanPinOneCellCell" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (indexPath.row == 0) {
            cell.type = 0;
        }else if (indexPath.row == 3) {
            cell.type = 2;
        }else {
            cell.type = 1;
        }
        return cell;
    }else {
       SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineShopSettingCell" forIndexPath:indexPath];
        cell.rightTF.userInteractionEnabled = YES;
        cell.rightImgV.hidden = YES;
        cell.rightTF.placeholder = @"请填写";
        cell.rightTF.delegate = self;
        cell.swithBt.hidden = YES;
        cell.leftwoLB.hidden = YES;
        
        if (indexPath.row == 0) {
            cell.leftLB.text = @"底价";
            cell.rightTF.text = self.diJiaStr;
        }else if (indexPath.row == 1){
            cell.leftLB.text = @"加价幅度";
            cell.rightTF.text = self.jiaJiaStr;
        }else if (indexPath.row == 2){
            cell.leftLB.text = @"时间";
            cell.rightTF.placeholder = @"请选择";
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.text = self.timeStr;
        }else if (indexPath.row == 3){
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.placeholder = @"";
            cell.leftLB.text = @"包邮";
            cell.swithBt.hidden = NO;
        }
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return cell;
    }

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTMineShopSettingCell * cell  = (SWTMineShopSettingCell *)textField.superview.superview;
    NSIndexPath * indexPath  = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
                   self.bianHaoStr = textField.text;
               }else if (indexPath.row == 1) {
                   self.kuCunStr = textField.text;
               }
    }else if (indexPath.section == 1) {
        
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.diJiaStr = textField.text;
        }else if (indexPath.row == 1) {
            self.jiaJiaStr = textField.text;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end
