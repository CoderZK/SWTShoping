//
//  SWTShopIntorduceHeadView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTShopIntorduceHeadView : UIView
@property(nonatomic , strong)SWTModel *model;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic,strong)UIButton *lianxieBt,*gaunZhuBt;
@end

NS_ASSUME_NONNULL_END
