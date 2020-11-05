//
//  SWTPayVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTPayVC.h"
#import "SWTPaySucessVC.h"
#import <WXApi.h>
@interface SWTPayVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UIButton *payBt;
@property(nonatomic , assign)NSInteger  payType; // 100,101,102
@property(nonatomic , strong)NSString *payDataJsonStr;
@property(nonatomic , strong)NSDictionary *weixinpaydict;
@end

@implementation SWTPayVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.isComeBaoZhengJin) {
        if (self.payType != 100) {
            [self getOrderStatus];
        }
    }
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WWWWX:) name:@"WXPAY" object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"支付";
    self.payType = 100;
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",self.priceStr.getPriceAllStr];
    [self.payBt setTitle:[NSString stringWithFormat:@"支付￥%@",self.priceStr.getPriceAllStr] forState:UIControlStateNormal];
    Weak(weakSelf);
    [LTSCEventBus registerEvent:@"foreground" block:^(id data) {
        [weakSelf getOrderStatus];
    }];
    
    [self setLeftNagate];
    
    [self getOrderPriceData];
    
    
}

- (void)getOrderPriceData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merOrderId"] = self.orderID;
    dict[@"totalAmount"] =  @([[NSString stringWithFormat:@"%lf",self.priceStr.doubleValue * 100] intValue]);
    [zkRequestTool networkingPOST:payorderprice_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.priceStr = [NSString stringWithFormat:@"%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"data"]] doubleValue] / 100];
            self.moneyLB.text = [NSString stringWithFormat:@"￥%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"data"]] doubleValue] / 100];
            [self.payBt setTitle:[NSString stringWithFormat:@"支付￥%0.2f",[[NSString stringWithFormat:@"%@",responseObject[@"data"]] doubleValue] / 100] forState:UIControlStateNormal];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        
    }];
}

- (void)setLeftNagate {
    
    UIButton * leftBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    @weakify(self);
    [[leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    
}

- (void)getOrderStatus {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merOrderId"] = self.orderID;
    
    [zkRequestTool networkingPOST:payOrderquery_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (self.isComeBaoZhengJin) {
                if ([responseObject[@"data"][@"status"] isEqualToString:@"SUCCESS"]) {
                    [SVProgressHUD showSuccessWithStatus:@"店铺保证金支付成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                }
            }else {
                if ([responseObject[@"data"][@"status"] isEqualToString:@"SUCCESS"]) {
                    //支付成功
                    SWTPaySucessVC * vc =[[SWTPaySucessVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.orderID = self.orderID;
                    vc.priceStr = self.priceStr;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}

- (IBAction)clickAction:(UIButton *)sender {
    
    if (sender.tag == 100) {
        self.imgV1.image = [UIImage imageNamed:@"dyx43"];
        self.imgV2.image = [UIImage imageNamed:@"dyx44"];
        self.imgV3.image = [UIImage imageNamed:@"dyx44"];
        self.payType = sender.tag;
    }else if (sender.tag == 101) {
        self.imgV1.image = [UIImage imageNamed:@"dyx44"];
        self.imgV2.image = [UIImage imageNamed:@"dyx43"];
        self.imgV3.image = [UIImage imageNamed:@"dyx44"];
        self.payType = sender.tag;
    }else if (sender.tag == 102) {
        self.imgV1.image = [UIImage imageNamed:@"dyx44"];
        self.imgV2.image = [UIImage imageNamed:@"dyx44"];
        self.imgV3.image = [UIImage imageNamed:@"dyx43"];
        self.payType = sender.tag;
    }else if (sender.tag == 103) {
        //        [self payAction];
        
        if (self.payType == 100) {
            //微信支付
            
            [self wxPayAction];
            
        }else {
            //支付宝和银行卡
           [self getOrderWityType:self.payType];
        }
        
        
        
    }
    
    
    
}

- (void)wxPayAction {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    dict[@"totalAmount"] =  @([[NSString stringWithFormat:@"%lf",self.priceStr.doubleValue * 100] intValue]);
    NSString * url = paywxorder_SWT;
    if (self.isComeBaoZhengJin) {
        url = paywxpaymoney_SWT;
        dict[@"merchid"] = self.merchID;
    }else {
       dict[@"merOrderId"] = self.orderID;
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
       
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.weixinpaydict = responseObject[@"data"];
            [self goWXpay];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
     
        
    }];
}

//获取支付信息
- (void)getOrderWityType:(NSUInteger)type {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merOrderId"] = self.orderID;
    dict[@"totalAmount"] =  @( [[NSString stringWithFormat:@"%lf",self.priceStr.doubleValue * 100] intValue]);
    if (self.payType == 100) {
        
        dict[@"type"] = @"wx.unifiedOrder";
    }else if (self.payType == 101) {
        dict[@"type"] = @"trade.precreate";
    }else {
        dict[@"type"] = @"uac.appOrder";
    }
    NSString * url = payOrder_SWT;
    if (self.isComeBaoZhengJin) {
        url = paypaymoney_SWT;
        dict[@"merchid"] = self.merchID;
    }
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        
        
        NSDictionary * dict = [responseObject[@"returninfo"] mj_JSONObject];
        
        if (dict != nil && [dict.allKeys containsObject:@"errCode"]) {
            if ([[NSString stringWithFormat:@"%@",dict[@"errCode"]] isEqualToString:@"SUCCESS"]) {
                //成功
                NSDictionary * dict2 = [dict[@"respStr"] mj_JSONObject];
                if (self.payType == 100) {
                    
                    
                    
                    if ( dict2 != nil && [dict2.allKeys containsObject:@"miniPayRequest"]) {
                        self.weixinpaydict = dict2[@"miniPayRequest"];
//                        [self payAction];
                        [self goWXpay];
                    }
                    
                }else {
                    if ( dict2 != nil && [dict2.allKeys containsObject:@"appPayRequest"]) {
                        
                        self.payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict2[@"appPayRequest"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                        //                self.orderID = responseObject[@"merOrderId"];
                       
                         [self payAction];
                        
                    }
                }
                
                
            }else {
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
            }
        }
        
        
        //        if ([responseObject[@"code"] intValue]== 200) {
        //
        //
        //
        //
        //        }else {
        //            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        //        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}


#pragma mark -微信、支付宝支付
- (void)goWXpay {
    PayReq * req = [[PayReq alloc]init];
    req.partnerId = [NSString stringWithFormat:@"%@",self.weixinpaydict[@"mch_id"]];
    req.prepayId =  [NSString stringWithFormat:@"%@",self.weixinpaydict[@"prepay_id"]];
    req.nonceStr =  [NSString stringWithFormat:@"%@",self.weixinpaydict[@"nonce_str"]];
    //注意此处是int 类型
    req.timeStamp = [self.weixinpaydict[@"timestamp"] intValue];
    req.package =  [NSString stringWithFormat:@"%@",@"Sign=WXPay"];
    req.sign =  [NSString stringWithFormat:@"%@",self.weixinpaydict[@"sign"]];
    
//    req.partnerId = [NSString stringWithFormat:@"%@",@"1603650355"];
//    req.prepayId =  [NSString stringWithFormat:@"%@",@"wx271556570794088f88fd5eea75ca1d0000"];
//    req.nonceStr =  [NSString stringWithFormat:@"%@",@"ttbyereOTIxvNhYQ"];
//    //注意此处是int 类型
//    req.timeStamp = 1603785417;
//    req.package =  [NSString stringWithFormat:@"%@",@"Sign=WXPay"];
//    req.sign =  [NSString stringWithFormat:@"%@",@"720C2EDAD6002D39B1613C1022BF1E05"];
    
    //发起支付
//    [WXApi sendReq:req];
    
    [WXApi sendReq:req completion:nil];
    
}

//微信支付结果处理
- (void)WWWWX:(NSNotification *)no {
    
    BaseResp * resp = no.object;
    if (resp.errCode==WXSuccess)
    {
        
        if (self.isComeBaoZhengJin) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            SWTPaySucessVC * vc =[[SWTPaySucessVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.orderID = self.orderID;
            vc.priceStr = self.priceStr;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        
       
    }
    else if (resp.errCode==WXErrCodeUserCancel)
    {
        [SVProgressHUD showErrorWithStatus:@"用户取消支付"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"支付失败"];
    }
    
}


- (void)payAction {
    
    if (self.payType == 100) {
        
        WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
        launchMiniProgramReq.userName = @"wx42f7270dbfb675d0";  //拉起的小程序的username-原始ID
        NSArray * arr = self.weixinpaydict.allKeys;
        NSString * str = @"";
        for (int i = 0 ; i < arr.count; i++) {
            if (i== 0) {
                str = [NSString stringWithFormat:@"pages/index/index?%@=%@",arr,self.weixinpaydict[arr[i]]];
            }else {
                str = [NSString stringWithFormat:@"%@&%@=%@",str,arr,self.weixinpaydict[arr[i]]];
            }
            
        }
        launchMiniProgramReq.path = str;    //拉起小程序页面的可带参路径，不填默认拉起小程首页
        launchMiniProgramReq.miniProgramType = WXMiniProgramTypeRelease; //拉起小程序的类型
        [WXApi sendReq:launchMiniProgramReq completion:nil];
        
        
        //        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_WEIXIN
        //                                          payData:self.payDataJsonStr
        //                                    callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
        //            NSLog(@"=====---\n%@",resultInfo);
        //
        //
        //        }];
    }else if (self.payType == 101) {
        
        //        NSDictionary * dictionary = @{@"qrCode": @"https://qr.alipay.com/bax09163hdue268uttgh005b"};
        //
        //        NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:self.payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            if ([resultCode isEqualToString:@"1003"]) {
                [SVProgressHUD showErrorWithStatus:@"用户未安装客户端"];
            }else if ([resultCode isEqualToString:@"0000"]) {
                
                if (self.isComeBaoZhengJin) {
                    [SVProgressHUD showSuccessWithStatus:@"店铺保证金支付成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                }else {
                    SWTPaySucessVC * vc =[[SWTPaySucessVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.orderID = self.orderID;
                    vc.priceStr = self.priceStr;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                
                
            }
        }];
    }else {
        
        [UMSPPPayUnifyPayPlugin cloudPayWithURLSchemes:@"unifyPayDemo" payData:self.payDataJsonStr
                                        viewController:self
                                         callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            if ([resultCode isEqualToString:@"0000"]) {
                if (self.isComeBaoZhengJin) {
                    [SVProgressHUD showSuccessWithStatus:@"店铺保证金支付成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                }else {
                    SWTPaySucessVC * vc =[[SWTPaySucessVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.orderID = self.orderID;
                    vc.priceStr = self.priceStr;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }];
        
    }
    
    
    
}

@end
