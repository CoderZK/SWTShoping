//
//  SWTAddChanPinHeadView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTAddChnaPinTFV.h"
NS_ASSUME_NONNULL_BEGIN

@interface SWTAddChanPinHeadView : UIView
@property(nonatomic , strong)SWTAddChnaPinTFV *leiBieV,*nameV,*addressV,*guiGeV,*caizhiV,*weightV;
@property(nonatomic , strong)UITextField *chanPinNameTF;
@property(nonatomic , strong)IQTextView *TV;
@property(nonatomic , strong)UIScrollView *picV;
@property(nonatomic , strong)NSMutableArray  *picArr;
@property(nonatomic , strong)NSString *videoStr;
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic , assign)CGFloat HHHH;
@end

NS_ASSUME_NONNULL_END
