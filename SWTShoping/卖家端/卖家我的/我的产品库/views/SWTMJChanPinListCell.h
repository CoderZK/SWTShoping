//
//  SWTMJChanPinListCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJChanPinListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UILabel *chanDiLB;
@property (weak, nonatomic) IBOutlet UILabel *guiGeLB;
@property (weak, nonatomic) IBOutlet UILabel *caiZhiLB;
@property (weak, nonatomic) IBOutlet UILabel *kuCunLB;
@property (weak, nonatomic) IBOutlet UILabel *xiaoLiangLB;
@property (weak, nonatomic) IBOutlet UILabel *chanPinKuLB;

@end

NS_ASSUME_NONNULL_END
