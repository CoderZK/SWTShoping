//
//  SWTMineKeFuTwoCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineKeFuTwoCell : UITableViewCell
@property(nonatomic , strong)UIButton *headBt;
@property(nonatomic , strong)UIImageView *imgV;
@property(nonatomic , strong)UILabel *titleLB;
@property(nonatomic , strong)UIView * lineV;
@property(nonatomic , strong)UITableView *tableview;
@property(nonatomic , strong)NSMutableArray *dataArray;
@property(nonatomic , strong)RACSubject *delegateSignal;
@end

NS_ASSUME_NONNULL_END
