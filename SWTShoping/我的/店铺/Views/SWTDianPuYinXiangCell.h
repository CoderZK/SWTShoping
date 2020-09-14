//
//  SWTDianPuYinXiangCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/9/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTDianPuYinXiangCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCons;

@end

NS_ASSUME_NONNULL_END
