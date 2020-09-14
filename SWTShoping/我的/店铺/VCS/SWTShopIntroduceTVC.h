//
//  SWTShopIntroduceTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTShopIntroduceTVC : BaseTableViewController
@property(nonatomic , strong)NSString *ID;
@property(nonatomic,strong)SWTModel *model;

@property(nonatomic,copy)void(^sendDataModelBlock)(SWTModel *model);

@end

NS_ASSUME_NONNULL_END
