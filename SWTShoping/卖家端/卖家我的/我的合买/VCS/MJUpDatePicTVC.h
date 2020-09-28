//
//  MJUpDatePicTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJUpDatePicTVC : BaseTableViewController
@property(nonatomic,assign)NSInteger type; // 1 抽签, 2 开料 3 毛坯, 5 成品
@property(nonatomic,strong)NSString *goodsID;
@property(nonatomic,strong)SWTModel *dataModel;



@end

NS_ASSUME_NONNULL_END
