//
//  SWTMJDainPuBaoZhengJinVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJDainPuBaoZhengJinVC : BaseViewController
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , copy)void(^sendBaoZhenJinBlock)(SWTModel *model);
@end

NS_ASSUME_NONNULL_END
