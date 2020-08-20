//
//  SWTMineOrderCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineOrderCell :UITableViewCell
@property(nonatomic , strong)UIImageView *leftHeadImgV;
@property(nonatomic , strong)UIImageView *leftimgV;//蹄片
@property(nonatomic , strong)UILabel *leftOneLB,*leftTwoLb,*leftThreeLB,*typeOneLB,*typeTwoLB;
@property(nonatomic , strong)UIImageView *rightImgV;
@property(nonatomic , strong)UIButton *shopNameBt;//标题名字
@property(nonatomic , strong)UIImageView *headImgV;

@property(nonatomic , strong)UIButton *rightOneBt,*rightTwoBt,*rightThreeBt;
@property(nonatomic , strong)UILabel *statusLB,*numberAndMoneyLB;

@property(nonatomic , strong)SWTModel *model;//买家
@property(nonatomic , strong)SWTModel *mjModel;//卖家
//0未支付1待发货2待收货3待评价4已完成5已关闭-1交易失败 -2 全部

@end

NS_ASSUME_NONNULL_END
