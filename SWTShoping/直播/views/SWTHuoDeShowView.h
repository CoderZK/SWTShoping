//
//  SWTHuoDeShowView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTHuoDeShowView : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic,strong)SWTModel  *model;
@property(nonatomic , strong)RACSubject *delegateSignal;

@end

NS_ASSUME_NONNULL_END
