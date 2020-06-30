//
//  SWTMineOneCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineOneCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UIButton *vipBt;
@property (weak, nonatomic) IBOutlet UILabel *czLB;
@property (weak, nonatomic) IBOutlet UIButton *qusestBt;
@property (weak, nonatomic) IBOutlet UIButton *edibtBt;
@property(nonatomic , copy)void(^mineOneCellBlock)(NSInteger index);
@property(nonatomic , strong)UIButton *guanZhuBt;
@end

NS_ASSUME_NONNULL_END
