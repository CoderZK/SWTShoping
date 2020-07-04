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
@interface SWTGoodsDetailTVC ()
@property(nonatomic , strong)SWTNavitageView *naView;
@property(nonatomic , strong)SWTGoodsDetailHeadV *headV;
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
    
    [self.tableView registerClass:[SWTGoodsDetailTableViewContentCollCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTGoodsDetailTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTGoodsDetailThreeCell"];
    
    [self.tableView registerClass:[SWTGoodsDetailFourCell class] forCellReuseIdentifier:@"SWTGoodsDetailFourCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 40;
}


- (void)addHeadV {
    self.headV  = [[SWTGoodsDetailHeadV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.headV.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headV;
    self.tableView.mj_y = sstatusHeight + 44;
    self.tableView.mj_h = ScreenH - sstatusHeight - 44;
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 20 + 40*3;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 0.01;
    }
    return 10;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SWTGoodsDetailTwoCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailTwoCell" forIndexPath:indexPath];
        return cell;
        
    }else if (indexPath.section == 1) {
        SWTGoodsDetailThreeCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailThreeCell" forIndexPath:indexPath];
               return cell;
    }else if (indexPath.section == 2) {
        SWTGoodsDetailFourCell  * cell  =[tableView dequeueReusableCellWithIdentifier:@"SWTGoodsDetailFourCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 3) {
        
    }else {
        SWTGoodsDetailTableViewContentCollCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
        return cell;
    }
    
    SWTGoodsDetailTableViewContentCollCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.dataArray = @[@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
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
