//
//  SWTTuiHuoThreeCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTTuiHuoThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *leftBt;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (weak, nonatomic) IBOutlet UIView *lineV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wdCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *riCons;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic , strong)SWTModel *model;

@end

NS_ASSUME_NONNULL_END
