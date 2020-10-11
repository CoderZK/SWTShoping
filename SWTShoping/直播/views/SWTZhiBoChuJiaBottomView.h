//
//  SWTZhiBoChuJiaBottomView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTZhiBoChuJiaBottomView : UIView
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic,strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
