//
//  SWTZhiBoBottomView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTZhiBoBottomView : UIView
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic,assign)BOOL isHeMai;
@property(nonatomic , strong)UITextField *TF;
@property(nonatomic , strong)UIButton *gouWuBt ,*shareBt,*collectBt,*heMaibt;
@property(nonatomic , strong)UILabel *numberLB;
@property(nonatomic , strong)SWTModel *model;
@end

NS_ASSUME_NONNULL_END
