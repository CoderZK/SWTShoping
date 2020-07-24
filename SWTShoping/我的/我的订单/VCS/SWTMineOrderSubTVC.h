//
//  SWTMineOrderSubTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineOrderSubTVC : BaseTableViewController
@property(nonatomic , assign)NSInteger  type; // 0未支付1待发货2待收货3待评价4已完成5已关闭-1交易失败 -2 全部


@end

NS_ASSUME_NONNULL_END
