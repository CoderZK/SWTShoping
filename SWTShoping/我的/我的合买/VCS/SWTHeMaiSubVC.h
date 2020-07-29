//
//  SWTHeMaiSubVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTHeMaiSubVC : BaseViewController
@property(nonatomic , assign)NSInteger  type;
@property(nonatomic , assign)BOOL isHeMai;
@property(nonatomic , strong)NSString *pidId;
@end

NS_ASSUME_NONNULL_END
