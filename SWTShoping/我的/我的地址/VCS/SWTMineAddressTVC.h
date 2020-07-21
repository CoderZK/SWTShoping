//
//  SWTMineAddressTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineAddressTVC : BaseTableViewController
@property(nonatomic , copy)void(^sendAddressModelBlock)(SWTModel *model);

@end

NS_ASSUME_NONNULL_END
