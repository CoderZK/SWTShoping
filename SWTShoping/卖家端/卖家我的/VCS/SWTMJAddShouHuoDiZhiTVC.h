//
//  SWTMJAddShouHuoDiZhiTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJAddShouHuoDiZhiTVC : BaseTableViewController
@property(nonatomic,assign)BOOL isShop;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , copy)void(^addTuiHuoAddressBlock)(SWTModel *model);
@end

NS_ASSUME_NONNULL_END
