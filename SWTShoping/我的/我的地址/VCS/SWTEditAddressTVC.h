//
//  SWTEditAddressTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTEditAddressTVC : BaseTableViewController
@property(nonatomic , strong)SWTModel *model;
@property(nonatomic , copy)void(^sendAddressBlock)(SWTModel *model);
@end

NS_ASSUME_NONNULL_END
