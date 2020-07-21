//
//  SWTYiKouJiaGoodDetailCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/20.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTYiKouJiaGoodDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopNameLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UIButton *collectBt;
@property(nonatomic , strong)SWTModel *model;

@end

NS_ASSUME_NONNULL_END
