//
//  SWTZhiBoGeRenShowView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/10/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SWTZhiBoGeRenShowViewDelegate <NSObject>

- (void)clickChuangJianSiDanWithModel:(SWTModel *)model;

@end

@interface SWTZhiBoGeRenShowView : UIView
- (void)show;
- (void)dismiss;
@property(nonatomic,strong)NSString *liveid;
@property(nonatomic,strong)SWTModel *model;
@property(nonatomic,assign)id<SWTZhiBoGeRenShowViewDelegate>delegate;
@end


