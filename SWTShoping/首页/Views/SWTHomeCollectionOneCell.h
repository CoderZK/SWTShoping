//
//  SWTHomeCollectionOneCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/6/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTHomeCollectionOneCell : UICollectionViewCell
@property(nonatomic , strong)RACSubject *delegateSignal;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
