//
//  SWTZhiBoDetailVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoDetailVC.h"
#import "SWTZhiBoHedView.h"
#import "SWTZhiBoBottomView.h"
#import "SWTMineHeMaiTiJiaoOrderTVC.h"
#import "SWTZhiBoChuJiaBottomView.h"
#import "SWTHeMaiDianPuShowVIew.h"
#import "SWTZhiBoJingPaiShowView.h"
@interface SWTZhiBoDetailVC ()
@property(nonatomic , strong)SWTZhiBoHedView *headV;
@property(nonatomic , strong)SWTZhiBoBottomView *bottomV;
@property(nonatomic , strong)SWTZhiBoChuJiaBottomView *chuJiaBottomV;


@end

@implementation SWTZhiBoDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self addCha];
    [self addHeadV];
    [self addBottomV];
    [self addChuJiaBottomV];
    self.chuJiaBottomV.hidden = YES;

}

- (void)addCha {
    
    UIButton * closeBt  =[[UIButton alloc] init];
    [closeBt setImage:[UIImage imageNamed:@"chaw"] forState:UIControlStateNormal];
    [closeBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBt];
    
    [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@30);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(sstatusHeight);
    }];
}

- (void)addHeadV {
    self.headV  = [[SWTZhiBoHedView alloc] init];
    [self.view addSubview:self.headV];
    [self.headV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(sstatusHeight + 5);
        make.right.equalTo(self.view).offset(-45);
        make.height.equalTo(@45);
    }];
}

- (void)addBottomV {
    self.bottomV = [[SWTZhiBoBottomView alloc] init];
    self.bottomV.isHeMai = self.isHeMai;
    [self.view addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@65);
        if (sstatusHeight > 20) {
            make.bottom.equalTo(self.view).offset(-34);
        }else {
            make.bottom.equalTo(self.view);
        }
    }];
    
     self.bottomV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [ self.bottomV.delegateSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        if (x.intValue == 0) {
            //点击购物车
            self.bottomV.hidden = YES;
            self.chuJiaBottomV.hidden = NO;
            
            
        }else if (x.intValue == 1) {
            //合买定制
            SWTMineHeMaiTiJiaoOrderTVC * vc =[[SWTMineHeMaiTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else if (x.intValue == 2) {
            //分享
            SWTHeMaiDianPuShowVIew *  dingzhiV  =[[SWTHeMaiDianPuShowVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [dingzhiV show];
        }else if (x.intValue == 3){
            //收藏
            SWTZhiBoJingPaiShowView *  jingPaiV  =[[SWTZhiBoJingPaiShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [jingPaiV show];
        }
        
        
    }];
}

- (void)addChuJiaBottomV {
    
    self.chuJiaBottomV = [[SWTZhiBoChuJiaBottomView alloc] init];
    [self.view addSubview:self.chuJiaBottomV];
    [self.chuJiaBottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@65);
        if (sstatusHeight > 20) {
            make.bottom.equalTo(self.view).offset(-34);
        }else {
            make.bottom.equalTo(self.view);
        }
    }];
    
    
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
