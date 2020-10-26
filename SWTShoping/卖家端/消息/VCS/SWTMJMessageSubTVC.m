//
//  SWTMJMessageSubTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMessageSubTVC.h"
#import "SWTMJMessageOneCell.h"
#import "SWTMessageOneCell.h"
#import <TUIConversationListController.h>
@interface SWTMJMessageSubTVC ()<TUIConversationListControllerDelegagte>
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<V2TIMConversation *> *ListArr;
@property(nonatomic,assign)uint64_t stepNext;
@property(nonatomic,assign)BOOL isShowRed;
@end

@implementation SWTMJMessageSubTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getList];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJMessageOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMessageOneCell" bundle:nil] forCellReuseIdentifier:@"SWTMessageOneCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    if (self.type == 0) {
        self.page = 1;
        self.dataArray = @[].mutableCopy;
        [self getData];
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 1;
            [self getData];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.page++;
            [self getData];
        }];
        Weak(weakSelf);
        self.noneView.clickBlock = ^{


            [weakSelf getData];
        };
    }else {
        
        
//        TUIConversationListController *vc = [[TUIConversationListController alloc] init];
//        vc.delegate = self;
//
//        [self addChildViewController:vc];
//        [self.view addSubview:vc.view];
        
        self.ListArr = @[].mutableCopy;
         self.stepNext = 0;
           self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

               self.stepNext = 0;
               [self getList];
           }];

           self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
               if (self.ListArr.count < 50) {
                   [self.tableView.mj_footer endRefreshing];
                   return;
               }
               [self getList];
           }];
        
        
    }
    
    [LTSCEventBus registerEvent:@"cmessage" block:^(id data) {
            if (self.type == 1) {
                self.stepNext = 0;
                [self getList];
            }
       }];
}


- (void)conversationListController:(TUIConversationListController *)conversationController didSelectConversation:(TUIConversationCell *)conversation
{
    // 会话列表点击事件，通常是打开聊天界面
    
    TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:conversation.convData.convId];
    TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
    id x  = conversation.convData.title;
    if ([[x mj_JSONObject] isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dict = (NSDictionary *)[x mj_JSONObject];
        if ([dict.allKeys containsObject:@"nickname"]) {
            vc.navigationItem.title = dict[@"nickname"];
        }else {
            vc.navigationItem.title = @"";
        }
        
    }else {
        vc.navigationItem.title = conversation.convData.title;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)showRedV {
    for (V2TIMConversation * conVerSation  in self.ListArr) {
        if (conVerSation.unreadCount > 0 ) {
            self.isShowRed = YES;
            break;
        }else {
            self.isShowRed = NO;
        }
    }
    [LTSCEventBus sendEvent:@"showmessage" data:@(self.isShowRed)];
}


- (void)getList  {
    
    [[V2TIMManager sharedInstance] getConversationList:(self.stepNext) count:50 succ:^(NSArray<V2TIMConversation *> *list, uint64_t nextSeq, BOOL isFinished) {
        
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
        [self showRedV];
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
    dict[@"memberid"] = [zkSignleTool shareTool].session_uid;
    dict[@"pageindex"] = @(self.page);
    dict[@"pagesize"] = @(20);
    [zkRequestTool networkingPOST:merchmsgGet_msg_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
            NSArray<SWTModel *>*arr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [self.noneView showNoneDataViewAt:self.view img:[UIImage imageNamed:@"dyx47"] tips:@"暂无数据"];
            }else {
                [self.noneView  dismiss];
            }
            self.page++;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type == 0) {
        return self.dataArray.count;
    }
    return self.ListArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) {
        return 70;
    }
    return 80;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        SWTMJMessageOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else {
        SWTMessageOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMessageOneCell" forIndexPath:indexPath];
        V2TIMConversation * conVerSation = self.ListArr[indexPath.row];
        
        [cell.imgV sd_setImageWithURL:[conVerSation.faceUrl getPicURL] placeholderImage:[UIImage imageNamed:@"369"] completed:nil];
        V2TIMMessage * lastM  = conVerSation.lastMessage;
        
        cell.timeLB.text = [NSString getDateWithDate:lastM.timestamp];
        if (lastM.elemType == V2TIM_ELEM_TYPE_TEXT) {
            cell.contentLB.text = lastM.textElem.text;
        }else if (lastM.elemType == V2TIM_ELEM_TYPE_IMAGE) {
            cell.contentLB.text = @"图片";
        }
        
        id tempOne = conVerSation.showName ;
        if ([[tempOne mj_JSONObject] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)[tempOne mj_JSONObject];
            if ([dict.allKeys containsObject:@"nickname"]) {
                cell.nameLB.text = dict[@"nickname"];
            }else {
                cell.nameLB.text = @"";
            }
        }else {
            cell.nameLB.text = tempOne;
        }
        
//       id  tempDataTwo = [lastM.nickName mj_JSONObject];
//        if ([tempDataTwo isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *dict = (NSDictionary *)tempDataTwo;
//            if ([dict.allKeys containsObject:@"nickname"]) {
//                cell.nameLB.text = dict[@"nickname"];
//            }else {
//                cell.nameLB.text = @"";
//            }
//        }else {
//            id tempOne = conVerSation.showName ;
//            if ([[tempOne mj_JSONObject] isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *dict = (NSDictionary *)[tempOne mj_JSONObject];
//                if ([dict.allKeys containsObject:@"nickname"]) {
//                    cell.nameLB.text = dict[@"nickname"];
//                }else {
//                    cell.nameLB.text = @"";
//                }
//            }else {
//                cell.nameLB.text = tempOne;
//            }
//        }
        [cell.imgV sd_setImageWithURL:[lastM.faceURL getPicURL] placeholderImage:[UIImage imageNamed:@"369"] completed:nil];
        if (conVerSation.unreadCount >  0) {
            cell.redV.hidden = NO;
        }else {
            cell.redV.hidden = YES;
        }
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.type == 1) {
        
        V2TIMConversation * conVerSation = self.ListArr[indexPath.row];
        
        TIMConversation *conv = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:conVerSation.userID];
        TUIChatController *vc = [[TUIChatController alloc] initWithConversation:conv];
        NSDictionary * dict = [conVerSation.showName mj_JSONObject];
        if ([dict.allKeys containsObject:@"nickname"]) {
            vc.navigationItem.title = dict[@"nickname"];
        }
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
   
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
        if (self.type == 1) {
            [[V2TIMManager sharedInstance] deleteConversation:self.ListArr[indexPath.row].conversationID succ:^{
                [self.ListArr removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
            } fail:^(int code, NSString *desc) {
                
            }];
        }else {
            
            
            [SVProgressHUD show];
            NSMutableDictionary * dict = @{}.mutableCopy;
            dict[@"sendid"] = self.dataArray[indexPath.row].sendid;
            dict[@"receiveid"] = [zkSignleTool shareTool].session_uid;
            [zkRequestTool networkingPOST:pushmsgDeletethis_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [SVProgressHUD dismiss];
                if ([responseObject[@"code"] intValue]== 200) {

                    [self.dataArray removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];

                }else {
                    [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
                }

            } failure:^(NSURLSessionDataTask *task, NSError *error) {

                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];

            }];
           
        }
        
     
        
    }
}



@end
