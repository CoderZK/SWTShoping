//
//  SWTTuiHuiOneCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTTuiHuiOneCell : UITableViewCell
@property(nonatomic , strong)UIImageView *leftimgV;//蹄片
@property(nonatomic , strong)UILabel *leftOneLB,*leftTwoLb,*leftThreeLB,*typeOneLB,*typeTwoLB;
@property(nonatomic , strong)UIImageView *rightImgV;
@property(nonatomic , strong)UIButton *shopNameBt;//标题名字

@property(nonatomic , strong)UIButton *rightOneBt,*rightTwoBt;
@property(nonatomic , strong)UILabel *statusLB,*numberAndMoneyLB;
@property(nonatomic , strong)UIView *lineV;
@end

NS_ASSUME_NONNULL_END
