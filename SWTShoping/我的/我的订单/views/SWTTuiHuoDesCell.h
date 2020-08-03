//
//  SWTTuiHuoDesCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTTuiHuoDesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftOneLB;
@property (weak, nonatomic) IBOutlet UILabel *leftTwoLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picCons;
@property (weak, nonatomic) IBOutlet UIView *backV;
@property(nonatomic , strong)NSArray *picArr;
@property (weak, nonatomic) IBOutlet UIView *picV;
@property(nonatomic , strong)NSString *reasonStr,*contextStr;
@end

NS_ASSUME_NONNULL_END
