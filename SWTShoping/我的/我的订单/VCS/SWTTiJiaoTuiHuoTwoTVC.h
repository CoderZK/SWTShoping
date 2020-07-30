//
//  SWTTiJiaoTuiHuoTwoTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTTiJiaoTuiHuoTwoTVC : BaseTableViewController
@property(nonatomic , strong)SWTModel *model;
@property(nonatomic , strong)NSString *reasonStr,*contextStr;
@property(nonatomic , strong)NSArray<UIImage *> *picArr;
@end

NS_ASSUME_NONNULL_END
