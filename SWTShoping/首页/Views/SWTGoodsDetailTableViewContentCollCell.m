//
//  SWTGoodsDetailTableViewContentCollCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailTableViewContentCollCell.h"
#import "SWTHomeCollectionOneCell.h"
#import "SWTHomeCollectionTwoCell.h"
#import "SWTHomeCollectionThreeCell.h"
@interface SWTGoodsDetailTableViewContentCollCell()<UICollectionViewDelegate,UICollectionViewDataSource,XPCollectionViewWaterfallFlowLayoutDataSource>

@end

@implementation SWTGoodsDetailTableViewContentCollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
        self.layout.dataSource = self;
        
        self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1) collectionViewLayout:self.layout];;

        self.collectionView.collectionViewLayout = self.layout;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        self.collectionView.scrollEnabled = NO;
        self.collectionView.backgroundColor = BackgroundColor;
        [self addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.height.equalTo(@40);
            make.width.equalTo(@(ScreenW));
        }];
        
        
        [self.collectionView registerClass:[SWTHomeCollectionOneCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionTwoCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"SWTHomeCollectionThreeCell" bundle:nil] forCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell"];
        
        self.collectionView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
        UIView * headV = [[UIView alloc] initWithFrame:CGRectMake(0, -40, ScreenW, 40)];
        [self.collectionView addSubview:headV];
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 35)];
        lb.font  = kFont(14);
        lb.textColor = CharacterColor50;
        lb.text = @"店铺精选";
        [headV addSubview:lb];
        
        
    }
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
    //    return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        SWTHomeCollectionTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell" forIndexPath:indexPath];
        return cell;
    }else {
        SWTHomeCollectionThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell" forIndexPath:indexPath];
        return cell;
    }
    
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.collectionView.collectionViewLayout.collectionViewContentSize.height + 40);
    }];
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    
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



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
