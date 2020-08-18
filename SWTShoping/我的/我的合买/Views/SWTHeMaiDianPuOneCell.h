//
//  SWTHeMaiDianPuOneCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTHeMaiDianPuOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *jiaJiaLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *timeBt;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *typeOneLB;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property (weak, nonatomic) IBOutlet UILabel *typeTwoLB;

@property (nonatomic, assign)NSTimeInterval timeInterval;

@end

NS_ASSUME_NONNULL_END
