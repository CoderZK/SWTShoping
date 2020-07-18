//
//  SWTVideoDesOneCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTVideoDesOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
