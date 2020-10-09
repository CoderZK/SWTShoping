//
//  SWTMineHeMaiWuLiaoCell.h
//  SWTShoping
//
//  Created by kunzhang on 2020/10/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTMineHeMaiWuLiaoCell : UITableViewCell
@property(nonatomic,strong)UILabel *leftLB,*timeLB;
@property(nonatomic,strong)SWTModel *model;
@property(nonatomic,strong)NSMutableArray *picArr;
@property(nonatomic,assign)BOOL isXiangQing,isHaveVideo;
@property(nonatomic,copy)void(^clickPlayActionBlock)(NSString *videoStr);
@property(nonatomic,copy)void(^addPicBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
