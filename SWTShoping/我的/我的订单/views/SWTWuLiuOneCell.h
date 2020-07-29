//
//  SWTWuLiuOneCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTWuLiuOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIView *topLineV;
@property (weak, nonatomic) IBOutlet UIView *bottomLineV;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@end

NS_ASSUME_NONNULL_END
