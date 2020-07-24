//
//  SWTXiYieVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTXiYieVC.h"

@interface SWTXiYieVC ()
@property (weak, nonatomic) IBOutlet UITextView *TV;

@end

@implementation SWTXiYieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == 1) {
        self.navigationItem.title = @"用户协议";
        [self getData];
    }else if (self.type == 2) {
        self.navigationItem.title = @"隐私协议";
        [self getData];
    }
    if (self.titleStr.length > 0) {
        self.navigationItem.title = self.titleStr;
    }
    self.TV.text = self.contentStr;
    
}
- (void)getData {
    [SVProgressHUD show];
    NSString * url  = agreement_SWT;
    if (self.type == 2) {
        url = privacypolicy_SWT;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
     
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            SWTModel * mm = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.TV.text = mm.content;
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}

@end
