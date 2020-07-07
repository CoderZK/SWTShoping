//
//  SWTMineYouHuiQuanCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineYouHuiQuanCell : UITableViewCell
@property(nonatomic , copy)void(^clickHeadOrCellBlock)(NSInteger index,BOOL isHead);
@end

NS_ASSUME_NONNULL_END
