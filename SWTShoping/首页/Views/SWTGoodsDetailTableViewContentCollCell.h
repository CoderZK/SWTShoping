//
//  SWTGoodsDetailTableViewContentCollCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface SWTGoodsDetailTableViewContentCollCell : UITableViewCell
@property(nonatomic , strong)XPCollectionViewWaterfallFlowLayout *layout;
@property(nonatomic , strong)UICollectionView *collectionView;

@property(nonatomic , strong)NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
