//
//  SWTPayVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTPayVC.h"
#import "SWTPaySucessVC.h"
@interface SWTPayVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UIButton *payBt;
@property(nonatomic , assign)NSInteger  payType; // 100,101,102
@property(nonatomic , strong)NSString *payDataJsonStr;
@end

@implementation SWTPayVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"支付";
    
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",self.priceStr];
    [self.payBt setTitle:[NSString stringWithFormat:@"支付￥%@",self.priceStr] forState:UIControlStateNormal];
    Weak(weakSelf);
    [LTSCEventBus registerEvent:@"foreground" block:^(id data) {
        [weakSelf getOrderStatus];
    }];
}

- (void)getOrderStatus {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merOrderId"] = self.orderID;
    [zkRequestTool networkingPOST:payOrderquery_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
       
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if ([responseObject[@"data"][@"status"] isEqualToString:@"SUCCESS"]) {
                //支付成功
                SWTPaySucessVC * vc =[[SWTPaySucessVC alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.orderID = self.orderID;
                vc.priceStr = self.priceStr;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
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
        [self getOrderWityType:self.payType];
    }
    
    
     
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
    [zkRequestTool networkingPOST:payOrder_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        
        
        NSDictionary * dict = [responseObject[@"returninfo"] mj_JSONObject];
        
        if (dict != nil && [dict.allKeys containsObject:@"respStr"]) {
            NSDictionary * dict2 = [dict[@"respStr"] mj_JSONObject];
            if ( dict2 != nil && [dict2.allKeys containsObject:@"appPayRequest"]) {
                
                self.payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict2[@"appPayRequest"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
                [self payAction];
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




- (void)payAction {
    
    if (self.payType == 100) {
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_WEIXIN
              payData:self.payDataJsonStr
        callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            
            
            
        }];
    }else if (self.payType == 101) {
        
//        NSDictionary * dictionary = @{@"qrCode": @"https://qr.alipay.com/bax09163hdue268uttgh005b"};
//
//        NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:self.payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            if ([resultCode isEqualToString:@"1003"]) {
                
            }
        }];
    }else {
        
        [UMSPPPayUnifyPayPlugin cloudPayWithURLSchemes:@"unifyPayDemo" payData:self.payDataJsonStr
        viewController:self
         callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            
            
            
         }];
        
    }
    
    
    
}

@end
