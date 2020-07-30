//
//  SWTTuiHuoKuaiDiDanHaoVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuoKuaiDiDanHaoVC.h"

@interface SWTTuiHuoKuaiDiDanHaoVC ()<zkPickViewDelelgate>
@property (weak, nonatomic) IBOutlet UITextField *orderTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *desTF;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray;
@property(nonatomic , assign)NSInteger selectIndex;

@end

@implementation SWTTuiHuoKuaiDiDanHaoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"物流信息填写";
    self.dataArray = @[].mutableCopy;
    [self getData];
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchorderGet_express_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
      
       
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
      
        
    }];
}

- (IBAction)tijiaoAction:(UIButton *)sender {
    
    
    
    
    
}

- (IBAction)action:(id)sender {
    
    NSMutableArray * arr = @[].mutableCopy;
    for (SWTModel * model  in self.dataArray) {
        [arr addObject:model.name];
    }
     zkPickView * pickV = [[zkPickView alloc] init];
           pickV.arrayType = titleArray;
           pickV.array = arr;
           [pickV show];
           pickV.delegate = self;
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    self.selectIndex = leftIndex;
    self.nameTF.text = self.dataArray[leftIndex].name;
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
