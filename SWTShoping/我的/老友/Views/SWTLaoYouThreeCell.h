//
//  SWTLaoYouThreeCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTLaoYouThreeCell : UITableViewCell
@property(nonatomic , assign)NSInteger  type;// 1 2

@property(nonatomic , strong)NSString *htmlStr;
@property(nonatomic , strong)NSMutableDictionary *dataDict;
@property(nonatomic , strong)NSString *titleStr;

@end

NS_ASSUME_NONNULL_END
