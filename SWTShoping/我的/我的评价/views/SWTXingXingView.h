//
//  SWTXingXingView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/11.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTXingXingView : UIView
@property(nonatomic , assign)NSInteger  score;
@property(nonatomic , strong)RACSubject *delegateSignal;
@end

NS_ASSUME_NONNULL_END
