//
//  SWTFenLeiFirstVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTFenLeiFirstVC.h"
#import "SWTFenLeiFirstLeftCell.h"
#import "SWTJiFenCollectHeadView.h"
#import "SWTFenLeiCollectTwoCell.h"
#import "SWTCateSubVC.h"
@interface SWTFenLeiFirstVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic , strong)UITableView *leftV;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic , strong)UICollectionViewFlowLayout *layout;
@property(nonatomic , strong)UIImageView *headImgV;
@property(nonatomic , strong)NSString *selectFirstID;
@property(nonatomic , assign)NSInteger  selectIndex;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *leftDataArr;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *rightDataArr;
@end

@implementation SWTFenLeiFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectFirstID = @"-1";
    self.navigationItem.title = @"分类";
    
    [self setNavigateView];
    [self addTV];
    [self addCollectionView];
    
    self.leftDataArr = @[].mutableCopy;
    self.rightDataArr = [NSMutableArray array];
    [self getFirstCateData];
    [self getTopImgStr];

}

- (void)getTopImgStr  {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"4";
    [zkRequestTool networkingPOST:topimg_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            [self.headImgV sd_setImageWithURL:[ [NSString stringWithFormat:@"%@",responseObject[@"data"]] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
       
    }];
    
}

- (void)getFirstCateData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:goodTopcategory_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        [self.leftV.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.leftDataArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.leftV reloadData];
            if (self.selectFirstID.intValue == -1 && self.leftDataArr.count > 0) {
                self.selectIndex = 0;
                self.selectFirstID = self.leftDataArr[0].ID;
                [self.leftV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                [self getScondCaterData];
            }
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.leftV.mj_header endRefreshing];
       
    }];
}




- (void)getScondCaterData {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:goodChildcategory_SWT parameters:self.selectFirstID success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        [self.collectionView.mj_header endRefreshing];
        if ([responseObject[@"code"] intValue]== 200) {

            self.rightDataArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.collectionView reloadData];

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_header endRefreshing];

    }];
    
}


- (void)addTV {
    
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenW, 0.5)];
    backV.backgroundColor = lineBackColor;
    [self.view addSubview:backV];
    
    
    UIView * backVTwo =[[UIView alloc] initWithFrame:CGRectMake(99.5, 40, 0.5, ScreenH - sstatusHeight - 44 - 40)];
    backVTwo.backgroundColor = lineBackColor;
    [self.view addSubview:backVTwo];
    
    self.leftV  =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, 99, ScreenH - sstatusHeight - 44 - 40)];
    [self.leftV registerNib:[UINib nibWithNibName:@"SWTFenLeiFirstLeftCell" bundle:nil] forCellReuseIdentifier:@"SWTFenLeiFirstLeftCell"];
    self.leftV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.leftV.delegate = self;
    self.leftV.dataSource = self;
    [self.view addSubview:self.leftV];
    
    
    
}

- (void)addCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = (ScreenW - 100 - 210)/3;
    layout.itemSize = CGSizeMake(70, 70);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0,(ScreenW - 100 - 210)/6, 0, (ScreenW - 100 - 210)/6);
    layout.headerReferenceSize = CGSizeMake(ScreenW - 100, 40);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(100, 40, ScreenW - 100, ScreenH - sstatusHeight - 44 - 40) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView setContentInset:UIEdgeInsetsMake(90, 0, 0, 0)];
    self.headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, -90, ScreenW - 120, 90)];
    self.headImgV.image = [UIImage imageNamed:@"369"];
    [self.collectionView addSubview:self.headImgV];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SWTFenLeiCollectTwoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTFenLeiCollectTwoCell"];
    [self.collectionView registerClass:[SWTJiFenCollectHeadView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SWTJiFenCollectHeadView"];
    [self.view addSubview:self.collectionView];
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftDataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTFenLeiFirstLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTFenLeiFirstLeftCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLB.text = self.leftDataArr[indexPath.row].name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndex = indexPath.row;
    self.selectFirstID = self.leftDataArr[indexPath.row].ID;
    [self getScondCaterData];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rightDataArr.count;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(ScreenW - 100,40);
//}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SWTFenLeiCollectTwoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTFenLeiCollectTwoCell" forIndexPath:indexPath];
    cell.model = self.rightDataArr[indexPath.row];
    
    return cell;
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SWTCateSubVC * vc =[[SWTCateSubVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.naStr = self.rightDataArr[self.selectIndex].name;
//    vc.selectIndex = indexPath.row;
    vc.ID = self.rightDataArr[indexPath.row].ID;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 复用SectionHeaderView,SectionHeaderView是xib创建的
    SWTJiFenCollectHeadView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SWTJiFenCollectHeadView" forIndexPath:indexPath];
    headerView.clipsToBounds = YES;
    if (self.leftDataArr.count > self.selectIndex) {
        headerView.titleLB.text = self.leftDataArr[self.selectIndex].name;
    }
    return headerView;
    
}

@end
