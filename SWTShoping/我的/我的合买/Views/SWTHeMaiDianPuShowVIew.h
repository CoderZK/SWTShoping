//
//  SWTHeMaiDianPuShowVIew.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTHeMaiDianPuShowVIew : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , strong)SWTModel *dataModel;
@property(nonatomic , strong)RACSubject *delegateSignal;
@end

NS_ASSUME_NONNULL_END
