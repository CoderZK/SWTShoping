//
//  MJHeMaiPicCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJHeMaiPicCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray *picArr;
@property(nonatomic,copy)void(^delectBlock)(NSInteger index);
@property(nonatomic,copy)void(^addPicBlock)(NSInteger index);
@property(nonatomic,copy)void(^clickPlayActionBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
