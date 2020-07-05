//
//  SWTLaoYouHomeTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouHomeTVC.h"
#import "SWTLaoYouHomeHeadView.h"
@interface SWTLaoYouHomeTVC ()
@property(nonatomic , strong)SWTLaoYouHomeHeadView *headV;
@end

@implementation SWTLaoYouHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要开店";
    [self initAddHeadV];
    
}

- (void)initAddHeadV{
    self.headV =[[SWTLaoYouHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    self.tableView.tableHeaderView = self.headV;
}


@end
