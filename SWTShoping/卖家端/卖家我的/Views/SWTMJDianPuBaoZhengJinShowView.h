//
//  SWTMJDianPuBaoZhengJinShowView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJDianPuBaoZhengJinShowView : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic , strong)NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
