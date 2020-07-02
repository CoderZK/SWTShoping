//
//  SWTFenLeiFirstVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTFenLeiFirstVC.h"

@interface SWTFenLeiFirstVC ()
@property(nonatomic , strong)UITableView *leftV,*rightTV;
@end

@implementation SWTFenLeiFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类";
    
    [self setNavigateView];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 40, ScreenW, 0.5)];
    backV.backgroundColor = lineBackColor;
    [self.view addSubview:backV];
    

    UIView * backVTwo =[[UIView alloc] initWithFrame:CGRectMake(99.5, 40, 0.5, ScreenH - sstatusHeight - 44 - 40)];
    backVTwo.backgroundColor = lineBackColor;
    [self.view addSubview:backVTwo];
    
}

- (void)addTV {
    
    
    
}



- (void)setNavigateView {
    
    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 35)];
    searchTitleView.searchTF.delegate = self;
    
    searchTitleView.isPush = NO;
    searchTitleView.isBlack = YES;
    searchTitleView.searchTF.placeholder = @"请输入竞拍品";
    
  
    @weakify(self);
    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        @strongify(self);
        if (value.length > 0) {
            return YES;
        }else {
            return NO;
        }
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"======\n%@",x);
    }];
    [self.view addSubview:searchTitleView];
    
}

@end
