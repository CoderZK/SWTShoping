//
//  SWTLaoYouOneCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTLaoYouOneCell : UITableViewCell
@property(nonatomic , strong)UIImageView *leftimgV;
@property(nonatomic , strong)UILabel *leftOneLB,*leftTwoLb,*leftThreeLB;
@property(nonatomic , strong)UIImageView *rightImgV;
@property(nonatomic , strong)UIButton *shopNameBt;
@property(nonatomic , strong)UILabel *moneyLB;

@property(nonatomic , strong)SWTModel *model;

@end

NS_ASSUME_NONNULL_END
