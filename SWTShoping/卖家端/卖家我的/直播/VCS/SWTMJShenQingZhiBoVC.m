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
@property(nonatomic , strong)NSString *zhiBoName,*zhiBoLogo;
@property(nonatomic , strong)UIImage *image;
@property(nonatomic , assign)NSInteger  selectIndex;
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
    pickV.selectLb.text = @"请选择直播类型,慎重选择";
    [pickV show];
    pickV.delegate = self;
    
}
- (IBAction)kaiTongAction:(id)sender {
    if (self.zhiBoLogo.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择直播背景图"];
        return;
    }
    if (self.selectIndex == -1) {
        [SVProgressHUD showErrorWithStatus:@"请选择直播类型"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"merch_id"] = [zkSignleTool shareTool].selectShopID;
    dict[@"categoryid"] = self.dataArray[self.selectIndex].ID;
    dict[@"name"] = self.zhiBoName;
    dict[@"img"] = self.zhiBoLogo;
    [zkRequestTool networkingPOST:merchliveAdd_room_apply_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    
    
    self.selectIndex = leftIndex;
    self.titleLB.text = self.dataArray[leftIndex].name;
    
    [self showTianXiezhiBoName];
    
    
    
    
}

- (void)showTianXiezhiBoName {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入直播名字" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField*userNameTF = alertController.textFields.firstObject;
        if (userNameTF.text.length == 0) {
            return ;
            
        }
        self.zhiBoName = userNameTF.text;
        [SVProgressHUD showSuccessWithStatus:@"请选择直播背景图"];
        [self addPict];
        
        
    }]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
        
        textField.placeholder=@"请输入直播名字";
        
        
        
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
            
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                self.image = image;
                [self updateImage];
                
            }];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            [self showMXPickerWithMaximumPhotosAllow:1 completion:^(NSArray *assets) {
                
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
                    
                    self.image = image;
                    [self updateImage];
                    
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

- (void)updateImage {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"head";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:@[self.image] name:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"图片上传成功"];
            self.zhiBoLogo = responseObject[@"data"];
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)zhiBoshengqing {
    
}

@end
