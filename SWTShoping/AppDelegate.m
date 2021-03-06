//
//  AppDelegate.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "AppDelegate.h"
//#import <AlipaySDK/AlipaySDK.h>
#import <UserNotifications/UserNotifications.h>
#import <WXApi.h>
#import "TabBarController.h"
#import "LYGuideViewController.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
#import "TConversationListViewModel.h"
#import <TUIConversationListController.h>
#import "SWTLoginTwoVC.h"

#define UMKey @"567a0b8767e58e04b70070c0"
//友盟安全密钥//r6xbw5gy0zenei6x56xtm9wmkrrz653y
#define SinaAppKey @"3443149913"
#define SinaAppSecret @"2d6bac14bc37989170ba9ab6214f06c3"
#define WXAppID @"wx42f7270dbfb675d0"
#define WXAppSecret @"7cb5c3dcd74b4d4ef1b4ff7d74dd01ea"
#define QQAppID @"1104758682"
#define QQAppKey @"h97lgfazyRUzXJKy"
#define TXIMAPPID 1400404340
#define ppppppid @"1475345979444"



//苹果账号 shanghaixunshun@163.com 密码 Ma730620
@interface AppDelegate ()<V2TIMSDKListener,V2TIMAdvancedMsgListener,WXApiDelegate>
@property(nonatomic,assign)BOOL isShowRed;
@property(nonatomic,strong)NSMutableArray<V2TIMConversation *> *ListArr;
@property(nonatomic,strong)TConversationListViewModel *viewModel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [PLStreamingEnv initEnv];
    [UMSPPPayPluginSettings sharedInstance].umspEnviroment = UMSP_TEST;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self instantiateRootVC];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = BackgroundColor;
    
  
    [self updateNewAppWith:ppppppid];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
       manager.enable = YES;
       manager.shouldResignOnTouchOutside = YES;
       manager.shouldToolbarUsesTextFieldTintColor = YES;
       manager.enableAutoToolbar = NO;
    
    [WXApi registerApp:WXAppID universalLink:@"https://www.baidu.com/"];
    
      [self initPush];
      [self initUMeng:launchOptions];
      
      // U-Share 平台设置
      [self configUSharePlatforms];

    // 发送崩溃日志
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dataPath = [path stringByAppendingPathComponent:@"Exception.txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
    if (data != nil) {
        
//        [self sendExceptionLogWithData:data path:dataPath];
        
    }
//    [[TUIKit sharedInstance] setupWithAppId:TXIMAPPID];
    [self initTengXunIM];
    
    
    
//    [[V2TIMManager sharedInstance] addAdvancedMsgListener:self];
    
    if (ISLOGIN) {
        [self loginIM];
    }
    
    self.ListArr = @[].mutableCopy;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self getList];
//    });

//    @weakify(self)
//    [RACObserve(self.viewModel, dataList) subscribeNext:^(id  _Nullable x) {
//           @strongify(self)
//           [[NSNotificationCenter defaultCenter] postNotificationName:@"messagechange" object:x];
//            [self showRedVWtihArr:x];
//    }];
    
    
    [LTSCEventBus registerEvent:@"imlogin" block:^(id data) {
        [self getList];
    }];
    
    [LTSCEventBus registerEvent:@"showmessage" block:^(NSNumber *data) {
        UITabBarController * tabvc = (UITabBarController *)self.window.rootViewController;
        if (data.intValue == 1) {
            [tabvc.tabBar showBadgeOnItemIndex:2];
        }else {
            [tabvc.tabBar hideBadgeOnItemIndex:2 animated:YES];
        }
    }];
    
    return YES;
}


//- (void)showRedVWtihArr:(NSArray<TUIConversationCellData *> *)arr {
//    for (TUIConversationCellData * conVerSation  in arr) {
//        if (conVerSation.unRead > 0 ) {
//            self.isShowRed = YES;
//            break;
//        }else {
//            self.isShowRed = NO;
//        }
//    }
//    [LTSCEventBus sendEvent:@"showmessage" data:@(self.isShowRed)];
//}
//
//- (TConversationListViewModel *)viewModel
//{
//    if (!_viewModel) {
//        _viewModel = [TConversationListViewModel new];
//        _viewModel.listFilter = ^BOOL(TUIConversationCellData * _Nonnull data) {
//            return (data.convType != TIM_GROUP);
//        };
//    }
//    return _viewModel;
//}



/// 收到新消息
- (void)onRecvNewMessage:(V2TIMMessage *)msg{
    
    [LTSCEventBus sendEvent:@"cmessage" data:msg];
    
    if (msg.elemType != V2TIM_ELEM_TYPE_GROUP_TIPS) {
        [self getList];
    }
    
    
   
}

/// 收到消息已读回执（仅单聊有效）
- (void)onRecvC2CReadReceipt:(NSArray<V2TIMMessageReceipt *> *)receiptList{
    
    
    
    
}


- (void)showRedV {
    for (V2TIMConversation * conVerSation  in self.ListArr) {
        if (conVerSation.unreadCount > 0 ) {
            self.isShowRed = YES;
            break;
        }else {
            self.isShowRed = NO;
        }
    }
    [LTSCEventBus sendEvent:@"showmessage" data:@(self.isShowRed)];
}

- (void)getList  {
    
    [[V2TIMManager sharedInstance] getConversationList:(0) count:50 succ:^(NSArray<V2TIMConversation *> *list, uint64_t nextSeq, BOOL isFinished) {
        [self.ListArr removeAllObjects];
        for (V2TIMConversation * con in  list) {
            if (con.type == V2TIM_C2C) {
                [self.ListArr addObject:con];
            }
        }
        [self showRedV];
    } fail:^(int code, NSString *desc) {
     
    }];
    
    
    
}


- (void)initTengXunIM {
    // 1. 从 IM 控制台获取应用 SDKAppID，详情请参考 SDKAppID。
    // 2. 初始化 config 对象
    V2TIMSDKConfig *config = [[V2TIMSDKConfig alloc] init];
    // 3. 指定 log 输出级别，详情请参考 SDKConfig。
    config.logLevel = V2TIM_LOG_NONE;
    // 4. 初始化 SDK 并设置 V2TIMSDKListener 的监听对象。
    // initSDK 后 SDK 会自动连接网络，网络连接状态可以在 V2TIMSDKListener 回调里面监听。
    [[V2TIMManager sharedInstance] initSDK:TXIMAPPID config:config listener:self];
    [[V2TIMManager sharedInstance] addAdvancedMsgListener:self];
    
}

- (void)loginIM {

    NSInteger userStatus = [[V2TIMManager sharedInstance] getLoginStatus];
    if (userStatus == 3) {
        [[V2TIMManager sharedInstance] login:[zkSignleTool shareTool].session_uid userSig:[zkSignleTool shareTool].userSig succ:^{
            NSLog(@"%@",@"登录腾讯成功");
            [self getList];
            
            
        } fail:^(int code, NSString *desc) {
            NSLog(@"%@",@"登录腾旭失败");
        }];
    }else if (userStatus == 1) {
        [self getList];
    }
    
    
    
}

- (void)onConnecting {
    // 正在连接到腾讯云服务器
    NSLog(@"%@",@"正在连接腾讯");
}
- (void)onConnectSuccess {
    // 已经成功连接到腾讯云服务器
     NSLog(@"%@",@"已经连接到腾讯云");
}
- (void)onConnectFailed:(int)code err:(NSString*)err {
    // 连接腾讯云服务器失败
    NSLog(@"%@",@"连接到腾讯云失败");
}


- (void)onKickedOffline {
    //掉线
    [SVProgressHUD showErrorWithStatus:@"您的账号在其它地方登陆"];
    [zkSignleTool shareTool].isLogin = NO;
    [LTSCEventBus sendEvent:@"showmessage" data:@(0)];
    SWTLoginTwoVC * vc =[[SWTLoginTwoVC alloc] init];
    BaseNavigationController * navc =[[BaseNavigationController alloc] initWithRootViewController:vc];;
    [self.window.rootViewController presentViewController:navc animated:YES completion:nil];
    
    
    
}
- (void)configUSharePlatforms
{
    
    //打开图片水印
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    //关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:QQAppKey redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    
}

-(void)initPush
{
    //1.向系统申请推送
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    }
    else
    {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}


-(void)initUMeng:(NSDictionary *)launchOptions
{
    [UMConfigure initWithAppkey:UMKey channel:@"App Store"];
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=self;
        
    } else {
        // Fallback on earlier versions
    }
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        
        if (error) {
            NSLog(@"error===%@",error.description);
        }
        
        if (granted) {
            
        }else{
        }
    }];
    
}




- (BOOL)initLocationPush:(UIApplication *)application finishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
    [application registerUserNotificationSettings:setting];
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 这里添加处理代码
    }
    return YES;
}

//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    //过滤掉Push的撤销功能，因为PushSDK内部已经调用的completionHandler(UIBackgroundFetchResultNewData)，
    //防止两次调用completionHandler引起崩溃
    if(![userInfo valueForKeyPath:@"aps.recall"])
    {
        completionHandler(UIBackgroundFetchResultNewData);
    }
}
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"===\n3===%@",userInfo);
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [UMessage didReceiveRemoteNotification:userInfo];
            [UMessage setAutoAlert:NO];
            //应用处于前台时的远程推送接受
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            
            
//            LxmPushModel *model = [LxmPushModel mj_objectWithKeyValues:userInfo];
//            // 1-系统通知(infoUrl有值时跳转)，2-订单消息(跳转订单详情) 3-普通消息(不做操作) 4-充值成功(跳转充值结果页面) 5-充值失败(跳转充值结果页面)
//            LxmTabBarVC * bar = (LxmTabBarVC *)self.window.rootViewController;
////            bar.selectedIndex = 0;
//            BaseNavigationController * nav  = (BaseNavigationController *)bar.selectedViewController;
//            [self pageTo:model nav:nav];
            
        }else{
            //应用处于前台时的本地推送接受
//            LxmPushModel *model = [LxmPushModel mj_objectWithKeyValues:userInfo];
//            // 1-系统通知(infoUrl有值时跳转)，2-订单消息(跳转订单详情) 3-普通消息(不做操作) 4-充值成功(跳转充值结果页面) 5-充值失败(跳转充值结果页面)
//            LxmTabBarVC * bar = (LxmTabBarVC *)self.window.rootViewController;
////            bar.selectedIndex = 0;
//            BaseNavigationController * nav  = (BaseNavigationController *)bar.selectedViewController;
//            [self pageTo:model nav:nav];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
    
    
    
}



//在用户接受推送通知后系统会调用
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    //    self.pushToken = deviceToken;
    //    if (![LxmTool ShareTool].isClosePush)
    //    {
    [UMessage registerDeviceToken:deviceToken];
    NSString * token = @"";
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13) {
        if (![deviceToken isKindOfClass:[NSData class]]) {
            //记录获取token失败的描述
            return;
        }
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        token = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                 ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                 ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                 ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        NSLog(@"deviceToken1:%@", token);
    } else {
        token = [NSString
                 stringWithFormat:@"%@",deviceToken];
        token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    }
    //将deviceToken给后台
    NSLog(@"send_token:%@",token);
//    [LxmTool ShareTool].deviceToken = token;
//    [[LxmTool ShareTool] uploadDeviceToken];
    
}


//设置根视图控制器
- (UIViewController *)instantiateRootVC{
    
    //没有引导页
    //    zkRootVC *BarVC=[[zkRootVC alloc] init];
    //    return BarVC;
    
    
    
    //获取app运行的版本号
    NSString *currentVersion =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //取出本地缓存的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [defaults objectForKey:@"appversion"];
    if ([currentVersion isEqualToString:localVersion]) {
        TabBarController *BarVC=[[TabBarController alloc] init];
        return BarVC;
        //        TabBarController * tabVc = [[TabBarController alloc] init];
        //        return tabVc;
        
    }else{
        LYGuideViewController *guideVc = [[LYGuideViewController alloc] init];
        return guideVc;
    }
}
//跳转主页
- (void)showHomeVC{
    TabBarController  *BarVC=[[TabBarController alloc] init];
    self.window.rootViewController = BarVC;
    
    
    //更新本地储存的版本号
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"appversion"];
    //同步到物理文件存储
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *string =[url absoluteString];
    if ([string hasPrefix:@"unifyPayDemo://"])
    {
        return [UMSPPPayUnifyPayPlugin cloudPayHandleOpenURL:url];
    }else if ([url.absoluteString hasPrefix:@"wx42f7270dbfb675d0://pay"] ) {

        [WXApi handleOpenURL:url delegate:self];


    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
     [[UMSocialManager defaultManager] handleOpenURL:url];
    return YES;
//    return  [UMSPPPayUnifyPayPlugin handleOpenURL:url otherDelegate:[WeiChatOtherManager shareManager]];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    NSString *string =[url absoluteString];
    if ([string hasPrefix:@"unifyPayDemo://"])
    {
        return [UMSPPPayUnifyPayPlugin cloudPayHandleOpenURL:url];
    }else if ([url.absoluteString hasPrefix:@"wx42f7270dbfb675d0://pay"] ) {
        //微信
        [WXApi handleOpenURL:url delegate:self];

    }else {//友盟
        [[UMSocialManager defaultManager] handleOpenURL:url];
    }
    
     [[UMSocialManager defaultManager] handleOpenURL:url];
    return YES;
//    return [UMSPPPayUnifyPayPlugin handleOpenURL:url otherDelegate:[WeiChatOtherManager shareManager]];
}


- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options{
    
    NSString *string =[url absoluteString];
    if ([string hasPrefix:@"unifyPayDemo://"])
    {
        return [UMSPPPayUnifyPayPlugin cloudPayHandleOpenURL:url];
    }if ([url.absoluteString hasPrefix:@"wx42f7270dbfb675d0://pay"] ) {
        [WXApi handleOpenURL:url delegate:self];
        
    }else {
        [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    }
     [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    return YES;
    
//    return [UMSPPPayUnifyPayPlugin handleOpenURL:url otherDelegate:[WeiChatOtherManager shareManager]];
};

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler  API_AVAILABLE(ios(8.0)){
    if (@available(iOS 8.0, *)) {
        return YES;
//        return [UMSPPPayUnifyPayPlugin handleOpenUniversalLink:userActivity otherDelegate:[WeiChatOtherManager shareManager]];
    } else {
        // Fallback on earlier versions
        return YES;
    }
    
}





//微信支付结果
- (void)onResp:(BaseResp *)resp {
    //发送一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPAY" object:resp];
}


- (void)updateNewAppWith:(NSString *)strOfAppid {
    

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",strOfAppid]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (data)
        {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (dic)
            {
                NSArray * arr = [dic objectForKey:@"results"];
                if (arr.count>0)
                {
                    NSDictionary * versionDict = arr.firstObject;
                    
                    NSString * version = [[versionDict objectForKey:@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                    NSString * currentVersion = [[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                    
                    if ([version integerValue]>[currentVersion integerValue])
                    {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:nil preferredStyle:UIAlertControllerStyleAlert];
                            
                            [alert addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",strOfAppid]]];
                                exit(0);
                                
                            }]];
                            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                        });
                        
                    }else {
                        [SVProgressHUD showSuccessWithStatus:@"目前安装的已是最新版本"];
                    }
                    
                    
                }
            }
        }
    }] resume];
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
//    [LTSCEventBus sendEvent:@"foreground" data:nil];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [LTSCEventBus sendEvent:@"foreground" data:nil];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
