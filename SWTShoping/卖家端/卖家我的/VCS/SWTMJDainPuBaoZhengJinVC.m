//
//  SWTMJDainPuBaoZhengJinVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJDainPuBaoZhengJinVC.h"
#import "SWTMJDianPuBaoZhengJinShowView.h"
@interface SWTMJDainPuBaoZhengJinVC ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;

@end

@implementation SWTMJDainPuBaoZhengJinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺保证金";
    if (self.dataModel.margin.length == 0) {
        self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",@"0"];
    }else {
       self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",self.dataModel.margin.getPriceAllStr];
    }
    

}
- (IBAction)payAction:(id)sender {
    
    SWTMJDianPuBaoZhengJinShowView * showV  = [[SWTMJDianPuBaoZhengJinShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    showV.dataArray = @[@"10",@"20",@"40",@"50",@"60",@"60",@"600"];
    
    showV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [showV.delegateSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        //点击
        
        
        
        
    }];
    
    [showV show];
    
}

@end
