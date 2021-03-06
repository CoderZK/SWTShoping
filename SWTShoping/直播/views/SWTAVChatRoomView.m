//
//  SWTAVChatRoomView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAVChatRoomView.h"
#import "SWTAVChatRoomCell.h"
#import "SWTAvChatZhongQianCell.h"
@interface SWTAVChatRoomView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SWTAVChatRoomView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView  = [[UITableView alloc] init];
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[SWTAVChatRoomCell class] forCellReuseIdentifier:@"cell"];
        [self.tableView registerClass:[SWTAvChatZhongQianCell class] forCellReuseIdentifier:@"SWTAvChatZhongQianCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.backgroundColor  = [UIColor clearColor];
        
    }
    
    return self;
}

- (void)setDataArr:(NSMutableArray<SWTModel *> *)dataArr {
    _dataArr = dataArr;
    [self.tableView reloadData];
    
    if(dataArr.count > 0){

    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:dataArr.count-1  inSection:0];

    [_tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];

    }

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWTModel * model = self.dataArr[indexPath.row];
    
    if (model.type.intValue == 0 || model.type.intValue == 1) {
        SWTAVChatRoomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.headImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        cell.nameLB.text = model.nickname;
        cell.contentLB.text = model.content;
        [cell.leveBt setTitle:model.levelcode forState:UIControlStateNormal];
        if (model.levelcode.length == 0) {
            [cell.leveBt setTitle:@"0" forState:UIControlStateNormal];
        }
        
        if (model.type.intValue == 0) {
            //正常聊天
            cell.nameLB.textColor = YellowColor;
            cell.backV.backgroundColor = [UIColor clearColor];
        }else {
            cell.nameLB.textColor = WhiteColor;
            cell.backV.backgroundColor = RedColor;
        }
        
        return cell;
    }else  {
        SWTAvChatZhongQianCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTAvChatZhongQianCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLB.text = [NSString stringWithFormat:@"恭喜用户%@  获得%@号签",model.nickname,model.lotsno];
        return cell;
    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.clickPeopleBlock != nil) {
        self.clickPeopleBlock(self.dataArr[indexPath.row]);
    }
    
}


@end
