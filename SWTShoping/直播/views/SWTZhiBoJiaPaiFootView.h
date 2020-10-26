//
//  SWTZhiBoJiaPaiFootView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/10/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTZhiBoJiaPaiFootView : UIView
@property(nonatomic,strong)SWTModel  *model;
@property(nonatomic,assign)BOOL isOrder;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic,strong)NSString *PriceStr;
@end

NS_ASSUME_NONNULL_END
