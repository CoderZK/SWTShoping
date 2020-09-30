//
//  MJHeMaiPicCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiPicCell.h"
#import "MJPicCollectNeiCell.h"
@interface MJHeMaiPicCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectV;

@end


@implementation MJHeMaiPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((ScreenW - 60)/4, (ScreenW - 60)/4);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        self.collectV = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 100) collectionViewLayout:layout];
        [self.contentView addSubview:self.collectV];
        self.collectV.delegate = self;
        self.collectV.dataSource = self;
        [self.collectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(15);
            make.bottom.right.equalTo(self).offset(-15);
        }];
  
        self.collectV.backgroundColor = WhiteColor;
        [self.collectV registerNib:[UINib nibWithNibName:@"MJPicCollectNeiCell" bundle:nil] forCellWithReuseIdentifier:@"MJPicCollectNeiCell"];
        
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
    if (self.addPicBlock != nil) {
        self.addPicBlock(indexPath.row);
    }
}

- (void)delectAction:(UIButton *)button {
    self.picArr[button.tag] = @"";
    if (self.delectBlock != nil) {
        self.delectBlock(button.tag);
    }
    [self.collectV reloadData];
}

- (void)playAction {
//    [[PublicFuntionTool shareTool] presentVideoVCWithNSString:self.picArr[0] isBenDiPath:NO];
    if (self.clickPlayActionBlock != nil) {
        self.clickPlayActionBlock(0);
    }
}

- (void)setPicArr:(NSMutableArray *)picArr {
    _picArr = picArr;
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
