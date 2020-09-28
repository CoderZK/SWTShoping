//
//  SWTJiShiFaBuView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/9/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTJiShiFaBuView : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic,assign)BOOL isSiJia;
@property(nonatomic,strong)NSString  *maiJiaName;
@property(nonatomic , strong)RACSubject *delegateSignal;
@end

NS_ASSUME_NONNULL_END
