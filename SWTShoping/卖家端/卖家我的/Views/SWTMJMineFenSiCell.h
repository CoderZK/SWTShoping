//
//  SWTMJMineFenSiCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJMineFenSiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *vipBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UIButton *guanZhuBt;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
