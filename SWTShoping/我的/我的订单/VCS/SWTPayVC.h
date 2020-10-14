//
//  SWTPayVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTPayVC : BaseViewController
@property(nonatomic , strong)NSString *orderID,*priceStr,*merchID;
@property(nonatomic,assign)BOOL isComeBaoZhengJin;
@property(nonatomic,assign)BOOL isComeZhiBo;
@end

NS_ASSUME_NONNULL_END
