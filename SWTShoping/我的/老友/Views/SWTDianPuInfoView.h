//
//  SWTDianPuInfoView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTDianPuInfoView : UIView
- (instancetype)initWithFrame:(CGRect)frame withIsJianTou:(BOOL)isJianTou withMaxNumber:(NSInteger)maxNumer;

@property(nonatomic , strong)UIButton *rightBt;
@property(nonatomic , strong)UILabel *leftLB;
@property(nonatomic , strong)UIImageView *rightImgV;
@property(nonatomic , strong)UITextField *rightTF;
@property(nonatomic , strong)UIView *lineV;


@end

NS_ASSUME_NONNULL_END
