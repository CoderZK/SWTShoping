//
//  MJHeMaiDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiDetailTVC.h"
#import "MJHeadView.h"
#import "MJHeMaiOrderCell.h"
#import "MJHeMaiQianHaoCell.h"
#import "MJHeMaiPicCell.h"
#import <AVKit/AVKit.h>
#import "SWTMJFaHuoShowView.h"
@interface MJHeMaiDetailTVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MJHeadView *headV;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *picArr;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)SWTModel *dataModel;
@property(nonatomic,assign)BOOL isHaveVideo;
@property(nonatomic , strong)AVPlayer *avPlayer;
@property(nonatomic , strong)AVPlayerViewController *playVC;
@property(nonatomic,strong)SWTMJFaHuoShowView *showV;
@end

@implementation MJHeMaiDetailTVC

- (void)viewDidLoad {
    self.navigationItem.title = @"合买详情";
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.headV = [[MJHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    self.tableView.tableHeaderView = self.headV;
    [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiOrderCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiQianHaoCell" bundle:nil] forCellReuseIdentifier:@"MJHeMaiQianHaoCell"];
    [self.tableView registerClass:[MJHeMaiPicCell class] forCellReuseIdentifier:@"MJHeMaiPicCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    [self.tableView reloadData];
    
    //    self.view.backgroundColor = UIColor.greenColor;
    self.tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    self.picArr = @[].mutableCopy;
    
    
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getData];
    }];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"orderid"] = self.orderID;
    [zkRequestTool networkingPOST:merchsharedetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.picArr = @[].mutableCopy;
            for (SWTModel * model  in self.dataModel.lotinfo) {
                
                if (model.type.intValue == 1) {
                    self.isHaveVideo = NO;
                    if (model.videos.length > 0) {
                        [self.picArr insertObject:model.videos atIndex:0];
                        self.isHaveVideo = YES;
                        [self.picArr addObjectsFromArray: [model.imgs componentsSeparatedByString:@","]];
                    }else {
                        [self.picArr addObjectsFromArray: [model.imgs componentsSeparatedByString:@","]];
                    }
                }
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if (self.dataModel.childorderinfo.count == 0) {
            return 0;
        }
        return self.dataModel.childorderinfo.count+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 125;
    }else if (indexPath.section == 1) {
        return 40;
    }else {
        if (self.picArr.count == 0) {
            return 0;
        }else {
           return (ScreenW - 60)/4 * (self.picArr.count / 4 +  self.picArr.count % 4 > 0?1:0)+ 50;
        }
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MJHeMaiOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
        cell.model = self.model;
        cell.leftBt.hidden = cell.centerBt.hidden = cell.rightBt.hidden = YES;
        return cell;
    }else if (indexPath.section == 1) {
        MJHeMaiQianHaoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"MJHeMaiQianHaoCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.LB1.font = cell.LB2.font =cell.LB3.font = kFont(14);
            cell.LB1.textColor = cell.LB2.textColor =cell.LB3.textColor = CharacterColor50;
            [cell.leftBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
            [cell.rigthBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
            cell.LB1.text = @"签号";
            cell.LB2.text = @"用户名";
            cell.LB3.text = @"所处阶段";
            [cell.leftBt setTitle:@"联系买家" forState:UIControlStateNormal];
            [cell.rigthBt setTitle:@"订单状态" forState:UIControlStateNormal];
            cell.leftBt.layer.borderWidth = cell.rigthBt.layer.borderWidth = 0;
            
        }else {
            cell.LB1.font = cell.LB2.font =cell.LB3.font = kFont(13);
            cell.leftBt.titleLabel.font = cell.rigthBt.titleLabel.font = kFont(13);
            cell.LB1.textColor = cell.LB2.textColor =cell.LB3.textColor = CharacterColor50;
            cell.leftBt.layer.borderWidth = cell.rigthBt.layer.borderWidth = 0.5;
            cell.model = self.dataModel.childorderinfo[indexPath.row - 1];
            cell.rigthBt.tag = indexPath.row - 1;
            [cell.rigthBt addTarget:self action:@selector(faHuoActin:) forControlEvents:UIControlEventTouchUpInside];
        }
        cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
        return cell;
    }
    MJHeMaiPicCell * cell =[tableView dequeueReusableCellWithIdentifier:@"MJHeMaiPicCell" forIndexPath:indexPath];
    cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
    Weak(weakSelf);
    cell.delectBlock = ^(NSInteger index) {
        weakSelf.picArr[index] = @"";
    };
    cell.addPicBlock = ^(NSInteger index) {
        [weakSelf addPicWithIndex:index];
    };
    cell.clickPlayActionBlock = ^(NSInteger index) {
        NSString * video = weakSelf.picArr[0];;
        NSURL * url = [NSURL URLWithString:video];
        
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
    cell.isHaveVideo = self.isHaveVideo;
    cell.picArr = self.picArr;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (void)faHuoActin:(UIButton *)button {
    
    if ([button.titleLabel.text isEqualToString:@"待发货"]) {
        SWTModel * model = self.dataModel.childorderinfo[button.tag];
        [self faHuoActionWithModel:model];
    }
}


//发货
- (void)faHuoActionWithModel:(SWTModel *)model {
    
    SWTMJFaHuoShowView * showV  =[[SWTMJFaHuoShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    showV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [showV.delegateSignal subscribeNext:^(NSArray * x) {
        @strongify(self);
        
        [self sendGoodWithArr:x withID:model.ID];
        
    }];
    self.showV = showV;
    [showV show];
    
    
}

//发货
- (void)sendGoodWithArr:(NSArray *)arr withID:(NSString *)ID{
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = ID;
    dict[@"expresssn"] = arr[0];
    dict[@"expressid"] = arr[1];
    dict[@"expressname"] = arr[2];
    dict[@"express"] = arr[3];
    [zkRequestTool networkingPOST:merchorderSend_order_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"发货成功"];
            [self getData];
            [self.showV dismiss];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}



//天机图片或者视频
- (void)addPicWithIndex:(NSInteger)index {
    
    self.selectIndex = index;
    
    if (index == 0) {
        if (self.isHaveVideo) {
            NSString * video = self.picArr[0];;
            NSURL * url = [NSURL URLWithString:video];
            
            AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:url];
            self.avPlayer = avPlayer;
            self.playVC = [[AVPlayerViewController alloc] init];
            //    [self addChildViewController:self.playVC];
            self.playVC.view.frame = CGRectMake(0, 0, ScreenW, 0);
            self.playVC.player = avPlayer;
            [self.avPlayer play];
            
            [self presentViewController:self.playVC animated:YES completion:nil];
        }else {
            [[zkPhotoShowVC alloc] initWithArray:@[self.picArr[self.selectIndex]] index:0];
        }
    }else {
        [[zkPhotoShowVC alloc] initWithArray:@[self.picArr[self.selectIndex]] index:0];
    }
    
    
    
    
    
}



@end
