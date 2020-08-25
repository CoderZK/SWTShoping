//
//  SWTMJShenQingZhiBoVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/26.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJShenQingZhiBoVC.h"

@interface SWTMJShenQingZhiBoVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;

@end

@implementation SWTMJShenQingZhiBoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请直播";
    self.dataArray = @[].mutableCopy;
    [self getData];
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchliveGet_live_cate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

- (IBAction)tap:(id)sender {
    
    NSMutableArray * arr = @[].mutableCopy;
    for (SWTModel * model  in self.dataArray) {
        [arr addObject:model.name];
    }
    
    zkPickView * pickV = [[zkPickView alloc] init];
    pickV.arrayType = titleArray;
    pickV.array = arr;
    pickV.selectLb.text = @"请选择直播类型,慎重选";
    [pickV show];
    pickV.delegate = self;
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merch_id"] = [zkSignleTool shareTool].selectShopID;
    dict[@"categoryid"] = self.dataArray[leftIndex].ID;
    [zkRequestTool networkingPOST:merchliveAdd_room_apply_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];

    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
