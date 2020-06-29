//
//  SWTHomeHeadView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/6/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWTHomeHeadView;
@protocol SWTHomeHeadViewDelegate <NSObject>

- (void)didClickHomeHeadViewWithIndex:(NSInteger)index andIsLunBoTu:(BOOL)isLunBo;

@end



@interface SWTHomeHeadView : UIView
@property(nonatomic , strong)UIImageView *imgV;
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)SDCycleScrollView *sdView;
@property(nonatomic , assign)id<SWTHomeHeadViewDelegate>delegate;
@end


