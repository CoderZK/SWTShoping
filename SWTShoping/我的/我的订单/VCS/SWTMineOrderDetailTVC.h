//
//  SWTMineOrderDetailTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineOrderDetailTVC : BaseTableViewController
@property(nonatomic , strong)NSString *ID;
@property(nonatomic , strong)NSString *IDTwo;
@property(nonatomic,assign)BOOL isMj;
@property(nonatomic,assign)BOOL isShouHou;

@end

NS_ASSUME_NONNULL_END
