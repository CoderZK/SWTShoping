//
//  SWTPingJiaHeadV.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/11.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTPingJiaHeadV : UIView
@property(nonatomic , strong)NSMutableArray<UIImage *> *picArr;
@property(nonatomic , strong)SWTModel *model;
@property(nonatomic , strong)RACSubject *delegateSignal;


@property(nonatomic , strong)UIView *whiteView,*whiteTwoView;
@property(nonatomic , strong)UIImageView *leftimgV;//蹄片
@property(nonatomic , strong)UILabel *leftOneLB,*leftTwoLb,*leftThreeLB,*manyiLB,*shopNameLB;
@property(nonatomic , strong)SWTXingXingView *xingView1,*xingView2,*xingView3;
@property(nonatomic , strong)IQTextView *textV;
@property(nonatomic , strong)UIScrollView *picV;

@end

NS_ASSUME_NONNULL_END
