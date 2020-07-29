//
//  SWTSendMinePingLunTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTSendMinePingLunTVC.h"
#import "SWTPingJiaHeadV.h"
@interface SWTSendMinePingLunTVC ()
@property(nonatomic , strong)SWTPingJiaHeadV *headV;
@property(nonatomic , strong)NSMutableArray<UIImage *> *picArr;
@property(nonatomic , strong)NSMutableArray *picStrArr;
@end

@implementation SWTSendMinePingLunTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picArr = @[].mutableCopy;
    self.navigationItem.title = @"发表评价";
    self.headV  =[[SWTPingJiaHeadV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.tableView.tableHeaderView = self.headV;
    self.headV.picArr = self.picArr;
    self.headV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [self.headV.delegateSignal subscribeNext:^(NSString * x) {
        @strongify(self);
        if ([x isEqualToString:@"123"]) {
            //添加图片
            [self addPict];
        }else {
            //删除图片
            [self.picArr removeObjectAtIndex:x.intValue];
        }
        
        
    }];
    self.headV.model = self.model;
    
    
    UIButton  * button  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fabuAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    

    self.picStrArr = @[].mutableCopy;
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
         
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                [self.picArr addObject:image];
                self.headV.picArr = self.picArr;

            }];
       
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            [self showMXPickerWithMaximumPhotosAllow:4-self.picArr.count completion:^(NSArray *assets) {
                
                for (ALAsset *asset in assets) {
                    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
                    CGImageRef imgRef = [assetRep fullResolutionImage];
                    UIImage *image = [[UIImage alloc] initWithCGImage:imgRef
                                                                scale:assetRep.scale
                                                          orientation:(UIImageOrientation)assetRep.orientation];
                    
                    if (!image) {
                        image = [[UIImage alloc] initWithCGImage:[[asset defaultRepresentation] fullScreenImage]
                                                           scale:assetRep.scale
                                                     orientation:(UIImageOrientation)assetRep.orientation];
                        
                    }
                    if (!image) {
                        CGImageRef thum = [asset aspectRatioThumbnail];
                        image = [UIImage imageWithCGImage:thum];
                    }
                    [self.picArr addObject:image];
                   
                    self.headV.picArr = self.picArr;
                }
                
              
                
                
            }];
           
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
   
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}



- (void)fabuAction {
    
    
    if (self.headV.textV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入描述"];
        return;
    }
       
    
    if (self.picArr.count > 0) {
        [self updateImage];
    }else {
        [self pingJiaAction];
    }
    
    
    
}

- (void)updateImage {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"comment";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfiles_SWT images:self.picArr name:@"files" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            self.picStrArr = responseObject[@"data"];
            [self pingJiaAction];
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


//发不评价
- (void)pingJiaAction {
    
    
   
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"comment"] = self.headV.textV.text;
    dict[@"id"] = self.model.ID;
    dict[@"imgurl"] = [self.picStrArr componentsJoinedByString:@","];
    dict[@"score"] = @(self.headV.xingView1.score+1);
    [zkRequestTool networkingPOST:orderComment_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
      
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"评价成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
    
    
}

@end
