//
//  SWTAddMineChanPinKuTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTAddMineChanPinKuTVC : BaseTableViewController
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic , strong)NSString *ID;
@property(nonatomic , copy)void(^addOrEditGoodSucessBlock)(SWTModel *model);
@end

NS_ASSUME_NONNULL_END
