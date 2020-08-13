//
//  SWTMineTwoCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJMineTwoCell : UITableViewCell
@property(nonatomic , strong)UILabel *titleLB;
@property(nonatomic , copy)void(^mineTwoCellBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
