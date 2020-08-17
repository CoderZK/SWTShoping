//
//  SWTAddChanPinOneCellCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTAddChanPinOneCellCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet UIButton *addBt;
@property(nonatomic , assign)NSInteger  type;
@end

NS_ASSUME_NONNULL_END
