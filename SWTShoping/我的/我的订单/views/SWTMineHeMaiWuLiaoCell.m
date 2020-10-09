//
//  SWTMineHeMaiWuLiaoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/10/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineHeMaiWuLiaoCell.h"
#import "MJPicCollectNeiCell.h"
@interface SWTMineHeMaiWuLiaoCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UICollectionView *collectV;

@end

@implementation SWTMineHeMaiWuLiaoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 15)];
        self.leftLB.font = kFont(13);
        self.leftLB.textColor = CharacterColor50;
        [self.contentView addSubview:self.leftLB];
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 125, 10, 110, 15)];
        self.timeLB.font = kFont(13);
        self.timeLB.textAlignment = NSTextAlignmentRight;
        self.timeLB.textColor = CharacterColor50;
        [self.contentView addSubview:self.timeLB];
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((ScreenW - 60)/4, (ScreenW - 60)/4);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        self.collectV = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 35, ScreenW - 30, (ScreenW - 60)/4) collectionViewLayout:layout];
        [self.contentView addSubview:self.collectV];
        self.collectV.delegate = self;
        self.collectV.dataSource = self;

        
        self.collectV.backgroundColor = WhiteColor;
        [self.collectV registerNib:[UINib nibWithNibName:@"MJPicCollectNeiCell" bundle:nil] forCellWithReuseIdentifier:@"MJPicCollectNeiCell"];
        
        UIView * lineV  = [[UIView alloc] init];
        lineV.backgroundColor = BackgroundColor;
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self.contentView);
            make.height.equalTo(@0.4);
        }];
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MJPicCollectNeiCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"MJPicCollectNeiCell" forIndexPath:indexPath];
    cell.playBt.hidden = YES;
    
    cell.chaBt.tag = indexPath.row;
    [cell.chaBt addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.isXiangQing) {
        cell.chaBt.hidden = YES;
        
        if (self.isHaveVideo) {
            if (indexPath.row == 0) {
                cell.playBt.hidden = NO;
                [cell.imgV sd_setImageWithURL:[self.picArr[0] getPicURL] placeholderImage:[UIImage imageNamed:@"369"]];
                [cell.playBt addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
            }else {
                cell.playBt.hidden = YES;
                [cell.imgV sd_setImageWithURL:[self.picArr[indexPath.row] getPicURL] placeholderImage:[UIImage imageNamed:@"369"]];
                
            }
            
        }else {
            cell.playBt.hidden = YES;
            [cell.imgV sd_setImageWithURL:[self.picArr[indexPath.row] getPicURL] placeholderImage:[UIImage imageNamed:@"369"]];
        }
    }else {
        
        if (indexPath.row == 0) {
            if ([self.picArr[0] length] == 0) {
                cell.chaBt.hidden = YES;
                cell.imgV.image = [UIImage imageNamed:@"bbdyx73"];
                
            }else {
                cell.chaBt.hidden = NO;
                [cell.imgV sd_setImageWithURL:[self.picArr[0] getPicURL] placeholderImage:[UIImage imageNamed:@"369"]];
                cell.playBt.hidden = NO;
                [cell.playBt addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }else {
            if ([self.picArr[indexPath.row] length] == 0) {
                cell.chaBt.hidden = YES;
                cell.imgV.image = [UIImage imageNamed:@"bbdyx72"];
            }else {
                cell.chaBt.hidden = NO;
                [cell.imgV sd_setImageWithURL:[self.picArr[indexPath.row] getPicURL] placeholderImage:[UIImage imageNamed:@"369"]];
                
            }
        }
        
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isHaveVideo ) {
        if (indexPath.row > 0) {
            NSArray * arr = [self.picArr subarrayWithRange:NSMakeRange(1, self.picArr.count -1)];
            [[zkPhotoShowVC alloc] initWithArray:arr index:indexPath.row -1];
        }
    }else {
        [[zkPhotoShowVC alloc] initWithArray:self.picArr index:indexPath.row];
    }
}

- (void)playAction {
//    [[PublicFuntionTool shareTool] presentVideoVCWithNSString:self.picArr[0] isBenDiPath:NO];
    if (self.clickPlayActionBlock != nil) {
        self.clickPlayActionBlock(self.picArr[0]);
    }
}

- (void)setPicArr:(NSMutableArray *)picArr {
    _picArr = picArr;
    if (self.isHaveVideo) {
        self.collectV.contentSize = CGSizeMake(((ScreenW - 60)/4 + 10 ) * (picArr.count + 1), (ScreenW - 60)/4);
    }else {
        self.collectV.contentSize = CGSizeMake(((ScreenW - 60)/4 + 10 ) * (picArr.count), (ScreenW - 60)/4);
    }
    [self.collectV reloadData];
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
