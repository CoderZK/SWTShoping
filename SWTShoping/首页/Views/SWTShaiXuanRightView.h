//
//  SWTShaiXuanRightView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTShaiXuanRightView : UIView
- (instancetype)initWithFrame:(CGRect)frame withArr:(NSArray<SWTModel *> *)caiZhiArr;
- (void)show;
- (void)dismiss;
@property(nonatomic , copy)void(^shaiXuanBlock)(NSString * lowMoneyStr,NSString * heightMoneyStr,NSArray *caiLiaoIDarr,NSDictionary *fuwuDict);
@end

NS_ASSUME_NONNULL_END
