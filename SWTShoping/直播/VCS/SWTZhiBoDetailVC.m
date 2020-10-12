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
#import "SWTZhiBoFootView.h"
#import "SWTJiShiFaBuView.h"
#import "SWTZhiBoYiKouJiaFootView.h"
#import "SWTZhiBoJiaPaiFootView.h"
#import "SWTZhiBoGeRenShowView.h"
#import "SWTTiJiaoOrderTVC.h"
@interface SWTZhiBoDetailVC ()<V2TIMAdvancedMsgListener,V2TIMGroupListener,PLPlayerDelegate,SWTZhiBoGeRenShowViewDelegate>
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
@property(nonatomic,strong)SWTZhiBoFootView *zhiBoFootV;
@property(nonatomic,strong)SWTZhiBoYiKouJiaFootView *yiKouJiaFootView;
@property(nonatomic,strong)SWTZhiBoYiKouJiaFootView *siJiaFootV;
@property(nonatomic,strong)SWTZhiBoJiaPaiFootView *jingPaiFootV;
//推流部分
@property (nonatomic, strong) PLMediaStreamingSession *session;
@property(nonatomic,strong)PLVideoCaptureConfiguration *videoPL;
@property(nonatomic,strong)UIButton *qieHuanCarmerBt;

@property(nonatomic,assign)BOOL isPushVC;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)SWTJiShiFaBuView *shishiView;
@property(nonatomic,strong)SWTModel *shishiModel,*siJiaModel;
//播流部分
@property (nonatomic, strong) PLPlayer  *player;
@property(nonatomic,strong)NSString *jingPaiJiaGeStr;

@end

@implementation SWTZhiBoDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[V2TIMManager sharedInstance] addAdvancedMsgListener:self];
    
    if (self.dataModel != nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(getNumberAction) userInfo:nil repeats:YES];
    }
    
    self.isPushVC = NO;
    
}


- (SWTZhiBoFootView *)zhiBoFootV {
    if (_zhiBoFootV == nil) {
        _zhiBoFootV = [[SWTZhiBoFootView alloc] initWithFrame:CGRectMake(0, 0, (ScreenW -30)/4 * 3, 110)];
        _zhiBoFootV.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [_zhiBoFootV.delegateSignal subscribeNext:^(NSNumber * x) {
            @strongify(self);
            
            SWTModel * model  = [self.heMaiArr firstObject];
            SWTMineHeMaiTiJiaoOrderTVC * vc =[[SWTMineHeMaiTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            model.merchid = self.dataModel.merchid;
            model.store_name = self.dataModel.name;
            vc.model = model;
            self.isPushVC = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    return _zhiBoFootV;
}


- (SWTZhiBoYiKouJiaFootView *)yiKouJiaFootView {
    if (_yiKouJiaFootView == nil) {
        _yiKouJiaFootView = [[SWTZhiBoYiKouJiaFootView alloc] initWithFrame:CGRectMake(0, 0, (ScreenW -30)/4 * 3, 110)];
        _yiKouJiaFootView.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [_yiKouJiaFootView.delegateSignal subscribeNext:^(SWTModel * x) {
            @strongify(self);
            
            SWTTiJiaoOrderTVC * vc =[[SWTTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            //                    vc.moneyStr =  [NSString stringWithFormat:@"%0.2f",x.intValue * self.dataModel.price.floatValue];
            vc.numStr = @"1";
            vc.goodID = self.shishiModel.ID;
            vc.merchID = self.dataModel.merchid;
            self.shishiModel.goodid = self.shishiModel.ID;
            self.shishiModel.goodprice = self.shishiModel.price;
            self.shishiModel.goodimg = self.shishiModel.img;
            vc.model = self.shishiModel;
            [self.navigationController pushViewController:vc animated:YES];
            
        }];
    }
    return _yiKouJiaFootView;
}

- (SWTZhiBoYiKouJiaFootView *)siJiaFootV {
  if (_siJiaFootV == nil) {
            _siJiaFootV = [[SWTZhiBoYiKouJiaFootView alloc] initWithFrame:CGRectMake(0, 0, (ScreenW -30)/4 * 3, 110)];
            _siJiaFootV.delegateSignal = [[RACSubject alloc] init];
            @weakify(self);
            [_siJiaFootV.delegateSignal subscribeNext:^(SWTModel * x) {
                @strongify(self);
                
                SWTTiJiaoOrderTVC * vc =[[SWTTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                vc.hidesBottomBarWhenPushed = YES;
                //                    vc.moneyStr =  [NSString stringWithFormat:@"%0.2f",x.intValue * self.dataModel.price.floatValue];
                vc.numStr = @"1";
                vc.goodID = x.ID;
                vc.merchID = self.dataModel.merchid;
                x.goodid = x.ID;
                x.goodprice = x.price;
                x.goodimg = x.img;
                vc.model = self.shishiModel;
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
        }
        return _siJiaFootV;
    }


- (SWTZhiBoJiaPaiFootView *)jingPaiFootV {
    if (_jingPaiFootV == nil) {
        _jingPaiFootV = [[SWTZhiBoJiaPaiFootView alloc] initWithFrame:CGRectMake(0, 0, (ScreenW -30)/4 * 3, 110)];
        _jingPaiFootV.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [_jingPaiFootV.delegateSignal subscribeNext:^(NSNumber * x) {
            @strongify(self);
            //变化底部状态栏
            self.bottomV.hidden = YES;
            self.chuJiaBottomV.hidden = NO;
            
        }];
    }
    return _jingPaiFootV;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    
    
//
    
    if (self.isHeMai) {
        [self getMineHeMaiDingZhiListWithType:0];//获取我的合买列表
        [self getGoodsListData]; //店铺合买列表
        //         [self getHeMaiList];
        
        [self.view addSubview: self.zhiBoFootV];
        [self.zhiBoFootV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            
            if (sstatusHeight > 20) {
                make.bottom.equalTo(self.view).offset(-94);
            }else {
                make.bottom.equalTo(self.view).offset(-50);
            }
            make.width.equalTo(@(ScreenW - 30 - 30));
            make.height.equalTo(@110);
        }];
        self.zhiBoFootV.isOrder = self.isTuiLiu;
        self.zhiBoFootV.hidden = YES;
        
    }else {
        [self getLivegoodListDataWithType:0]; //获取竞拍和一口价列表
        
        //一口价浮窗
        [self.view addSubview:self.yiKouJiaFootView];
        [self.yiKouJiaFootView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            if (sstatusHeight > 20) {
                make.bottom.equalTo(self.view).offset(-94);
            }else {
                make.bottom.equalTo(self.view).offset(-50);
            }
            make.width.equalTo(@(ScreenW - 30 - 30));
            make.height.equalTo(@110);
        }];
        self.yiKouJiaFootView.isOrder = self.isTuiLiu;
        self.yiKouJiaFootView.hidden = YES;
        
        //添加竞拍浮窗
        [self.view addSubview:self.jingPaiFootV];
        [self.jingPaiFootV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            if (sstatusHeight > 20) {
                make.bottom.equalTo(self.view).offset(-94);
            }else {
                make.bottom.equalTo(self.view).offset(-50);
            }
            make.width.equalTo(@(ScreenW - 30 - 30));
            make.height.equalTo(@110);
        }];
        self.jingPaiFootV.isOrder = self.isTuiLiu;
        self.jingPaiFootV.hidden = YES;
        
        //私价浮窗
        [self.view addSubview:self.siJiaFootV];
        [self.siJiaFootV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            if (sstatusHeight > 20) {
                make.bottom.equalTo(self.view).offset(-(94+110));
            }else {
                make.bottom.equalTo(self.view).offset(-(50+110));
            }
            make.width.equalTo(@(ScreenW - 30 - 30));
            make.height.equalTo(@110);
        }];
        self.siJiaFootV.isSiJia = YES;
        self.siJiaFootV.isOrder = self.isTuiLiu;
        self.siJiaFootV.hidden = YES;
        
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

- (void)dismiss {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    [self.view addSubview:self.qieHuanCarmerBt];
    [self.qieHuanCarmerBt addTarget:self action:@selector(qieHuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.qieHuanCarmerBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.width.height.equalTo(@50);
        make.top.equalTo(self.headV.mas_bottom).offset(10);
    }];
    [self.qieHuanCarmerBt setBackgroundImage:[UIImage imageNamed:@"dyx83"] forState:UIControlStateNormal];
    
    [[self.headV.guanzhuBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self gaunZhuActionwithType:0];
    }];
}

- (void)addBottomV {
    self.bottomV = [[SWTZhiBoBottomView alloc] init];
    self.bottomV.isHeMai = self.isHeMai;
    self.bottomV.isShangHu = self.isTuiLiu;
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
            if (self.isHeMai) {
                if (self.isTuiLiu) {
                    return;
                }
                //适合买的时候点击购物车
                [self getHeMaiList];
            }else {
                
                if (self.isTuiLiu) {
                    //发布实时商品一口价和竞拍
                    SWTJiShiFaBuView * shishiView = [[SWTJiShiFaBuView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                    shishiView.isSiJia = NO;
                    shishiView.liveid = self.dataModel.liveid;
                    shishiView.delegateSignal = [[RACSubject alloc] init];
                    @weakify(self);
                    [shishiView.delegateSignal subscribeNext:^(id  x) {
                        @strongify(self);
                        [self shishiViewAddPic];
                    }];
                    
                    self.shishiView = shishiView;
                    [shishiView show];
                }else {
                    //用户端
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
                    SWTModel * model  = self.heMaiArr[x.intValue-200];
                    SWTMineHeMaiTiJiaoOrderTVC * vc =[[SWTMineHeMaiTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
                    vc.hidesBottomBarWhenPushed = YES;
                    model.merchid = self.dataModel.merchid;
                    model.store_name = self.dataModel.name;
                    vc.model = model;
                    self.isPushVC = YES;
                    [self.navigationController pushViewController:vc animated:YES];
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
            [self sendMessageWityType:@"0"];
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
            
            if (self.dataModel.livegoodlist.count > 0) {
                
                self.shishiModel = [self.dataModel.livegoodlist firstObject];
                if (self.shishiModel.type.intValue == 1) {
                    //竞拍
                    self.jingPaiFootV.hidden = NO;
                    self.jingPaiFootV.model = self.shishiModel;
                    self.chuJiaBottomV.model = self.shishiModel;

                }else if (self.shishiModel.type.intValue == 0) {
                    //一口价
                    self.yiKouJiaFootView.hidden = NO;
                    self.yiKouJiaFootView.model = self.shishiModel;
                    

                }else if (self.shishiModel.type.intValue == 2) {
                    //私价
                }
            }else {
                self.shishiModel = nil;
                self.yiKouJiaFootView.hidden = YES;
                self.jingPaiFootV.hidden = YES;
            }
            
            [self jionAVRoom];
            if (self.isTuiLiu) {
                [self addTuiLiuWithType:0];
            }else {
                [self addBoLiu];
            }
            self.timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(getNumberAction) userInfo:nil repeats:YES];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
//我的合买 // 原本此处展示的是我的合买 shareList_SWT
- (void)getMineHeMaiDingZhiListWithType:(NSInteger)type {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"liveid"] = self.model.ID;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"status"] = @(2-type);
    dict[@"merchid"] = self.model.merch_id;
    [zkRequestTool networkingPOST:sharesharelist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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
                model.merchid = self.dataModel.merchid;
                model.store_name = self.dataModel.name;
                vc.model = model;
                self.isPushVC = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }];
            [heMaiV show];
            
            
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
    self.chuJiaBottomV.delegateSignal = [[RACSubject alloc] init]; 
    @weakify(self);
    [self.chuJiaBottomV.delegateSignal subscribeNext:^(NSString * x) {
        @strongify(self);
        if ([x isEqualToString:@"-1"]) {
            self.bottomV.hidden = NO;
            self.chuJiaBottomV.hidden = YES;
        }else {
//            self.jingPaiJiaGeStr = [NSString stringWithFormat:@"%@",x];
//            [self sendMessageWityType:@"7"];
            
        }
        
    }];
    
    
}

// 获取正在合的数据
- (void)getGoodsListData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"liveid"] = self.model.ID;
    [zkRequestTool networkingPOST:shareGoodlist_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.heMaiArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            if (self.heMaiArr.count > 0 ) {
                
                self.zhiBoFootV.hidden = NO;
                self.zhiBoFootV.isOrder = self.isTuiLiu;
                self.zhiBoFootV.model = [self.heMaiArr firstObject];
                
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
}

//加入直播室
- (void)jionAVRoom {
    
    [[V2TIMManager sharedInstance] setGroupListener:self];
    [[V2TIMManager sharedInstance] joinGroup:self.dataModel.livegroupid msg:@"333" succ:^{
        NSLog(@"%@",@"进入直播间成功");
        
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"进入直播间失败");
        [SVProgressHUD showErrorWithStatus:@"加入聊天室失败"];
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
- (void)sendMessageWityType:(NSString *)type {
    
    if ([self.dataModel.livegroupid isEqualToString:@"0"] ||  [[NSString stringWithFormat:@"%@",self.dataModel.livegroupid] isEqualToString:@"(null)"]) {
        [SVProgressHUD showErrorWithStatus:@"直播间无效!"];
        return;
    }
    NSMutableDictionary * dict = @{@"type":type,@"data":self.bottomV.TF.text}.mutableCopy;
    if (type.intValue == 7) {
        dict[@"data"] = self.jingPaiJiaGeStr;
    }
    V2TIMMessage * cusMsg = [[V2TIMManager sharedInstance] createCustomMessage:[dict mj_JSONData]];
    
    
    [[V2TIMManager sharedInstance] sendMessage:cusMsg receiver:nil groupID:self.dataModel.livegroupid priority:(V2TIM_PRIORITY_DEFAULT) onlineUserOnly:NO offlinePushInfo:nil progress:^(uint32_t progress) {
        
    } succ:^{
        NSLog(@"%@",@"发送成功");
        
        SWTModel * model = [[SWTModel alloc] init];
        model.avatar = [zkSignleTool shareTool].avatar;
        model.content = self.bottomV.TF.text;
        if (type.intValue == 7) {
            model.content = [NSString stringWithFormat:@"出价%@元",self.jingPaiJiaGeStr.getPriceAllStr];
        }
        model.nickname = [zkSignleTool shareTool].nickname;
        model.type = type;
        model.levelcode = [zkSignleTool shareTool].level;
        model.ID = [zkSignleTool shareTool].session_uid;
        [self.AVCharRoomArr addObject:model];
        self.avChatRoomView.dataArr = self.AVCharRoomArr;
        self.bottomV.TF.text = @"";
        
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"发送失败");
    }];
    
}


/// 收到新消息
- (void)onRecvNewMessage:(V2TIMMessage *)msg{
    NSLog(@"message === \n %@",msg);
    SWTModel * model = [[SWTModel alloc] init];
    model.ID = msg.sender;
    model.avatar = msg.faceURL;
    NSDictionary * userDict = [msg.nickName mj_JSONObject];
    NSData * data  = msg.customElem.data;
    NSDictionary * dict = [data mj_JSONObject];
    model.nickname = [userDict.allKeys containsObject:@"nickname"] ? userDict[@"nickname"]:@"??";
    model.levelcode = [userDict.allKeys containsObject:@"levelcode"] ? userDict[@"levelcode"]:@"0";
    if ([dict.allKeys containsObject:@"type"]) {
        
        NSInteger  tempType = [NSString stringWithFormat:@"%@",dict[@"type"]].intValue;
        if (tempType > 0) {
            if (tempType == 2 || tempType == 9) {
                //2发布合买全部都看的见, 9 有人购买刷新浮窗
                [self getGoodsListData];
            }else if (tempType == 3) {
                //发布抽签
                [self getChouQianData];
            }else if (tempType == 4) {
                [self getShiShiGoodDataWithtype:@"2"];
            }else if (tempType == 5) {
                [self getShiShiGoodDataWithtype:@"0"];
            }else if (tempType == 6) {
                [self getShiShiGoodDataWithtype:@"1"];
            }else if (tempType == 1) {
                [self getShiShiGoodDataWithtype:@"1"];
                 model.content = dict[@"data"];
                [self.AVCharRoomArr addObject:model];
                self.avChatRoomView.dataArr = self.AVCharRoomArr;
            }
        }else {
            model.type = [NSString stringWithFormat:@"%@",dict[@"type"]];
            if ([dict.allKeys containsObject:@"data"]) {
                if ([NSString stringWithFormat:@"%@",dict[@"type"]].intValue == 0 || [NSString stringWithFormat:@"%@",dict[@"type"]].intValue == 1)
                    model.content = dict[@"data"];
            }
            [self.AVCharRoomArr addObject:model];
            self.avChatRoomView.dataArr = self.AVCharRoomArr;
        }
        
        
    }
    
    
}

//有新成员进入到群里面
- (void)onMemberEnter:(NSString *)groupID memberList:(NSArray<V2TIMGroupMemberInfo *>*)memberList {
    
    
    self.comeInV.titleLB.text =  [NSString stringWithFormat:@"欢迎%@进入直播间",@"123"];
    [self.comeInV show];
    
    NSLog(@"===list\n%@",memberList);
    
    if (memberList.count > 0) {
        V2TIMGroupMemberInfo * userInfo  = [memberList firstObject];
        NSDictionary * dict = [userInfo.nickName mj_JSONObject];
        NSString * nickname = [dict.allKeys containsObject:@"nickname"] ? dict[@"nickname"] : @"??";
        self.comeInV.titleLB.text =  [NSString stringWithFormat:@"欢迎%@进入直播间",nickname];
        [self.comeInV show];
    }
    
    
    
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

//获取抽签结果
- (void)getChouQianData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"goodsid"] = [self.heMaiArr firstObject].ID;
    [zkRequestTool networkingPOST:merchlotsGet_lots_result_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            SWTModel * model = [[SWTModel alloc] init];
            model = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            model.type = @"3";
            [self.AVCharRoomArr addObject:model];
            self.avChatRoomView.dataArr = self.AVCharRoomArr;
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}
//获取实时直播商品
- (void)getShiShiGoodDataWithtype:(NSString *)type {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = type;
    dict[@"liveid"] = self.dataModel.liveid;
    [zkRequestTool networkingPOST:livegetlivegood_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            NSArray<SWTModel *> * arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (arr.count > 0) {
                
                if (type.intValue == 1) {
                    //竞拍
                    self.shishiModel = [arr firstObject];
                    self.jingPaiFootV.hidden = NO;
                    self.jingPaiFootV.model = self.shishiModel;
                    self.chuJiaBottomV.model = self.shishiModel;
                    
                }else if (type.intValue == 0) {
                    //一口价
                    self.shishiModel = [arr firstObject];
                    self.yiKouJiaFootView.hidden = NO;
                    self.yiKouJiaFootView.model = self.shishiModel;
                    
                }else if (type.intValue == 2) {
                    //私价
                    self.siJiaModel = [arr firstObject];
                    if ([[zkSignleTool shareTool].session_uid isEqualToString:self.siJiaModel.tomemberid]) {
                        self.siJiaFootV.hidden = NO;
                        self.siJiaFootV.model = self.siJiaModel;
                        
                        if (self.shishiModel != nil) {
                            [self.siJiaFootV mas_updateConstraints:^(MASConstraintMaker *make) {
                                if (sstatusHeight > 20) {
                                    make.bottom.equalTo(self.view).offset(-(94+110));
                                }else {
                                    make.bottom.equalTo(self.view).offset(-(50+110));
                                }
                            }];
                        }else {
                            [self.siJiaFootV mas_updateConstraints:^(MASConstraintMaker *make) {
                                if (sstatusHeight > 20) {
                                    make.bottom.equalTo(self.view).offset(-(94));
                                }else {
                                    make.bottom.equalTo(self.view).offset(-(50));
                                }
                            }];
                        }
                        
                    }else {
                        self.siJiaFootV.hidden = YES;
                    }
                    
                }
            }else {
                self.shishiModel = nil;
                self.yiKouJiaFootView.hidden = YES;
                self.jingPaiFootV.hidden = YES;
                self.siJiaFootV.hidden = YES;
            }
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}

//添加聊天列表
- (void)initChatRoomV {
    self.avChatRoomView = [[SWTAVChatRoomView alloc] init];
    [self.view addSubview:self.avChatRoomView];
    Weak(weakSelf);
    self.avChatRoomView.clickPeopleBlock = ^(SWTModel *model) {
        //点击用户进行私价
        if (!weakSelf.isTuiLiu) {
            return;
        }
        if (model.type.intValue == 0 || model.type.intValue == 1) {
            SWTZhiBoGeRenShowView * gerenShowView  = [[SWTZhiBoGeRenShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenH, ScreenH)];
            gerenShowView.model = model;
            
            gerenShowView.delegate = self;
            [gerenShowView show];
        }
    };
    [self.avChatRoomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomV.mas_top).offset(-220);
        make.height.equalTo(@200);
    }];
    
}
//点击创建私单
- (void)clickChuangJianSiDanWithModel:(SWTModel *)model {
    
    //发布实时商品私价
    SWTJiShiFaBuView * shishiView = [[SWTJiShiFaBuView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    shishiView.isSiJia = NO;
    shishiView.tomemberid = model.ID;
    shishiView.liveid = self.dataModel.liveid;
    shishiView.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [shishiView.delegateSignal subscribeNext:^(id  x) {
        @strongify(self);
        [self shishiViewAddPic];
    }];
    self.shishiView = shishiView;
    [shishiView show];
    
}

- (void)shishiViewAddPic {
    
    if ([self isCanUsePicture]) {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAXFLOAT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.maxImagesCount = 1;
    imagePickerVc.videoMaximumDuration = 3;
    
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowTakePicture = NO;
    
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
    imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
    imagePickerVc.circleCropRadius = ScreenW/2;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        if (photos.count > 0) {
            self.shishiView.image = photos.firstObject;
            
        }
        
        
    }];
        self.isPushVC = YES;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
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
    
    PLVideoCaptureConfiguration * videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    //    if (type == 1) {
    //        self.videoPL.streamMirrorFrontFacing = YES;
    //        self.videoPL.streamMirrorRearFacing = NO;
    //        videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
    //    }else {
    //         self.videoPL.streamMirrorRearFacing = YES;
    //        self.videoPL.streamMirrorFrontFacing = NO;
    //        videoCaptureConfiguration.position = AVCaptureDevicePositionBack;
    //    }
    //    self.videoPL = videoCaptureConfiguration;
    videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
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
    
    
}

//切换摄像头
- (void)qieHuanAction:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        self.session.captureDevicePosition = AVCaptureDevicePositionBack;
    }else {
        self.session.captureDevicePosition = AVCaptureDevicePositionFront;
    }
}


/**
 告知代理对象播放器因错误停止播放
 
 @param player 调用该方法的 PLPlayer 对象
 @param error  携带播放器停止播放错误信息的 NSError 对象
 
 @since v1.0.0
 */
- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error{
    NSLog(@"error===%@",error);
    if (error.code == -1005) {
        if (!self.isTuiLiu) {
            [SVProgressHUD showErrorWithStatus:@"直播已关闭"];
        }
    }
    
    
    
    
    
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

//获取直播人数
- (void)getNumberAction {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"liveid"] = self.dataModel.liveid;
    [zkRequestTool networkingPOST:livegetlivenum_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataModel.watchnum = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            self.headV.model = self.dataModel;
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}



@end
