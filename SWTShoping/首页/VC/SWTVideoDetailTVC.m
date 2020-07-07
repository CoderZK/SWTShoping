//
//  SWTVideoDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTVideoDetailTVC.h"
#import "SWTVideoDetailHeadView.h"
#import "SWTVideoDetailOneCell.h"
@interface SWTVideoDetailTVC ()
@property(nonatomic , strong)SWTVideoDetailHeadView *headV;
@property(nonatomic , strong)SWTNavitageView *naView;
@end

@implementation SWTVideoDetailTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.headV.avPlayer pause];
    [self.headV.avPlayer seekToTime:(CMTimeMake(0, 1))];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addHeadV];
    
    [self setNav];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTVideoDetailOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)addHeadV {
    
    self.headV  = [[SWTVideoDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.headV.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BackgroundColor;
    self.tableView.tableHeaderView = self.headV;
    [self addChildViewController:self.headV.playVC];
    
    
    
}

- (void)setNav {
    
    self.naView = [[SWTNavitageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 115 + sstatusHeight + 44)];
    self.naView.rightBt.hidden = YES;
    self.naView.titleLB.text = @"如何品鉴好物";
    @weakify(self);
    [[self.naView.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.naView.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    [self.view addSubview:self.naView];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view bringSubviewToFront:self.tableView];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(sstatusHeight + 44);
        if (sstatusHeight > 20) {
            make.bottom.equalTo(self.view);
        }else {
            make.bottom.equalTo(self.view).offset(-34);
        }
        
    }];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTVideoDetailOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = WhiteColor;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y<= 0) {
        
        self.naView.imgV.mj_h = sstatusHeight + 44 +115 - (scrollView.contentOffset.y);
    }else if (scrollView.contentOffset.y<= 115) {
        self.naView.imgV.mj_h = sstatusHeight +  44 +115 - (scrollView.contentOffset.y );
    }else {
        self.naView.imgV.mj_h = sstatusHeight + 44;
    }
    
    
    
}





@end
