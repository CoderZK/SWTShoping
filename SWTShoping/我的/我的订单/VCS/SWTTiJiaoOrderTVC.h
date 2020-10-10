//
//  SWTTiJiaoOrderTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTTiJiaoOrderTVC : BaseTableViewController
@property(nonatomic , strong)NSString *goodID,*merchID,*numStr;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
