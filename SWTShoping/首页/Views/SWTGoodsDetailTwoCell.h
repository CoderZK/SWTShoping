//
//  SWTGoodsDetailTwoCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTGoodsDetailTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIButton *collectionBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *desLB;
@property (weak, nonatomic) IBOutlet UIButton *refreshBt;
@property (weak, nonatomic) IBOutlet UIButton *chujiaBt;
@property (weak, nonatomic) IBOutlet UILabel *moneyLB;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic , strong)SWTModel *model;
@property (nonatomic, assign)NSTimeInterval timeInterval;
@end

NS_ASSUME_NONNULL_END
