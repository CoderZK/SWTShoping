//
//  SWTChanPinSearchView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTChanPinSearchView : UIView
@property(nonatomic , assign)NSInteger  type;

- (void)show;
- (void)dismiss;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic , strong)NSArray *dataArray;
@property(nonatomic , strong)NSString *chanPinKuID;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *canPinKuArr;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *canPinFenLeiArr;
@property(nonatomic , strong)NSString *leiBieID,*feiLeiID,*timeType,*chanPinKuType;
@end

NS_ASSUME_NONNULL_END
