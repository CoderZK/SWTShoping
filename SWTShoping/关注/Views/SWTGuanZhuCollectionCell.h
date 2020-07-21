//
//  SWTGuanZhuCollectionCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTGuanZhuCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UILabel *zhiBoZhongLB;
@property (weak, nonatomic) IBOutlet UIImageView *leftTopImgV;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
