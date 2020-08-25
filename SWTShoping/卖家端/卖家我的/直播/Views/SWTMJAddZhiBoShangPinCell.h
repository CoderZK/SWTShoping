//
//  SWTMJAddZhiBoShangPinCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/25.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJAddZhiBoShangPinCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
