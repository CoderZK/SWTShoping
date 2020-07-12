//
//  SWTSendMinePingLunTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTSendMinePingLunTVC.h"
#import "SWTPingJiaHeadV.h"
@interface SWTSendMinePingLunTVC ()
@property(nonatomic , strong)SWTPingJiaHeadV *headV;
@end

@implementation SWTSendMinePingLunTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发表评价";
    self.headV  =[[SWTPingJiaHeadV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.tableView.tableHeaderView = self.headV;
    
    
    
    
    
    
    
}



@end
