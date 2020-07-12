//
//  SWTHeMaiTwoCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTHeMaiTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *yiwenbt;
@property (weak, nonatomic) IBOutlet UILabel *leftOneLB;
@property (weak, nonatomic) IBOutlet UILabel *leftTwoLB;
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property (weak, nonatomic) IBOutlet UISwitch *swithBt;
@property (weak, nonatomic) IBOutlet UIView *lineV;

@end

NS_ASSUME_NONNULL_END
