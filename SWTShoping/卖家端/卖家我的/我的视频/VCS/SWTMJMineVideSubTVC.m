//
//  SWTMJMineVideSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineVideSubTVC.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "SWTMJVideoCell.h"
#import "SWTMJUploadVideoTVC.h"
#import <AVKit/AVKit.h>
@interface SWTMJMineVideSubTVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XPCollectionViewWaterfallFlowLayoutDataSource>
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;

@property(nonatomic , strong)UICollectionView *collectionView;

@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , strong)AVPlayer *avPlayer;
@property(nonatomic , strong)AVPlayerViewController *playVC;
@end

@implementation SWTMJMineVideSubTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
    self.layout.dataSource = self;
    
    CGRect frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 - 40 - 49);
    if (sstatusHeight > 20) {
        frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 - 40 - 49 - 34);
    }
    
    
    self.collectionView  = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.layout];;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //               self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTMJVideoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTMJVideoCell"];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        weakSelf.page = 1;
        [weakSelf getData];
    };
    
    [LTSCEventBus registerEvent:@"addvideo" block:^(id data) {
        weakSelf.page = 1;
        [weakSelf getData];
    }];
}


- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageindex"] = @(self.page);
    dict[@"pagesize"] = @(20);
    dict[@"category"] = self.ID;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    
    [zkRequestTool networkingPOST:merchvideoGet_video_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [self.noneView showNoneDataViewAt:self.view img:[UIImage imageNamed:@"dyx47"] tips:@"暂无数据"];
            }else {
                [self.noneView  dismiss];
            }
            
            
            [self.collectionView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        
        
    }];
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //    return 9;
    return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SWTMJVideoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTMJVideoCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.playBt.tag = indexPath.row;
    [cell.playBt addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}



- (void)playAction:(UIButton *)button {
    //    [PublicFuntionTool presentVideoVCWithNSString:self.dataArray[button.tag].video isBenDiPath:NO];
    //
    NSString * video = self.dataArray[button.tag].video;
    NSURL * url = [NSURL URLWithString:video];
    
    AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:url];
    self.avPlayer = avPlayer;
    self.playVC = [[AVPlayerViewController alloc] init];
//    [self addChildViewController:self.playVC];
    self.playVC.view.frame = CGRectMake(0, 0, ScreenW, 0);
    self.playVC.player = avPlayer;
    [self.avPlayer play];
    
    [self presentViewController:self.playVC animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJUploadVideoTVC * vc =[[SWTMJUploadVideoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isEdit = YES;
    Weak(weakSelf);
    vc.sendVideoBlock = ^(SWTModel * _Nonnull model) {
        weakSelf.dataArray[indexPath.row] = model;
        [weakSelf.collectionView reloadData];
    };
    vc.dataModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    
    return 2;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenW -30)/2;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10.0, 10.0, 10.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}


@end
