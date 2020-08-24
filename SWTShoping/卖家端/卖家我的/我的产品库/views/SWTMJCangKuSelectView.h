//
//  SWTMJCangKuSelectView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJCangKuSelectView : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic , strong)NSArray<SWTModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
