//
//  SWTGoodsDetailChuJiaView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTGoodsDetailChuJiaView : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic , strong)UILabel *moneyLB;
@property(nonatomic , strong)UIButton *moneyBt;
@property(nonatomic , strong)UIButton *chujiaBt;

@end

NS_ASSUME_NONNULL_END
