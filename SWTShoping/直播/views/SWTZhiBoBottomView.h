//
//  SWTZhiBoBottomView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTZhiBoBottomView : UIView
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic,assign)BOOL isHeMai;
@end

NS_ASSUME_NONNULL_END
