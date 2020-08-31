//
//  SWTShopSettingTVC.h
//  SWTZBMH
//
//  Created by kunzhang on 2020/8/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTShopSettingTVC : BaseTableViewController
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , copy)void(^shopSettingBlock)(SWTModel *model);
@end

NS_ASSUME_NONNULL_END
