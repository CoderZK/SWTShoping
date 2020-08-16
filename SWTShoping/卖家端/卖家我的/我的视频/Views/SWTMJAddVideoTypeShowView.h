//
//  SWTMJAddVideoTypeShowView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMJAddVideoTypeShowView : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , assign)NSInteger  type;
@property(nonatomic , strong)NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
