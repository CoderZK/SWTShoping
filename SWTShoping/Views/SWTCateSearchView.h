//
//  SWTCateSearchView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTCateButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface SWTCateSearchView : UIView
@property(nonatomic , strong)UIButton *paiMaiBt;//拍卖
@property(nonatomic , strong)UIButton *yiKouJiaBt;
@property(nonatomic , strong)SWTCateButton *shaixuanBtn;
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIScrollView *scrollView;
@property(nonatomic , strong)SWTCateButton *priceBt,*timeBt;
@property(nonatomic , strong)UIView*redV;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic , assign)NSInteger  selectIndex;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , assign)NSInteger  jiaGeClickNumber,timeNumber;
@end

NS_ASSUME_NONNULL_END
