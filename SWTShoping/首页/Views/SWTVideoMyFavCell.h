//
//  SWTVideoMyFavCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTVideoMyFavCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *scanNUmberLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIView *backV;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
