//
//  HangQingVC.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HangQingVC.h"
#import "SWTMessageOneCell.h"
#import "SWTMessageDetailListTVC.h"
@interface HangQingVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<V2TIMConversation *> *ListArr;
@property(nonatomic,assign)uint64_t stepNext;
@end

@implementation HangQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMessageOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.ListArr = @[].mutableCopy;
    self.stepNext = 0;
    [self getList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
        self.stepNext = 0;
        [self getList];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.ListArr.count < 20) {
            [self.tableView.mj_footer endRefreshing];
            return;
        }
        [self getList];
    }];
    
    
    
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        
        [weakSelf getData];
    };
    
    
    [LTSCEventBus registerEvent:@"diss" block:^(id data) {
        weakSelf.tabBarController.selectedIndex  = 0;
    }];
    
 
    
    
    
    
}

- (void)getList  {
    
    [[V2TIMManager sharedInstance] getConversationList:(self.stepNext) count:20 succ:^(NSArray<V2TIMConversation *> *list, uint64_t nextSeq, BOOL isFinished) {
        
       [self.tableView.mj_header endRefreshing];
       [self.tableView.mj_footer endRefreshing];
        
        if (self.stepNext == 0) {
            [self.ListArr removeAllObjects];
        }
        for (V2TIMConversation * con in  list) {
            if (con.type == V2TIM_C2C) {
                [self.ListArr addObject:con];
            }
        }
        self.stepNext = nextSeq;
        [self.tableView reloadData];
        
    } fail:^(int code, NSString *desc) {
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
    
    
}

- (void)getData {
    
    if (!ISLOGIN) {
        [self gotoLoginVC];
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"receiveid"] = [zkSignleTool shareTool].session_uid;
    //    dict[@"receiveid"] = @"1";
    [zkRequestTool networkingPOST:pushmsgList_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.dataArray.count == 0) {
                [self.noneView showNoneDataViewAt:self.view img:[UIImage imageNamed:@"dyx47"] tips:@"暂无数据"];
            }else {
                [self.noneView  dismiss];
            }
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }else {
        return self.ListArr.count;
    }
    
    //    return 10;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SWTMessageOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.nameLB.text = @"fgkodkgfeoprkgkp";
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SWTModel * model = self.dataArray[indexPath.row];
        cell.timeLB.text = model.createtime;
        cell.contentLB.text = model.content;
        if (model.type.intValue == 2) {
            cell.nameLB.text = @"系统消息";
        }else {
            cell.nameLB.text = model.site_name;
        }
        [cell.imgV sd_setImageWithURL:[model.logo getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        cell.redV.hidden = YES;
    }else {
        V2TIMConversation * conVerSation = self.ListArr[indexPath.row];
        
        [cell.imgV sd_setImageWithURL:[conVerSation.faceUrl getPicURL] placeholderImage:[UIImage imageNamed:@"369"] completed:nil];
        V2TIMMessage * lastM  = conVerSation.lastMessage;
        
        cell.timeLB.text = [NSString getDateWithDate:lastM.timestamp];
        if (lastM.elemType == V2TIM_ELEM_TYPE_TEXT) {
            cell.contentLB.text = lastM.textElem.text;
        }else if (lastM.elemType == V2TIM_ELEM_TYPE_IMAGE) {
            cell.contentLB.text = @"图片";
        }
        cell.nameLB.text = lastM.nickName;
        [cell.imgV sd_setImageWithURL:[lastM.faceURL getPicURL] placeholderImage:[UIImage imageNamed:@"369"] completed:nil];
        if (conVerSation.unreadCount >  0) {
            cell.redV.hidden = NO;
        }else {
            cell.redV.hidden = YES;
        }
    }
    
    return cell;
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
       
        [[V2TIMManager sharedInstance] deleteConversation:self.ListArr[indexPath.row].conversationID succ:^{
            [self.ListArr removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        } fail:^(int code, NSString *desc) {
            
        }];
     
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        SWTMessageDetailListTVC * vc =[[SWTMessageDetailListTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.sendid = self.dataArray[indexPath.row].sendid;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
        V2TIMConversation * conVerSation = self.ListArr[indexPath.row];
        
        TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:conVerSation.userID];
        TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
        vc.navigationItem.title = conVerSation.lastMessage.nickName;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
//        TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:conVerSation.conversationID];
//        TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
//        vc.navigationItem.title = conVerSation.lastMessage.nickName;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    
    
}



@end
