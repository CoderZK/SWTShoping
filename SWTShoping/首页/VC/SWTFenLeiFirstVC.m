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
@interface SWTFenLeiFirstVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic , strong)UITableView *leftV,*rightTV;
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic , strong)UICollectionViewFlowLayout *layout;
@property(nonatomic , strong)UIImageView *headImgV;
@end

@implementation SWTFenLeiFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类";
    
    [self setNavigateView];
    
    [self addTV];
    
    [self addCollectionView];
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
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTFenLeiFirstLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTFenLeiFirstLeftCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLB.text = @"玉翠珠宝";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(ScreenW - 100,40);
//}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SWTFenLeiCollectTwoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTFenLeiCollectTwoCell" forIndexPath:indexPath];
    return cell;
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    // 复用SectionHeaderView,SectionHeaderView是xib创建的
    SWTJiFenCollectHeadView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SWTJiFenCollectHeadView" forIndexPath:indexPath];
    headerView.clipsToBounds = YES;
    headerView.titleLB.text = @"推荐分类";
    return headerView;
    
}

@end
