//
//  SWTLaoYouThreeCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTLaoYouThreeCell : UITableViewCell
@property(nonatomic , assign)NSInteger  type;// 1 2
@property(nonatomic , strong)NSMutableArray *dataArray;
@end

NS_ASSUME_NONNULL_END
