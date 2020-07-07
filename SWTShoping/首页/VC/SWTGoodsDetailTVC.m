//
//  SWTGoodsDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailTVC.h"
#import "SWTGoodsDetailHeadV.h"
#import "SWTGoodsDetailTableViewContentCollCell.h"
#import "SWTGoodsDetailTwoCell.h"
#import "SWTGoodsDetailThreeCell.h"
#import "SWTGoodsDetailFourCell.h"
#import "SWTGoodsDetailFiveCell.h"
#import "SWTGoodSDetailBottomView.h"
#import "SWTGoodsDetailChuJiaView.h"
#import "SWTGouMaiShowView.h"
#import "SWTTiJiaoOrderTVC.h"
@interface SWTGoodsDetailTVC ()
@property(nonatomic , strong)SWTNavitageView *naView;
@property(nonatomic , strong)SWTGoodsDetailHeadV *headV;
@property(nonatomic , strong)SWTGoodSDetailBottomView  *bottomView;
@property(nonatomic , strong)SWTGoodsDetailChuJiaView *chuJiaView;
@end

@implementation SWTGoodsDetailTVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BackgroundColor;
    
    [self setNav];
    [self addHeadV];
    [self initBottomV];
    
    [self.tableView registerClass:[SWTGoodsDetailTableViewContentCollCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTGoodsDetailTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTGoodsDetailThreeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailFiveCell" bundle:nil] forCellReuseIdentifier:@"SWTGoodsDetailFiveCell"];
    
    [self.tableView registerClass:[SWTGoodsDetailFourCell class] forCellReuseIdentifier:@"SWTGoodsDetailFourCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 40;
}


- (void)addHeadV {
    self.headV  = [[SWTGoodsDetailHeadV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.headV.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headV;
 
    
}

- (void)setNav {
    
    self.naView = [[SWTNavitageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 115 + sstatusHeight + 44)];
    
    @weakify(self);
    [[self.naView.leftBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.naView.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           
       }];
    [self.view addSubview:self.naView];
    
    [self.view bringSubviewToFront:self.tableView];
}

- (void)initBottomV {
    
    self.bottomView = [[SWTGoodSDetailBottomView alloc] init];
    [self.view addSubview:self.bottomView];
    
    self.bottomView.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [self.bottomView.delegateSignal subscribeNext:^(NSNumber *x) {
        @strongify(self);
        //点击出价店铺私信等
        
        if (x.intValue == 100) {
            //点击店铺
            SWTTiJiaoOrderTVC * vc =[[SWTTiJiaoOrderTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (x.intValue == 101) {
            SWTGouMaiShowView * gouMaiV  = [[SWTGouMaiShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [gouMaiV show];
            //点击私信
        }else if (x.intValue == 102) {
            //点击出价
            self.chuJiaView  = [[SWTGoodsDetailChuJiaView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            [self.chuJiaView show];
        }
        
        
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (sstatusHeight > 20) {
           make.bottom.equalTo(self.view).offset(-(34));
        }else {
           make.bottom.equalTo(self.view);
        }
        make.height.equalTo(@60);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(sstatusHeight + 44);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 30 + 40*3;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 0.01;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [tableView dequeueReusableCellWithIdentifier:@"head"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.backgroundColor = BackgroundColor;
    }
    return view;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SWTGoodsDetailTwoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailTwoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1) {
        SWTGoodsDetailThreeCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailThreeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2) {
        SWTGoodsDetailFourCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailFourCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 3) {
        SWTGoodsDetailFiveCell  *cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailFiveCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        SWTGoodsDetailTableViewContentCollCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

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
