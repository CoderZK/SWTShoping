//
//  SWTAVChatRoomView.h
//  SWTShoping
//
//  Created by kunzhang on 2020/8/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SWTAVChatRoomView : UIView
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArr;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic,copy)void(^clickPeopleBlock)(SWTModel *model);
@end


