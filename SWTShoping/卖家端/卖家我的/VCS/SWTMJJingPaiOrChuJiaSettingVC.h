//
//  SWTMJJingPaiOrChuJiaSettingVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJJingPaiOrChuJiaSettingVC : BaseViewController
@property(nonatomic,assign)BOOL isBaoZhengJin;
@property(nonatomic , strong)SWTModel *model;
@property(nonatomic , copy)void(^autoBlock)(SWTModel *model);
@end

NS_ASSUME_NONNULL_END
