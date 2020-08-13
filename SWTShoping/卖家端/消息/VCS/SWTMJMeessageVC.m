//
//  SWTMJMeessageVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMeessageVC.h"

@interface SWTMJMeessageVC ()

@end

@implementation SWTMJMeessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftNagate];
}

- (void)setLeftNagate {
    
    UIButton * leftBt  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBt setImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    @weakify(self);
    [[leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
}

@end
