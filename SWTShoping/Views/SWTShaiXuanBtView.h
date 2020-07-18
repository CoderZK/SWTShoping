//
//  SWTShaiXuanBtView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/18.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTShaiXuanBtView : UIView


@property(nonatomic,strong)NSString *selectImageStr,*nomalImageStr;
@property(nonatomic,strong)UIColor *selectColor,*nomalColor;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,assign)CGFloat hh;
@property(nonatomic,assign)BOOL isTitleArr;
@property(nonatomic,assign)BOOL isNoSelectOne; //第一个可以选中 YES 是不选中, NO选中
@property(nonatomic,assign)BOOL isNomalNOSelectOne; //是否默认地选中第一个
@property(nonatomic,assign)BOOL isNOCanSelectAll;
@property(nonatomic,assign)BOOL isContainSelectImage;



@property(nonatomic , strong)NSMutableArray *selectArr;
@property(nonatomic , strong)NSMutableDictionary *selectDict;
@property(nonatomic,copy)void(^selectBlock)();



@end

NS_ASSUME_NONNULL_END
