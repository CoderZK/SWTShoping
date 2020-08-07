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
#import "SWTHuoDeShowView.h"
#import "SWTPeopleChuJiaVIew.h"
@interface SWTZhiBoDetailVC ()<V2TIMAdvancedMsgListener>
@property(nonatomic , strong)SWTZhiBoHedView *headV;
@property(nonatomic , strong)SWTZhiBoBottomView *bottomV;
@property(nonatomic , strong)SWTZhiBoChuJiaBottomView *chuJiaBottomV;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *heMaiArr;
@property(nonatomic , strong)NSString *groupId;
@property(nonatomic , strong)SWTHuoDeShowView *huoDeShowView;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *zhiBoArr;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , strong)SWTZhiBoJingPaiShowView *jingPaiV;

@end

@implementation SWTZhiBoDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[V2TIMManager sharedInstance] addAdvancedMsgListener:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[V2TIMManager sharedInstance] removeAdvancedMsgListener:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self addCha];
    [self addHeadV];
    [self addBottomV];
    [self addChuJiaBottomV];
    self.chuJiaBottomV.hidden = YES;
    [self getGoodsListData];
    
    [self creaeteAVRoom];
    
    //    self.huoDeShowView = [[SWTHuoDeShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    //    [self.huoDeShowView show];
    
    SWTPeopleChuJiaVIew * chuajiaV  = [[SWTPeopleChuJiaVIew alloc] initWithFrame:CGRectMake(0, 150, 180, 70)];
    [self.view addSubview:chuajiaV];
    self.zhiBoArr = @[].mutableCopy;
    self.heMaiArr = @[].mutableCopy;
    [self getLiveData];
    [self getLivegoodListDataWithType:0];
    
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
           //变化底部状态栏
//            self.bottomV.hidden = YES;
//            self.chuJiaBottomV.hidden = NO;
            
             //点击购物车
            if (self.isHeMai) {
                //合买
                
            }else {
                //直播
                SWTZhiBoJingPaiShowView *  jingPaiV  =[[SWTZhiBoJingPaiShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                jingPaiV.delegateSignal = [[RACSubject alloc] init];
                self.jingPaiV = jingPaiV;
                @weakify(self);
                [jingPaiV.delegateSignal subscribeNext:^(NSNumber * x) {
                    @strongify(self);
                    if (x.intValue == 99){
                        //店铺
                    }else  {
                        [self getLivegoodListDataWithType:x.intValue - 100];
                    }
                    
                    
                }];
                jingPaiV.dataModel = self.dataModel;
                jingPaiV.dataArray = self.zhiBoArr;
                [jingPaiV show];
            }
            
            
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
            
        }else if (x.intValue == 100) {
            //点击发送按钮
            [self sendMessage];
        }
        
        
    }];
}

- (void)getLiveData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"liveid"] = self.model.ID;
    [zkRequestTool networkingPOST:liveDetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];

    
}

//获取直播中的镜片列表
- (void)getLivegoodListDataWithType:(NSInteger)type {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
//    dict[@"liveid"] = self.model.ID;
    dict[@"liveid"] = @"15";
    dict[@"type"] = @(type);
    [zkRequestTool networkingPOST:liveLivegoodlist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
  
        
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD dismiss];
            self.zhiBoArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
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


- (void)getGoodsListData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"liveid"] = self.model.ID;
    [zkRequestTool networkingPOST:shareGoodlist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.zhiBoArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
}

//创建直播室
- (void)creaeteAVRoom {
    V2TIMManager * manager = [V2TIMManager sharedInstance];
    [manager joinGroup:@"@TGS#aG55HCUGH" msg:@"333" succ:^{
        NSLog(@"%@",@"进入直播间成功");
        self.groupId = @"@TGS#aG55HCUGH";
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"进入直播间失败");
    }];
    
    
    
    
}
//发送消息
- (void)sendMessage {
    
    V2TIMMessage * msg = [[V2TIMManager sharedInstance] createTextMessage:self.bottomV.TF.text];
    
    [[V2TIMManager sharedInstance] sendMessage:msg receiver:nil groupID:self.groupId priority:(V2TIM_PRIORITY_DEFAULT) onlineUserOnly:NO offlinePushInfo:nil progress:^(uint32_t progress) {
        
    } succ:^{
        NSLog(@"%@",@"发送成功");
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"发送失败");
    }];
    
}


/// 收到新消息
- (void)onRecvNewMessage:(V2TIMMessage *)msg{
    NSLog(@"message === \n %@",msg);
}

/// 收到消息已读回执（仅单聊有效）
- (void)onRecvC2CReadReceipt:(NSArray<V2TIMMessageReceipt *> *)receiptList{
    
    
}

/// 收到消息撤回
- (void)onRecvMessageRevoked:(NSString *)msgID {
    
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
