//
//  SWTMJMineMoneyVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineMoneyVC.h"
#import "SWTMJChongZhiView.h"
@interface SWTMJMineMoneyVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UIButton *tiXianBt;
@property (weak, nonatomic) IBOutlet UIButton *chongZhiBt;

@end

@implementation SWTMJMineMoneyVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"总资产";
    
    self.tiXianBt.backgroundColor = GreenColor;
    self.tiXianBt.layer.cornerRadius = 20;
    self.tiXianBt.clipsToBounds = YES;
    
    self.chongZhiBt.layer.cornerRadius = 20;
    self.chongZhiBt.clipsToBounds = YES;
    self.chongZhiBt.layer.borderColor = CharacterColor70.CGColor;
    self.chongZhiBt.layer.borderWidth = 0.5;
    
    self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",self.money.getPriceAllStr];
    
}

- (IBAction)action:(UIButton *)sender {
    
    
    [SVProgressHUD showSuccessWithStatus:@"该功能在未开放"];
    return;
    
    
    if (sender.tag == 100) {
        //提现
    }else if (sender.tag ==101) {
        //充值
        
        SWTMJChongZhiView * chongZhiView = [[SWTMJChongZhiView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        chongZhiView.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [chongZhiView.delegateSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
             
            
            
        }];
        [chongZhiView show];
        
    }else {
        //客服
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
