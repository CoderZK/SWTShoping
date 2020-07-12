//
//  SWTLaoYouDianPuInfoTwoTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouDianPuInfoTwoTVC.h"
#import "SWTDianPuInfoView.h"
#import "SWTDianPuInfoTwoView.h"
@interface SWTLaoYouDianPuInfoTwoTVC ()
@property(nonatomic , strong)SWTDianPuInfoView *shopTyepV,*shopOwnerV,*shopLeiV,*shopNameV,*shopNumberV;
@property(nonatomic , strong)UIView *headView;
@property(nonatomic , strong)UIButton *nextBt;
@property(nonatomic , strong)SWTDianPuInfoTwoView *zhengV,*fanV,*shouChiV;
@end

@implementation SWTLaoYouDianPuInfoTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺认证";
    [self initSubV];
}

- (void)initSubV {
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    self.tableView.tableHeaderView = self.headView;
    CGFloat hh = 50;
    self.shopTyepV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
       self.shopTyepV.leftLB.text = @"店铺类型";
       self.shopTyepV.rightTF.placeholder = @"请选择";
       [self.headView addSubview:self.shopTyepV];
    
    
    self.shopOwnerV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopTyepV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
    self.shopOwnerV.leftLB.text = @"经营主体";
    self.shopOwnerV.rightTF.placeholder = @"请选择";
    [self.headView addSubview:self.shopOwnerV];
    
    self.shopLeiV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopOwnerV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
    self.shopLeiV.leftLB.text = @"主营类目";
    self.shopLeiV.rightTF.placeholder = @"请选择";
    [self.headView addSubview:self.shopLeiV];
    
    self.shopNameV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopLeiV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
    self.shopNameV.leftLB.text = @"真实姓名";
    self.shopNameV.rightTF.placeholder = @"请选择";
    [self.headView addSubview:self.shopNameV];
    
    
    self.shopNumberV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopNameV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
    self.shopNumberV.leftLB.text = @"身份证号";
    self.shopNumberV.rightTF.placeholder = @"请选择";
    [self.headView addSubview:self.shopNumberV];
    

    
    
  
    
    UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.shopNumberV.frame) + 10, ScreenW - 20, 20)];
    lb.textColor = CharacterColor102;
    lb.font = kFont(14);
    lb.text = @"认证信息";
    [self.headView addSubview:lb];
    
    self.zhengV = [[SWTDianPuInfoTwoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lb.frame) + 10, ScreenW - 20, 50 + 100)];
    self.zhengV.titleLB.text = @"请上传省份证人像面";
    [self.headView addSubview:self.zhengV];
    
    self.fanV = [[SWTDianPuInfoTwoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.zhengV.frame), ScreenW - 20, CGRectGetHeight(self.zhengV.frame))];
    self.fanV.titleLB.text = @"请上传省份证国徽面";
    [self.headView addSubview:self.fanV];
    
    self.shouChiV = [[SWTDianPuInfoTwoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.fanV.frame), ScreenW - 20, CGRectGetHeight(self.zhengV.frame))];
    self.shouChiV.titleLB.text = @"请上传手持身份照";
    [self.headView addSubview:self.shouChiV];
    
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.shouChiV.frame) + 40, ScreenW - 80, 40)];
      [button setTitle:@"下一步" forState:UIControlStateNormal];
      button.titleLabel.font = kFont(14);
      [button setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
      button.layer.cornerRadius = 20;
      button.clipsToBounds = YES;
      [self.headView addSubview:button];
      
      @weakify(self);
      [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
          @strongify(self);
          
          
      }];
    self.nextBt = button;
    
    self.headView.mj_h = CGRectGetMaxY(self.nextBt.frame) + 40;
}
@end
