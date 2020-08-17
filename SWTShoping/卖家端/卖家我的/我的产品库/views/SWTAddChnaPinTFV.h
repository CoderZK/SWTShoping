//
//  SWTAddChnaPinTFV.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTAddChnaPinTFV : UIView
@property(nonatomic , strong)UILabel *leftLB;
@property(nonatomic , strong)UITextField *TF;
@property(nonatomic , strong)UIImageView *rightImgV;
@property(nonatomic,assign)BOOL isChoose;
@property(nonatomic , strong)NSString *lestStr;
@property(nonatomic , strong)RACSubject *delegateSignal;
@end

NS_ASSUME_NONNULL_END
