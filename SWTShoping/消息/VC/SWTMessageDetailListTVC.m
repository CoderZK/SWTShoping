//
//  SWTMessageDetailListTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMessageDetailListTVC.h"
#import "SWTMessageDetailListCell.h"
@interface SWTMessageDetailListTVC ()

@property(nonatomic,strong)NSMutableArray<SWTModel *> *dataArray;
@end

@implementation SWTMessageDetailListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMessageDetailListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
    Weak(weakSelf);
    self.noneView.clickBlock = ^{
        
        
        [weakSelf getData];
    };
}

- (void)getData {
    
    if (!ISLOGIN) {
        [self gotoLoginVC];
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"receiveid"] = [zkSignleTool shareTool].session_uid;
    dict[@"sendid"] = self.sendid;;
    [zkRequestTool networkingPOST:pushmsgDetail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    //    return 10;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMessageDetailListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // cell.nameLB.text = @"fgkodkgfeoprkgkp";
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
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//   
//    return YES;
//}
//
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}
//
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
       
            
            
            [SVProgressHUD show];
            NSMutableDictionary * dict = @{}.mutableCopy;
            dict[@"sendid"] = self.dataArray[indexPath.row].sendid;
            dict[@"receiveid"] = [zkSignleTool shareTool].session_uid;
            [zkRequestTool networkingPOST:pushmsgDeletethis_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [SVProgressHUD dismiss];
                if ([responseObject[@"key"] intValue]== 1) {

                    [self.dataArray removeObjectAtIndex:indexPath.row];
                    [self.tableView reloadData];

                }else {
                    [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
                }

            } failure:^(NSURLSessionDataTask *task, NSError *error) {

                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];

            }];
           
        
        
     
        
    }
}


@end
