//
//  SWTAddVideoTypeCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTAddVideoTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property(nonatomic , strong)SWTModel *model;

@end

NS_ASSUME_NONNULL_END
