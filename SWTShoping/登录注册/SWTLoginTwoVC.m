//
//  SWTLoginTwoVC.m
//  TTT
//
//  Created by zk on 2020/7/6.
//  Copyright © 2020 张坤. All rights reserved.
//

#import "SWTLoginTwoVC.h"
#import "SWTRegistVC.h"
#import "SWTBoLiuVC.h"
#import "SWTTuiLiuVC.h"
@interface SWTLoginTwoVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UIButton *weiXinBt;
@property (weak, nonatomic) IBOutlet UILabel *LB;

@end

@implementation SWTLoginTwoVC

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
    self.navigationItem.title = @"登录";
    
    self.loginBt.layer.cornerRadius = self.weiXinBt.layer.cornerRadius = 22.5;
    self.loginBt.clipsToBounds = self.weiXinBt.clipsToBounds = YES;
    self.loginBt.layer.borderWidth = self.weiXinBt.layer.borderWidth = 0.8;
    self.loginBt.layer.borderColor = self.weiXinBt.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.passwordTF.text = self.passwordStr;
    self.phoneTF.text = self.phoneStr;
    
    
  NSString * htmlStr =   @"<p style=\"text-align: left;\"><b>文玩艺术品电商平台，开直播，尽享百万流量文玩艺术品电商平台，开直播...</b></p><p><b>创始人...</b></p><p><b>等数亿投资... .</b></p><p></p><p></p>";
    
   
            NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
            NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    
          //设置富文本
          NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
          //设置段落格式
          NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
          para.lineSpacing = 4;
          para.paragraphSpacing = 10;
          [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
    self.LB.numberOfLines = 0;
    self.LB.attributedText = attStr;
    

    //或者
    //    NSDictionary *option = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
    //    NSData *data = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
    //设置富文本

    
    
    //设置文本的Font没有效果，默认12字号，这个只能服务器端控制吗？ 暂时没有找到方法修改字号
//    [attStr addAttribute:NSFontAttributeName value:para range:NSMakeRange(0, attStr.length)];
    //计算加载完成之后Label的frame
//    CGFloat hh22 =  [attStr boundingRectWithSize:CGSizeMake(ScreenW , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
    
//    CGSize attSize = [attStr boundingRectWithSize:CGSizeMake(ScreenW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    CGFloat height = [attStr boundingRectWithSize:CGSizeMake(ScreenW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
    

    
    CGFloat  hh  = [htmlStr getHeigtWithFontSize:14 lineSpace:4 width:ScreenW];

    NSLog(@"%lf",hh);
    NSLog(@"成功");
    
}

- (IBAction)back:(id)sender {
    [LTSCEventBus sendEvent:@"diss" data:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loginAction  {
    
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.passwordTF.text.length == 0 ) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"mobile"] = self.phoneTF.text;
    dict[@"password"] = self.passwordTF.text;
    [zkRequestTool networkingPOST:login_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [zkSignleTool shareTool].session_token = responseObject[@"data"][@"accessToken"];
            [zkSignleTool shareTool].session_uid =  responseObject[@"data"][@"userid"];
            [zkSignleTool shareTool].isLogin = YES;
            [zkSignleTool shareTool].phone = self.phoneTF.text;
            [zkSignleTool shareTool].userSig = responseObject[@"data"][@"usersig"];
            [zkSignleTool shareTool].avatar = responseObject[@"data"][@"avatar"];
            [zkSignleTool shareTool].nickname =  responseObject[@"data"][@"nickname"];
            [zkSignleTool shareTool].level =  responseObject[@"data"][@"levelcode"];
            
            [self loginIM];
            
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
     
        
    }];
}

- (void)loginIM {
    
    
    [[V2TIMManager sharedInstance] login:[zkSignleTool shareTool].session_uid userSig:[zkSignleTool shareTool].userSig succ:^{
        NSLog(@"%@",@"登录腾讯成功");
    } fail:^(int code, NSString *desc) {
        NSLog(@"%@",@"登录腾旭失败");
    }];
}

- (IBAction)clickAction:(UIButton *)sender {
    
    
    
    if (sender.tag == 100) {
        [self loginAction];
    }else if (sender.tag == 101) {
        
        SWTTuiLiuVC * vc =[[SWTTuiLiuVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
//        SWTRegistVC * vc =[[SWTRegistVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 102) {
        SWTBoLiuVC * vc =[[SWTBoLiuVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
//        SWTRegistVC * vc =[[SWTRegistVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.isForgetPassword = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
