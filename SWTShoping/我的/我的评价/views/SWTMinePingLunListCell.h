//
//  SWTMinePingLunListCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMinePingLunListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *leftOneLB;
@property (weak, nonatomic) IBOutlet UILabel *leftThreeLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanLB;
@property (weak, nonatomic) IBOutlet UIButton *writeBt;
@property (weak, nonatomic) IBOutlet UILabel *leftTwoLB;
@end

NS_ASSUME_NONNULL_END
