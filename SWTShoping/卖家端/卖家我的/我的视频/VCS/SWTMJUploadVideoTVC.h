//
//  SWTMJUploadVideoTVC.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJUploadVideoTVC : BaseTableViewController
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , copy)void(^sendVideoBlock)(SWTModel *model);
@end

NS_ASSUME_NONNULL_END
