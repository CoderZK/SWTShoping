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
@property(nonatomic , strong)UILabel *lb;

@end

@implementation SWTGoodsDetailTableViewContentCollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.layout =[[XPCollectionViewWaterfallFlowLayout alloc] init];
        self.layout.dataSource = self;
        
        self.collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1) collectionViewLayout:self.layout];;

//        self.collectionView.collectionViewLayout = self.layout;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        self.collectionView.scrollEnabled = NO;
        self.collectionView.backgroundColor = BackgroundColor;
        [self.contentView addSubview:self.collectionView];
        
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
        self.lb = lb;
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
    
    
    SWTHomeCollectionThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
//    if (indexPath.row == 0) {
//        SWTHomeCollectionTwoCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionTwoCell" forIndexPath:indexPath];
//        return cell;
//    }else {
//        SWTHomeCollectionThreeCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"SWTHomeCollectionThreeCell" forIndexPath:indexPath];
//        return cell;
//    }
    
}

- (void)setDataArray:(NSMutableArray<SWTModel *> *)dataArray {
    _dataArray = dataArray;
    self.collectionView.mj_h = 0;
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.collectionView.collectionViewLayout.collectionViewContentSize.height+40);
    }];
    if (dataArray.count == 0) {
        self.lb.hidden = YES;
    }else {
        self.lb.hidden = NO;
    }
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    SWTGoodsDetailTVC * vc =[[SWTGoodsDetailTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    //    vc.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:vc animated:YES];
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:self.dataArray[indexPath.row].goodid];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout numberOfColumnInSection:(NSInteger)section {
    
    return 2;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat imgH  =   (ScreenW - 30)/2 * 3/4;
    SWTModel * model = self.dataArray[indexPath.row];
    if ([model.showtype isEqualToString:@"live"]) {
        
        return  (ScreenW - 30)/2;
    }else {
        NSArray * arr = [model getTypeLBArr];
        if (arr.count == 0) {
            return imgH + 39;
        }else {
            return imgH + 59;
        }
    }
    
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
