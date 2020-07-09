//
//  SWTMienZuJiSubVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMienZuJiSubVC.h"
#import "SWTGuanZhuCollectionCell.h"
@interface SWTMienZuJiSubVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XPCollectionViewWaterfallFlowLayoutDataSource>
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;

@property(nonatomic , strong)UICollectionView *collectionView;

@end

@implementation SWTMienZuJiSubVC

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
       [self.collectionView registerNib:[UINib nibWithNibName:@"SWTGuanZhuCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SWTGuanZhuCollectionCell"];
       [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 9;
    //    return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SWTGuanZhuCollectionCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTGuanZhuCollectionCell" forIndexPath:indexPath];
    return cell;
    
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    
    return 2;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return 150 + arc4random() % 100;
    
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
