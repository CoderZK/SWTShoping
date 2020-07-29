//
//  SWTChengZhangShowView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTChengZhangShowView : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *leverArr;
@end

NS_ASSUME_NONNULL_END
