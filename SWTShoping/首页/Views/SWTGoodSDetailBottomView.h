//
//  SWTGoodSDetailBottomView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTGoodSDetailBottomView : UIView
@property(nonatomic , strong)UIButton *chujiaBt;
@property(nonatomic , strong)SWTBottomBt *dianPuBt,*siXinBt;

@property(nonatomic , strong)RACSubject *delegateSignal;

@end

NS_ASSUME_NONNULL_END
