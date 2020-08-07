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
#import "SWTVideoMyFavCell.h"
#import "SWTVideoDesOneCell.h"
@interface SWTVideoDetailTVC ()
@property(nonatomic , strong)SWTVideoDetailHeadView *headV;
@property(nonatomic , strong)SWTNavitageView *naView;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *myFavDataArr;
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
    self.myFavDataArr = @[].mutableCopy;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTVideoDetailOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTVideoMyFavCell" bundle:nil] forCellReuseIdentifier:@"SWTVideoMyFavCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTVideoDesOneCell" bundle:nil] forCellReuseIdentifier:@"SWTVideoDesOneCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 40;
    [self getTopData];

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
    
//    [[self.naView.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:@"17"];
//        TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
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


- (void)getTopData {
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:videoDetail_SWT parameters:self.videoID success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            
            self.headV.videoStr = self.dataModel.video;
            
            [self getMyFavData];
            
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        ;
        
    }];
}

- (void)getMyFavData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"categoryid"] = self.dataModel.category;
    [zkRequestTool networkingPOST:videoFav_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.myFavDataArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        ;
        
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.myFavDataArr.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 30;
    }else {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    }else if (indexPath.section == 1) {
         return UITableViewAutomaticDimension;
    }else {
       
        return UITableViewAutomaticDimension;
      
    }

}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SWTVideoDetailOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = WhiteColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        SWTVideoDesOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTVideoDesOneCell" forIndexPath:indexPath];
        cell.backgroundColor = WhiteColor;
        cell.model = self.dataModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        SWTVideoMyFavCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTVideoMyFavCell" forIndexPath:indexPath];
        cell.backgroundColor = WhiteColor;
        cell.model = self.myFavDataArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
   UIView * view = [tableView dequeueReusableCellWithIdentifier:@"head"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.backgroundColor = BackgroundColor;
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [tableView dequeueReusableCellWithIdentifier:@"head"];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
        view.backgroundColor = WhiteColor;
        UILabel * LB =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 20)];
        LB.font = kFont(14);
        LB.text = @"猜你喜欢";
        LB.textAlignment = NSTextAlignmentCenter;
        [view addSubview:LB];
    }
    view.clipsToBounds = YES;
    return view;
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
