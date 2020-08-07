//
//  SWTPayVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTPayVC.h"

@interface SWTPayVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UIButton *payBt;
@property(nonatomic , assign)NSInteger  payType; // 100,101,102
@end

@implementation SWTPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clickAction:(UIButton *)sender {
    
    if (sender.tag == 100) {
        self.imgV1.image = [UIImage imageNamed:@"dyx43"];
        self.imgV2.image = [UIImage imageNamed:@"dyx44"];
        self.imgV2.image = [UIImage imageNamed:@"dyx44"];
        self.payType = sender.tag;
    }else if (sender.tag == 101) {
        self.imgV1.image = [UIImage imageNamed:@"dyx44"];
        self.imgV2.image = [UIImage imageNamed:@"dyx43"];
        self.imgV2.image = [UIImage imageNamed:@"dyx44"];
        self.payType = sender.tag;
    }else if (sender.tag == 102) {
        self.imgV1.image = [UIImage imageNamed:@"dyx44"];
        self.imgV2.image = [UIImage imageNamed:@"dyx44"];
        self.imgV2.image = [UIImage imageNamed:@"dyx43"];
        self.payType = sender.tag;
    }else if (sender.tag == 103) {
        
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
