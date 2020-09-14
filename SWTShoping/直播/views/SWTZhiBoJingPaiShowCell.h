//
//  SWTZhiBoJingPaiShowCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTZhiBoJingPaiShowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *jiaJiaLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property (weak, nonatomic) IBOutlet UIButton *shuaXinAction;
@property(nonatomic , strong)SWTModel *model;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property(nonatomic,assign)BOOL isJiPai;

@end

NS_ASSUME_NONNULL_END
