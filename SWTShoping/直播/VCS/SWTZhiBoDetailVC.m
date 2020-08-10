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
#import "SWTHeMaiMineDingZhiShowView.h"
#import "SWTAVChatRoomView.h"
@interface SWTZhiBoDetailVC ()<V2TIMAdvancedMsgListener>
@property(nonatomic , strong)SWTZhiBoHedView *headV; // 头视图
@property(nonatomic , strong)SWTZhiBoBottomView *bottomV;
@property(nonatomic , strong)SWTZhiBoChuJiaBottomView *chuJiaBottomV;

@property(nonatomic , strong)NSString *groupId;
@property(nonatomic , strong)SWTHuoDeShowView *huoDeShowView;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *heMaiArr; // 直播接合买列表
@property(nonatomic , strong)NSMutableArray<SWTModel *> *zhiBoArr;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *mineHeMaiArr; //我的合买
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , strong)SWTZhiBoJingPaiShowView *jingPaiV;
@property(nonatomic , strong)SWTHeMaiDianPuShowVIew *heMaiView;
@property(nonatomic , strong)SWTHeMaiMineDingZhiShowView *dingZHiView;
@property(nonatomic , strong)SWTAVChatRoomView *avChatRoomView;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *AVCharRoomArr;
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
    [self initChatRoomV];
    self.chuJiaBottomV.hidden = YES;
    
    
    [self creaeteAVRoom];
    
    //    self.huoDeShowView = [[SWTHuoDeShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    //    [self.huoDeShowView show];
    
    SWTPeopleChuJiaVIew * chuajiaV  = [[SWTPeopleChuJiaVIew alloc] initWithFrame:CGRectMake(0, 150, 180, 70)];
    [self.view addSubview:chuajiaV];
    self.zhiBoArr = @[].mutableCopy;
    self.heMaiArr = @[].mutableCopy;
    self.mineHeMaiArr = @[].mutableCopy;
    self.AVCharRoomArr = @[].mutableCopy;
    [self getLiveData];//获取合买商品列表
    if (self.isHeMai) {
        [self getMineHeMaiDingZhiListWithType:0];//获取我的合买列表
        [self getGoodsListData]; //店铺合买列表
    }else {
        [self getLivegoodListDataWithType:0]; //获取竞拍和一口价列表
    }
    
    
    
    
    
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
    [[self.headV.guanzhuBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self gaunZhuActionwithType:0];
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
                SWTHeMaiDianPuShowVIew *  heMaiV  =[[SWTHeMaiDianPuShowVIew alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                self.heMaiView = heMaiV;
                heMaiV.dataArray = self.heMaiArr;
                self.heMaiView.delegateSignal = [[RACSubject alloc] init];
                @weakify(self);
                [self.heMaiView.delegateSignal subscribeNext:^(NSNumber * x) {
                    @strongify(self);
                    [self.heMaiView dismiss];
                    SWTModel * model  = self.heMaiArr[x.intValue-200];
                    //合买提交订单
                    SWTMineHeMaiTiJiaoOrderTVC * vc =[[SWTMineHeMaiTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.model = model;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }];
                [heMaiV show];
                
                
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
                        [self.jingPaiV dismiss];
                    }else  if (x.intValue < 102){
                        [self getLivegoodListDataWithType:x.intValue - 100];
                    }else {
                        [self.jingPaiV dismiss];
                        SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                        vc.hidesBottomBarWhenPushed = YES;
                        if (x.intValue - 200 < self.zhiBoArr.count) {
                            vc.goodID = self.zhiBoArr[x.intValue - 200].ID;
                        }
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                    
                    
                }];
                jingPaiV.dataModel = self.dataModel;
                jingPaiV.dataArray = self.zhiBoArr;
                [jingPaiV show];
            }
            
            
        }else if (x.intValue == 1) {
            //我的合买
            SWTHeMaiMineDingZhiShowView *  dingZhiV  =[[SWTHeMaiMineDingZhiShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            dingZhiV.delegateSignal = [[RACSubject alloc] init];
            self.dingZHiView = dingZhiV;
            self.dingZHiView.dataArray = self.mineHeMaiArr;
            @weakify(self);
            [dingZhiV.delegateSignal subscribeNext:^(NSNumber * x) {
                @strongify(self);
                if (x.intValue < 102) {
                    [self getMineHeMaiDingZhiListWithType:x.intValue - 100];
                }else {
                    
                }
                
            }];
            [dingZhiV show];
            
        }else if (x.intValue == 2) {
            //分享
            
        }else if (x.intValue == 3){
            //收藏
            [self gaunZhuActionwithType:1];
        }else if (x.intValue == 100) {
            //点击发送按钮
            [self sendMessage];
        }
        
        
    }];
}
//获取直播详情
- (void)getLiveData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    //    dict[@"liveid"] = self.model.ID;
    dict[@"liveid"] = @"15";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:liveDetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.headV.model = self.dataModel;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
//我的合买
- (void)getMineHeMaiDingZhiListWithType:(NSInteger)type {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    //    dict[@"liveid"] = self.model.ID;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"status"] = @(type+1);
    [zkRequestTool networkingPOST:shareMyshare_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.mineHeMaiArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.dingZHiView.dataArray = self.mineHeMaiArr;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
}

//获取直播中的竞拍列表
- (void)getLivegoodListDataWithType:(NSInteger)type {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    //    dict[@"liveid"] = self.model.ID;
    dict[@"liveid"] = @"15";
    dict[@"type"] = @(type);
    [zkRequestTool networkingPOST:liveLivegoodlist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.zhiBoArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.jingPaiV.dataArray = self.zhiBoArr;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}
//获取合买列表
- (void)getHeMaiList {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    //    dict[@"liveid"] = self.model.ID;
    dict[@"liveid"] = @"15";
    [zkRequestTool networkingPOST:shareGoodlist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.heMaiArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.heMaiView.dataArray = self.heMaiArr;
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
    //    dict[@"liveid"] = self.model.ID;
    dict[@"liveid"] = @"15";
    [zkRequestTool networkingPOST:shareGoodlist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.heMaiArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
        
        SWTModel * model = [[SWTModel alloc] init];
        model.avatar = @"123456789";
        model.content = self.bottomV.TF.text;
        model.nickname = [zkSignleTool shareTool].nickname;
        model.growth_value = [zkSignleTool shareTool].growth_value;
        [self.AVCharRoomArr addObject:model];
        self.avChatRoomView.dataArr = self.AVCharRoomArr;
        
        
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"发送失败");
    }];
    
}


/// 收到新消息
- (void)onRecvNewMessage:(V2TIMMessage *)msg{
    NSLog(@"message === \n %@",msg);
    SWTModel * model = [[SWTModel alloc] init];
    model.avatar = msg.faceURL;
    model.content = msg.textElem.text;
    model.nickname = msg.nickName;
    [self.AVCharRoomArr addObject:model];
    self.avChatRoomView.dataArr = self.AVCharRoomArr;
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


//收藏操作

//关注操作
- (void)gaunZhuActionwithType:(NSInteger)type {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    dict[@"type"] = @(type);
    if (type == 0) {
        dict[@"id"] = self.dataModel.merchid;
    }else {
        dict[@"id"] = self.dataModel.liveid;
    }
    dict[@"userid"] =[zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:userFollowOperate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (type == 0) {
                if ([self.dataModel.merchisfollow isEqualToString:@"no"]) {
                    [SVProgressHUD showSuccessWithStatus:@"关注店铺成功"];
                    self.dataModel.merchisfollow = @"yes";
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"取消关注店铺"];
                    self.dataModel.merchisfollow = @"no";
                }
                self.headV.model = self.dataModel;
            }else  {
                if ([self.dataModel.liveisfollow isEqualToString:@"no"]) {
                    [SVProgressHUD showSuccessWithStatus:@"关注直播成功"];
                    self.dataModel.liveisfollow = @"yes";
                     [self.bottomV.collectBt setBackgroundImage:[UIImage imageNamed:@"collectY"] forState:UIControlStateNormal];
                    
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"取消关注直播"];
                    self.dataModel.liveisfollow = @"no";
                     [self.bottomV.collectBt setBackgroundImage:[UIImage imageNamed:@"collectN"] forState:UIControlStateNormal];
                }
             
               
                
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
    
    
}


- (void)initChatRoomV {
    
    self.avChatRoomView = [[SWTAVChatRoomView alloc] init];
    [self.view addSubview:self.avChatRoomView];
    [self.avChatRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomV.mas_top).offset(-30);
        make.height.equalTo(@(ScreenH/2.0));
    }];
    
}



@end
