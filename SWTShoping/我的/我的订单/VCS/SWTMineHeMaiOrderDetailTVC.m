//
//  SWTMineHeMaiOrderDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/10/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineHeMaiOrderDetailTVC.h"
#import "SWTMineHeMaiOrderCell.h"
#import "SWTMineHeMaiWuLiaoCell.h"
#import <AVKit/AVKit.h>
@interface SWTMineHeMaiOrderDetailTVC ()
@property(nonatomic,strong)UIView *HeadV;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)SWTModel *yuanLiaoModel,*kaiLiaoModel,*maoPiModel,*changPinModel;
@property(nonatomic , strong)AVPlayer *avPlayer;
@property(nonatomic , strong)AVPlayerViewController *playVC;
@end

@implementation SWTMineHeMaiOrderDetailTVC




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    
    [self.tableView registerClass:[SWTMineHeMaiOrderCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[SWTMineHeMaiWuLiaoCell class] forCellReuseIdentifier:@"SWTMineHeMaiWuLiaoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    [self getData];
    [self addTableHeadV];
}

- (void)addTableHeadV {
    self.HeadV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    self.HeadV.backgroundColor = RGB(30, 28, 35);
    self.tableView.tableHeaderView = self.HeadV;
    
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 20)];
    [self.HeadV addSubview:self.titleLB];
    self.titleLB.textColor = WhiteColor;
    self.titleLB.font = kFont(14);
    
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"orderid"] = self.dataModel.ID;
    [zkRequestTool networkingPOST:shareOrderdetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            SWTModel * model  = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            for (SWTModel * neiM in model.lotinfo) {
                if (neiM.type.intValue == 1) {
                    self.yuanLiaoModel = neiM;
                }
                if (neiM.type.intValue == 2) {
                    self.kaiLiaoModel = neiM;
                }
                if (neiM.type.intValue == 3) {
                    self.maoPiModel = neiM;
                }
                if (neiM.type.intValue == 5) {
                    self.changPinModel = neiM;
                }
            }
            
            if (model.status.intValue == 0) {
                self.titleLB.text = @"待付款";
            }else if (model.status.intValue == 1) {
                self.titleLB.text = @"待发货";
            }else if (model.status.intValue == 2) {
                self.titleLB.text = @"已发货";
            }else if (model.status.intValue == 3) {
                self.titleLB.text = @"交易完成";
            }else if (model.status.intValue == 4) {
                self.titleLB.text = @"交易完成";
            }
            
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return UITableViewAutomaticDimension;
    }else {
        if (indexPath.row == 0) {
            if (self.yuanLiaoModel == nil) {
                return 0;
            }else {
                return 35 + (ScreenW - 60)/4 + 15;
            }
        }else if (indexPath.row == 1) {
            if (self.kaiLiaoModel == nil) {
                return 0;
            }else {
                return 35 + (ScreenW - 60)/4 + 15;
            }
        }else if (indexPath.row == 2) {
            if (self.maoPiModel == nil) {
                return 0;
            }else {
                return 35 + (ScreenW - 60)/4 + 15;
            }
        }else  {
            if (self.changPinModel == nil) {
                return 0;
            }else {
                return 35 + (ScreenW - 60)/4 + 15;
            }
        }
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SWTMineHeMaiOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.rightOneBt.tag = indexPath.row;
        [cell.rightOneBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.type = self.type;
        cell.model = self.dataModel;
        return cell;
    }else {
        
    }
    
    SWTMineHeMaiWuLiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineHeMaiWuLiaoCell" forIndexPath:indexPath];
    Weak(weakSelf);
    cell.clickPlayActionBlock = ^(NSString * videoStr) {
        
        NSString * video = videoStr;
        NSURL * url = [NSURL URLWithString:[video stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]]];
        
        AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:url];
        weakSelf.avPlayer = avPlayer;
        weakSelf.playVC = [[AVPlayerViewController alloc] init];
        //    [self addChildViewController:self.playVC];
        weakSelf.playVC.view.frame = CGRectMake(0, 0, ScreenW, 0);
        weakSelf.playVC.player = avPlayer;
        [weakSelf.avPlayer play];
        

        
        [weakSelf presentViewController:weakSelf.playVC animated:YES completion:nil];
    };
    cell.isXiangQing = YES;
    if (indexPath.row == 0) {
        if (self.yuanLiaoModel.videos.length > 0) {
            cell.isHaveVideo = YES;
            NSMutableArray * arr = @[].mutableCopy;
            [arr addObject:self.yuanLiaoModel.videos];
            [arr addObjectsFromArray: [self.yuanLiaoModel.imgs componentsSeparatedByString:@","]];
            cell.picArr = arr;
        }else{
            cell.isHaveVideo = NO;
            cell.picArr = [self.yuanLiaoModel.imgs componentsSeparatedByString:@","].mutableCopy;
        }
        cell.timeLB.text = self.yuanLiaoModel.createtime;
        cell.leftLB.text = @"原料结果";
        
    }else if (indexPath.row == 1) {
        if (self.kaiLiaoModel.videos.length > 0) {
            cell.isHaveVideo = YES;
            NSMutableArray * arr = @[].mutableCopy;
            [arr addObject:self.kaiLiaoModel.videos];
            [arr addObjectsFromArray: [self.kaiLiaoModel.imgs componentsSeparatedByString:@","]];
            cell.picArr = arr;
        }else{
            cell.isHaveVideo = NO;
            cell.picArr = [self.kaiLiaoModel.imgs componentsSeparatedByString:@","].mutableCopy;
        }
        cell.timeLB.text = self.kaiLiaoModel.createtime;
        cell.leftLB.text = @"开料结果";
    }else if (indexPath.row == 2) {
        if (self.maoPiModel.videos.length > 0) {
            cell.isHaveVideo = YES;
            NSMutableArray * arr = @[].mutableCopy;
            [arr addObject:self.maoPiModel.videos];
            [arr addObjectsFromArray: [self.maoPiModel.imgs componentsSeparatedByString:@","]];
            cell.picArr = arr;
        }else{
            cell.isHaveVideo = NO;
            cell.picArr = [self.maoPiModel.imgs componentsSeparatedByString:@","].mutableCopy;
        }
        cell.timeLB.text = self.maoPiModel.createtime;
        cell.leftLB.text = @"毛坯结果";
    }else if (indexPath.row == 3) {
       if (self.changPinModel.videos.length > 0) {
            cell.isHaveVideo = YES;
            NSMutableArray * arr = @[].mutableCopy;
            [arr addObject:self.changPinModel.videos];
            [arr addObjectsFromArray: [self.changPinModel.imgs componentsSeparatedByString:@","]];
            cell.picArr = arr;
        }else{
            cell.isHaveVideo = NO;
            cell.picArr = [self.changPinModel.imgs componentsSeparatedByString:@","].mutableCopy;
        }
        cell.timeLB.text = self.changPinModel.createtime;
        cell.leftLB.text = @"产品结果";
    }
    cell.clipsToBounds = YES;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


//点击链接卖家
- (void)clickAction:(UIButton *)button {
    
    
    TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:self.dataModel.imid];
    TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
    vc.navigationItem.title = self.dataModel.store_name;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
