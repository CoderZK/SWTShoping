//
//  SWTMineGuanZHuDinaPuCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SWTMineGuanZHuDinaPuCell;


@protocol SWTMineGuanZHuDinaPuCellDelegate <NSObject>

- (void)didClickGuanZhuDianPuView:(SWTMineGuanZHuDinaPuCell *)cell withIndex:(NSInteger)index isClickHead:(BOOL)isClickHead;

@end

@interface SWTMineGuanZHuDinaPuCell : UITableViewCell
@property(nonatomic , strong)NSMutableArray *dataArray;
@property(nonatomic,assign)id<SWTMineGuanZHuDinaPuCellDelegate>delegate;
@end


