//
//  SWTGoodsDetailFiveCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTGoodsDetailFiveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backV;
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *typeLB;
@property (weak, nonatomic) IBOutlet UILabel *typeTwoLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *gaunzhuBt;
@property (weak, nonatomic) IBOutlet UIImageView *typeImgOne;
@property (weak, nonatomic) IBOutlet UIImageView *typeImgVTwo;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property(nonatomic , strong)SWTModel *model;

@end

NS_ASSUME_NONNULL_END
