//
//  SWTMJMineZhengRenMessage.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJMineZhengRenMessage : BaseTableViewController
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , copy)void(^upshopMessageBlock)(SWTModel *model);
@end

NS_ASSUME_NONNULL_END
