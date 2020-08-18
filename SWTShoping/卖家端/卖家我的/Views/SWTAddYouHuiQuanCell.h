//
//  SWTAddYouHuiQuanCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTAddYouHuiQuanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;

@end

NS_ASSUME_NONNULL_END
