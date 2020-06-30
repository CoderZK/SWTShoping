//
//  SWTMineHomeButton.h
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineHomeButton : UIButton

@property(nonatomic , strong)UIImageView *imgV;
@property(nonatomic , strong)UILabel *titleLB;

- (instancetype)initWithFrame:(CGRect)frame withImageWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
