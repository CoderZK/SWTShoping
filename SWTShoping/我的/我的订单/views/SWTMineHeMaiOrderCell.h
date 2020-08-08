//
//  SWTMineHeMaiOrderCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineHeMaiOrderCell : UITableViewCell
@property(nonatomic , strong)UIImageView *leftHeadImgV;
@property(nonatomic , strong)UIImageView *leftimgV;//蹄片
@property(nonatomic , strong)UILabel *leftOneLB,*leftTwoLb,*leftThreeLB,*typeOneLB,*typeTwoLB;
@property(nonatomic , strong)UIImageView *rightImgV;
@property(nonatomic , strong)UIButton *shopNameBt;//标题名字

@property(nonatomic , strong)UIButton *rightOneBt,*rightTwoBt,*rightThreeBt;
@property(nonatomic , strong)UILabel *statusLB,*numberAndMoneyLB;

@property(nonatomic , strong)UIImageView *youJianV;
@property(nonatomic , strong)SWTModel *model;
@property(nonatomic , assign)NSInteger  type; // 1待完成  2已完成
@end

NS_ASSUME_NONNULL_END
