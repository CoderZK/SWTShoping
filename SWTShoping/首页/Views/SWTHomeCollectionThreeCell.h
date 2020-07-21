//
//  SWTHomeCollectionThreeCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTHomeCollectionThreeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *typeOneLB;
@property (weak, nonatomic) IBOutlet UILabel *typeTwoLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yyCons;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
