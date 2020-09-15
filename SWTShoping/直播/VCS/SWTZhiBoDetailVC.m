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
#import "SWTZhiBoPeopleComeInView.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
#import <PLPlayerKit/PLPlayerKit.h>

@interface SWTZhiBoDetailVC ()<V2TIMAdvancedMsgListener,V2TIMGroupListener,PLPlayerDelegate>
@property(nonatomic , strong)SWTZhiBoHedView *headV; // 头视图
@property(nonatomic , strong)SWTZhiBoBottomView *bottomV;
@property(nonatomic , strong)SWTZhiBoChuJiaBottomView *chuJiaBottomV;

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
@property(nonatomic , strong)SWTZhiBoPeopleComeInView *comeInV;

//推流部分
@property (nonatomic, strong) PLMediaStreamingSession *session;
@property(nonatomic,strong)PLVideoCaptureConfiguration *videoPL;
@property(nonatomic,strong)UIButton *qieHuanCarmerBt;

@property(nonatomic,assign)BOOL isPushVC;

//播流部分
@property (nonatomic, strong) PLPlayer  *player;

@end

@implementation SWTZhiBoDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[V2TIMManager sharedInstance] addAdvancedMsgListener:self];
    
   
    self.isPushVC = NO;
 
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[V2TIMManager sharedInstance] removeAdvancedMsgListener:self];
    if (!self.isPushVC) {
        if (self.isTuiLiu) {
               [self upDateLive];
           }else {
               [self quitAVRoom];
           }
           if (self.player != nil) {
               [self.player stop];
               self.player = nil;
           }
           if (self.session != nil) {
               [self.session destroy];
               self.session = nil;
           }
    }
   
}

-(SWTZhiBoPeopleComeInView *)comeInV {
    if (_comeInV == nil) {
        _comeInV = [[SWTZhiBoPeopleComeInView alloc] init];
    }
    return _comeInV;
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
    [self.view addSubview:self.comeInV];
    self.comeInV.hidden = YES;
    [self.comeInV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.height.equalTo(@30);
        make.width.equalTo(@((ScreenW - 30) / 4 * 3));
        make.bottom.equalTo(self.avChatRoomView.mas_top);
    }];
    
    
     [self getLiveData];//获取合买商品列表
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        self.comeInV.titleLB.text = @"欢迎134*****789进入直播间";
    //        [self.comeInV show];
    //    });
    
    
    //    self.huoDeShowView = [[SWTHuoDeShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    //    [self.huoDeShowView show];
    
    //    SWTPeopleChuJiaVIew * chuajiaV  = [[SWTPeopleChuJiaVIew alloc] initWithFrame:CGRectMake(0, 150, 180, 70)];
    //    [self.view addSubview:chuajiaV];
    self.zhiBoArr = @[].mutableCopy;
    self.heMaiArr = @[].mutableCopy;
    self.mineHeMaiArr = @[].mutableCopy;
    self.AVCharRoomArr = @[].mutableCopy;
    
    if (self.isHeMai) {
        [self getMineHeMaiDingZhiListWithType:0];//获取我的合买列表
        [self getGoodsListData]; //店铺合买列表
    }else {
        [self getLivegoodListDataWithType:0]; //获取竞拍和一口价列表
    }
    
    if (self.isTuiLiu) {
        self.headV.guanzhuBt.hidden = YES;
        self.qieHuanCarmerBt.hidden = NO;
        
    }else {
        self.headV.guanzhuBt.hidden = NO;
        self.qieHuanCarmerBt.hidden = YES;
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
    
    self.qieHuanCarmerBt = [[UIButton alloc] init];
    [self.qieHuanCarmerBt setBackgroundImage:[UIImage imageNamed:@"dyx83"] forState:UIControlStateNormal];
    [self.view addSubview:self.qieHuanCarmerBt];
    [self.qieHuanCarmerBt addTarget:self action:@selector(qieHuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.qieHuanCarmerBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.width.width.equalTo(@50);
        make.top.equalTo(self.headV.mas_bottom).offset(10);
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
                self.heMaiView.dataModel = self.dataModel;
                heMaiV.dataArray = self.heMaiArr;
                self.heMaiView.delegateSignal = [[RACSubject alloc] init];
                @weakify(self);
                [self.heMaiView.delegateSignal subscribeNext:^(NSNumber * x) {
                    @strongify(self);
                    
                    if (x.intValue < 200) {
                        [self.heMaiView dismiss];
                        
                        SWTShopHomeVC * vc =[[SWTShopHomeVC alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        vc.shopId = self.dataModel.merchid;
                        self.isPushVC = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                        return;
                    }
                    
                    [self.heMaiView dismiss];
                    SWTModel * model  = self.heMaiArr[x.intValue-200];
                    //合买提交订单
                    
                    //                    if ([NSString pleaseInsertEndTime:model.endtime] <= 0) {
                    //                        [SVProgressHUD showErrorWithStatus:@"已结束"];
                    //                        return;
                    //                    }
                    
                    SWTMineHeMaiTiJiaoOrderTVC * vc =[[SWTMineHeMaiTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.model = model;
                    self.isPushVC = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    
                }];
                [heMaiV show];
                
                
            }else {
                //直播
                SWTZhiBoJingPaiShowView *  jingPaiV  =[[SWTZhiBoJingPaiShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                jingPaiV.delegateSignal = [[RACSubject alloc] init];
                self.jingPaiV = jingPaiV;
                [self getLivegoodListDataWithType:0];
                @weakify(self);
                [jingPaiV.delegateSignal subscribeNext:^(NSNumber * x) {
                    @strongify(self);
                    if (x.intValue == 99){
                        //店铺
                        [self.jingPaiV dismiss];
                        
                        SWTShopHomeVC * vc =[[SWTShopHomeVC alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        vc.shopId = self.dataModel.merchid;
                        self.isPushVC = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                        
                        
                    }else  if (x.intValue < 102){
                        [self getLivegoodListDataWithType:x.intValue - 100];
                    }else {
                        [self.jingPaiV dismiss];
                        SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                        vc.hidesBottomBarWhenPushed = YES;
                        if (x.intValue - 200 < self.zhiBoArr.count) {
                            vc.goodID = self.zhiBoArr[x.intValue - 200].ID;
                        }
                        self.isPushVC = YES;
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
    dict[@"liveid"] = self.model.ID;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:liveDetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.headV.model = self.dataModel;
            self.bottomV.model = self.dataModel;
            [self jionAVRoom];
            if (self.isTuiLiu) {
                [self addTuiLiuWithType:0];
            }else {
                [self addBoLiu];
            }
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
    dict[@"liveid"] = self.model.ID;
    dict[@"type"] = @(1-type);
    [zkRequestTool networkingPOST:liveLivegoodlist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.zhiBoArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (type == 0) {
                self.jingPaiV.isJiPai = YES;
            }else {
                self.jingPaiV.isJiPai = NO;
            }
            self.jingPaiV.dataArray = self.zhiBoArr;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}
//获取合买列表
- (void)getHeMaiList {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"liveid"] = self.model.ID;
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
    dict[@"liveid"] = self.model.ID;
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

//加入直播室
- (void)jionAVRoom {
    
    V2TIMManager * manager = [V2TIMManager sharedInstance];
    [manager setGroupListener:self];
    [manager joinGroup:self.dataModel.livegroupid msg:@"333" succ:^{
        NSLog(@"%@",@"进入直播间成功");
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"进入直播间失败");
    }];
    
}

- (void)quitAVRoom{
    
    V2TIMManager * manager = [V2TIMManager sharedInstance];
    [manager quitGroup:self.dataModel.livegroupid succ:^{
        NSLog(@"%@",@"退出直播间成功");
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"退出直播间失败");
    }];
}

//发送消息
- (void)sendMessage {
    
    if ([self.dataModel.livegroupid isEqualToString:@"0"] ||  [[NSString stringWithFormat:@"%@",self.dataModel.livegroupid] isEqualToString:@"(null)"]) {
        [SVProgressHUD showErrorWithStatus:@"直播间无效!"];
        return;
    }
    
    V2TIMMessage * cusMsg = [[V2TIMManager sharedInstance] createCustomMessage:[@[@0,self.bottomV.TF.text] mj_JSONData]];
    
    
    [[V2TIMManager sharedInstance] sendMessage:cusMsg receiver:nil groupID:self.dataModel.livegroupid priority:(V2TIM_PRIORITY_DEFAULT) onlineUserOnly:NO offlinePushInfo:nil progress:^(uint32_t progress) {
        
    } succ:^{
        NSLog(@"%@",@"发送成功");
        
        SWTModel * model = [[SWTModel alloc] init];
        model.avatar = [zkSignleTool shareTool].avatar;
        model.content = self.bottomV.TF.text;
        model.nickname = [zkSignleTool shareTool].nickname;
        model.type = @"0";
        model.levelcode = [zkSignleTool shareTool].level;
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
    NSDictionary * userDict = [msg.nickName mj_JSONObject];
    NSData * data  = msg.customElem.data;
    NSArray * arr = [data mj_JSONObject];
    model.nickname = [userDict.allKeys containsObject:@"nickname"] ? userDict[@"nickname"]:@"??";
    model.levelcode = [userDict.allKeys containsObject:@"levelcode"] ? userDict[@"levelcode"]:@"0";
    if (arr.count > 0) {
        if ( [[NSString stringWithFormat:@"%@",arr[0]] isEqualToString:@"0"]) {
            model.type = @"0";
        }else {
            model.type = @"1";
        }
        if (arr.count > 1 ) {
            model.content = arr[1];
        }
    }
    [self.AVCharRoomArr addObject:model];
    self.avChatRoomView.dataArr = self.AVCharRoomArr;
    
}

//有新成员进入到群里面
- (void)onMemberEnter:(NSString *)groupID memberList:(NSArray<V2TIMGroupMemberInfo *>*)memberList {
    
    
    NSLog(@"===list\n%@",memberList);
    
    if (memberList.count > 0) {
        V2TIMGroupMemberInfo * userInfo  = [memberList firstObject];
        NSDictionary * dict = [userInfo.nickName mj_JSONObject];
        NSString * nickname = [dict.allKeys containsObject:@"nickname"] ? dict[@"nickname"] : @"??";
        self.comeInV.titleLB.text =  [NSString stringWithFormat:@"欢迎%@进入直播间",nickname];
        [self.comeInV show];
    }
    
    
    
}
//有成员离开
-(void)onMemberLeave:(NSString *)groupID member:(V2TIMGroupMemberInfo *)member {
    
    
    NSLog(@"%@",@"成员离开了");
    
}

// 收到消息已读回执（仅单聊有效）
- (void)onRecvC2CReadReceipt:(NSArray<V2TIMMessageReceipt *> *)receiptList{
    
    
}

// 收到消息撤回
- (void)onRecvMessageRevoked:(NSString *)msgID {
    
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}


//收藏操作

//关注操作
- (void)gaunZhuActionwithType:(NSInteger)type {
    
    
    if (self.isTuiLiu) {
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    dict[@"type"] = @(type);
    if (type == 1) {
        dict[@"id"] = self.dataModel.merchid;
    }else {
        dict[@"id"] = self.dataModel.liveid;
    }
    dict[@"userid"] =[zkSignleTool shareTool].session_uid;
    [zkRequestTool networkingPOST:userFollowOperate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (type == 1) {
                if ([self.dataModel.merchisfollow isEqualToString:@"no"]) {
                    [SVProgressHUD showSuccessWithStatus:@"关注店铺成功"];
                    self.dataModel.merchisfollow = @"yes";
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"取消关注店铺"];
                    self.dataModel.merchisfollow = @"no";
                }
                self.bottomV.model = self.dataModel;
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
                
                self.headV.model = self.dataModel;
                
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
//添加播流
- (void)addBoLiu {
    
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    [option setOptionValue:@2000 forKey:PLPlayerOptionKeyMaxL1BufferDuration];
    [option setOptionValue:@1000 forKey:PLPlayerOptionKeyMaxL2BufferDuration];
    [option setOptionValue:@(NO) forKey:PLPlayerOptionKeyVideoToolbox];
    [option setOptionValue:@(kPLLogInfo) forKey:PLPlayerOptionKeyLogLevel];
    NSURL *url = [NSURL URLWithString:self.dataModel.rtmpurl];
    
    
    
    self.player = [PLPlayer playerWithURL:url option:option];
    
    self.player.delegate = self;
    
    [self.view addSubview:self.player.playerView];
    [self.view sendSubviewToBack:self.player.playerView];
    
    [self.player play];
    
    
    
}



//添加推流
- (void)addTuiLiuWithType:(NSInteger)type {
    
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    if (type == 1) {
        self.videoPL.streamMirrorFrontFacing = YES;
        self.videoPL.streamMirrorRearFacing = NO;
        videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
    }else {
         self.videoPL.streamMirrorRearFacing = YES;
        self.videoPL.streamMirrorFrontFacing = NO;
        videoCaptureConfiguration.position = AVCaptureDevicePositionBack;
    }
//    self.videoPL = videoCaptureConfiguration;
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
    
    
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];
    self.session.autoReconnectEnable = YES;
    
    [self.view addSubview:self.session.previewView];
    [self.view sendSubviewToBack:self.session.previewView];
    
    NSURL *pushURL = [NSURL URLWithString:self.dataModel.pushurl];
    [self.session startStreamingWithPushURL:pushURL feedback:^(PLStreamStartStateFeedback feedback) {
        if (feedback == PLStreamStartStateSuccess) {
            NSLog(@"Streaming started.");
            
            NSLog(@"%@",@"44444444444444444444");
            
        }
        else {
            NSLog(@"Oops.");
        }
    }];
    
//    
//    [PLMediaStreamingSession checkAuthentication:^(PLAuthenticationResult result) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSString *message;
//            switch (result) {
//                case PLAuthenticationResultNotDetermined:
//                    message = @"还未授权！";
//                    break;
//                case PLAuthenticationResultDenied:
//                    message = @"授权失败！";
//                    break;
//                case PLAuthenticationResultAuthorized:{
//                    message = @"授权成功！";
//                    
//                    
//                }
//                    break;
//                default:
//                    break;
//            }
//        });
//    }];
    
    
    
}

- (void)qieHuanAction:(UIButton *)button {
    button.selected = !button.selected;
    [self.session destroy];
    if (button.selected) {
        [self addTuiLiuWithType:1];
//         self.videoPL.position = AVCaptureDevicePositionBack;
//        [self.session startCaptureSession];
//        self.videoPL.streamMirrorRearFacing = YES;
//        self.videoPL.streamMirrorFrontFacing = NO;
    }else {
       [self addTuiLiuWithType:0];
//        self.videoPL.position = AVCaptureDevicePositionFront;
//        [self.session startCaptureSession];
//        self.videoPL.streamMirrorFrontFacing = YES;
//        self.videoPL.streamMirrorRearFacing = NO;
    }
}


/**
 告知代理对象 PLPlayer 即将开始进入后台播放任务
 
 @param player 调用该代理方法的 PLPlayer 对象
 
 @since v1.0.0
 */
- (void)playerWillBeginBackgroundTask:(nonnull PLPlayer *)player{
    NSLog(@"%@",@"00002334");
}

/**
 告知代理对象 PLPlayer 即将结束后台播放状态任务
 
 @param player 调用该方法的 PLPlayer 对象
 
 @since v2.1.1
 */
- (void)playerWillEndBackgroundTask:(nonnull PLPlayer *)player{
    NSLog(@"%@",@"11112334");
}

/**
 告知代理对象播放器状态变更
 
 @param player 调用该方法的 PLPlayer 对象
 @param state  变更之后的 PLPlayer 状态
 
 @since v1.0.0
 */
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state{
    NSLog(@"%@",@"2334");
}

/**
 告知代理对象播放器因错误停止播放
 
 @param player 调用该方法的 PLPlayer 对象
 @param error  携带播放器停止播放错误信息的 NSError 对象
 
 @since v1.0.0
 */
- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error{
    NSLog(@"error===%@",error);
    
    
}

/**
 点播已缓冲区域
 
 @param player 调用该方法的 PLPlayer 对象
 @param timeRange  CMTime , 表示从0时开始至当前缓冲区域，单位秒。
 
 @warning 仅对点播有效
 
 @since v2.4.1
 */
- (void)player:(nonnull PLPlayer *)player loadedTimeRange:(CMTime)timeRange{
    NSLog(@"%@",@"44442334");
}

/**
 回调将要渲染的帧数据
 该功能只支持直播
 
 @param player 调用该方法的 PLPlayer 对象
 @param frame 将要渲染帧 YUV 数据。
 CVPixelBufferGetPixelFormatType 获取 YUV 的类型。
 软解为 kCVPixelFormatType_420YpCbCr8Planar.
 硬解为 kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange.
 @param pts 显示时间戳 单位ms
 @param sarNumerator
 @param sarDenominator
 其中sar 表示 storage aspect ratio
 视频流的显示比例 sarNumerator sarDenominator
 @discussion sarNumerator = 0 表示该参数无效
 
 @since v2.4.3
 */
- (void)player:(nonnull PLPlayer *)player willRenderFrame:(nullable CVPixelBufferRef)frame pts:(int64_t)pts sarNumerator:(int)sarNumerator sarDenominator:(int)sarDenominator{
    NSLog(@"%@",@"55552334");
}

//是直播时离开直播间关闭直播

- (void)upDateLive {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.dataModel.merchid;
    dict[@"type"] = @2;
    [zkRequestTool networkingPOST:merchliveUpd_live_status_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
}

@end
