//
//  SWTMJVideoCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJVideoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *playBt;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
