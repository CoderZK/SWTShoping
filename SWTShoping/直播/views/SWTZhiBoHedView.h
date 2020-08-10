//
//  SWTZhiBoHedView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTZhiBoHedView : UIView
@property(nonatomic , strong)UIButton *headBt,*guanzhuBt;
@property(nonatomic , strong)UILabel *nameLB,*fanAndSeeLB;
@property(nonatomic , strong)UIView *shopV;
@property(nonatomic , strong)UILabel *shopNameLB,*shopIdLB;

@property(nonatomic , strong)SWTModel *model;

@end

NS_ASSUME_NONNULL_END
