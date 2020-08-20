//
//  SWTLaoYouDianPuInfoTwoTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouDianPuInfoTwoTVC.h"
#import "SWTDianPuInfoView.h"
#import "SWTDianPuInfoTwoView.h"
@interface SWTLaoYouDianPuInfoTwoTVC ()<zkPickViewDelelgate>
@property(nonatomic , strong)SWTDianPuInfoView *shopTyepV,*shopOwnerV,*shopLeiV,*shopNameV,*shopNumberV;
@property(nonatomic , strong)UIView *headView;
@property(nonatomic , strong)UIButton *nextBt;
@property(nonatomic , strong)SWTDianPuInfoTwoView *zhengV,*fanV,*shouChiV;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArrayOne,*dataArrayTwo,*dataArrayThree;
@property(nonatomic , assign)NSInteger selectIndex , imgSelect;
@property(nonatomic , strong)NSString *str1,*str2,*str3;
@property(nonatomic , strong)NSString *imgStr1,*imgStr2,*imgStr3;
@property(nonatomic , strong)UIImage *image;


@end

@implementation SWTLaoYouDianPuInfoTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺认证";
    [self initSubV];
    self.dataArrayOne = @[].mutableCopy;
    self.dataArrayTwo = @[].mutableCopy;
    self.dataArrayThree = @[].mutableCopy;
    [self getData];
    [self getDataTwo];
    [self getDataThree];
}

//主题
- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchBusinessentity_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            self.dataArrayOne = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}
//分类
- (void)getDataTwo {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchCategory_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
            self.dataArrayTwo = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

//类目
- (void)getDataThree {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchSellcate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArrayThree = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)initSubV {
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 20)];
    self.tableView.tableHeaderView = self.headView;
    CGFloat hh = 50;
    self.shopTyepV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
       self.shopTyepV.leftLB.text = @"店铺类型";
       self.shopTyepV.rightTF.placeholder = @"请选择";
       [self.headView addSubview:self.shopTyepV];
    self.shopTyepV.rightBt.tag = 100;
    [self.shopTyepV.rightBt  addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.shopOwnerV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopTyepV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
    self.shopOwnerV.leftLB.text = @"经营主体";
    self.shopOwnerV.rightTF.placeholder = @"请选择";
    [self.headView addSubview:self.shopOwnerV];
    self.shopOwnerV.rightBt.tag = 101;
       [self.shopOwnerV.rightBt  addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shopLeiV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopOwnerV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
    self.shopLeiV.leftLB.text = @"主营类目";
    self.shopLeiV.rightTF.placeholder = @"请选择";
    [self.headView addSubview:self.shopLeiV];
    self.shopLeiV.rightBt.tag = 102;
    [self.shopLeiV.rightBt  addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shopNameV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopLeiV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
    self.shopNameV.leftLB.text = @"真实姓名";
    self.shopNameV.rightTF.placeholder = @"请填写";
    [self.headView addSubview:self.shopNameV];
    self.shopNameV.rightBt.hidden = YES;
    self.shopNameV.rightTF.userInteractionEnabled = YES;
    
    
    
    self.shopNumberV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopNameV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:200];
    self.shopNumberV.leftLB.text = @"身份证号";
    self.shopNumberV.rightTF.placeholder = @"请填写";
    [self.headView addSubview:self.shopNumberV];
    self.shopNumberV.rightBt.hidden = YES;
    self.shopNumberV.rightTF.userInteractionEnabled = YES;
    

    
    
  
    
    UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.shopNumberV.frame) + 10, ScreenW - 20, 20)];
    lb.textColor = CharacterColor102;
    lb.font = kFont(14);
    lb.text = @"认证信息";
    [self.headView addSubview:lb];
    
    self.zhengV = [[SWTDianPuInfoTwoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lb.frame) + 10, ScreenW - 20, 50 + 100)];
    self.zhengV.titleLB.text = @"请上传省份证人像面";
    [self.headView addSubview:self.zhengV];
    self.zhengV.rigthImgV.image = [UIImage imageNamed:@"dyx11"];
    self.zhengV.leftBt.tag = 0;
    [self.zhengV.leftBt addTarget:self action:@selector(chooseImageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.fanV = [[SWTDianPuInfoTwoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.zhengV.frame), ScreenW - 20, CGRectGetHeight(self.zhengV.frame))];
    self.fanV.titleLB.text = @"请上传省份证国徽面";
    self.fanV.rigthImgV.image = [UIImage imageNamed:@"dyx12"];
    [self.headView addSubview:self.fanV];
    self.fanV.leftBt.tag = 1;
    [self.fanV.leftBt addTarget:self action:@selector(chooseImageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.shouChiV = [[SWTDianPuInfoTwoView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.fanV.frame), ScreenW - 20, CGRectGetHeight(self.zhengV.frame))];
    self.shouChiV.rigthImgV.image = [UIImage imageNamed:@"dyx13"];
    self.shouChiV.titleLB.text = @"请上传手持身份照";
    [self.headView addSubview:self.shouChiV];
    self.shouChiV.leftBt.tag = 2;
       [self.shouChiV.leftBt addTarget:self action:@selector(chooseImageAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.shouChiV.frame) + 40, ScreenW - 80, 40)];
      [button setTitle:@"下一步" forState:UIControlStateNormal];
      button.titleLabel.font = kFont(14);
      [button setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
      button.layer.cornerRadius = 20;
      button.clipsToBounds = YES;
      [self.headView addSubview:button];
      
      @weakify(self);
      [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
          @strongify(self);
          
          
          
          [self renZhengAction];
          
          
      }];
    self.nextBt = button;
    
    self.headView.mj_h = CGRectGetMaxY(self.nextBt.frame) + 40;
}

- (void)renZhengAction {
    if (self.str1.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择店铺类型"];
        return;
    }
    if (self.str2.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择经营主体"];
        return;
    }
    if (self.str3.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择主营类目"];
        return;
    }
    if (self.shopNameV.rightTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        return;
    }
    if (self.shopNumberV.rightTF.text == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        return;
    }
    if (self.imgStr1.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"选择身份证正面照片"];
        return;
    }
    if (self.imgStr2.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"选择身份证反面照片"];
        return;
    }
    if (self.imgStr3.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"选择手持身份证照片"];
        return;
    }
    
    [self TwoSetpAction];
    
}


- (void)TwoSetpAction {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.firstID;
    dict[@"categoryid"] = self.str1;
    dict[@"businessid"] = self.str2;
    dict[@"sellid"] = self.str3;
    dict[@"realname"] = self.shopNameV.rightTF.text;
    dict[@"idcard"] = self.shopNumberV.rightTF.text;
    dict[@"idcard_front"] = self.imgStr1;
    dict[@"idcard_back"] = self.imgStr2;
    dict[@"idcard_hold"] = self.imgStr3;
    [zkRequestTool networkingPOST:registerStep2_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"申请店铺成功,等待审核"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}

- (void)chooseAction:(UIButton *)button {
    if (button.tag == 100) {
        
        if (self.dataArrayTwo.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"数据请求中,请稍后再试"];
            [self getData];
            return;
        }
        self.selectIndex = 0;
        NSMutableArray * arr = @[].mutableCopy;
        for (SWTModel * model in self.dataArrayTwo) {
            [arr addObject:model.name];
        }
        zkPickView * pickV = [[zkPickView alloc] init];
        pickV.arrayType = titleArray;
        pickV.array = arr;
        [pickV show];
        pickV.delegate = self;
        
    }else if(button.tag == 101) {
        
        
        if (self.dataArrayOne.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"数据请求中,请稍后再试"];
            [self getData];
            return;
        }
        self.selectIndex = 1;
        NSMutableArray * arr = @[].mutableCopy;
        for (SWTModel * model in self.dataArrayOne) {
            [arr addObject:model.name];
        }
        zkPickView * pickV = [[zkPickView alloc] init];
        pickV.arrayType = titleArray;
        pickV.array = arr;
        [pickV show];
        pickV.delegate = self;
        
    }else {
       if (self.dataArrayThree.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"数据请求中,请稍后再试"];
            [self getData];
            return;
        }
        self.selectIndex = 2;
        NSMutableArray * arr = @[].mutableCopy;
        for (SWTModel * model in self.dataArrayThree) {
            [arr addObject:model.name];
        }
        zkPickView * pickV = [[zkPickView alloc] init];
        pickV.arrayType = titleArray;
        pickV.array = arr;
        [pickV show];
        pickV.delegate = self;
    }
    
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    if (self.selectIndex == 0) {
        self.str1 = self.dataArrayTwo[leftIndex].ID;
        self.shopTyepV.rightTF.text = self.dataArrayTwo[leftIndex].name;
    }else if (self.selectIndex == 1) {
        self.str2 = self.dataArrayOne[leftIndex].ID;
        self.shopOwnerV.rightTF.text = self.dataArrayOne[leftIndex].name;
    }else if (self.selectIndex == 2) {
        self.str3 = self.dataArrayThree[leftIndex].ID;
        self.shopLeiV.rightTF.text = self.dataArrayThree[leftIndex].name;
    }
    
    
}

- (void)chooseImageAction:(UIButton *)button {
    
    self.imgSelect = button.tag;
    [self addPict];
    
    
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
    self.shouChiV.userInteractionEnabled = self.zhengV.userInteractionEnabled = self.fanV.userInteractionEnabled = NO;
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"idcard";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:@[self.image] name:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        self.shouChiV.userInteractionEnabled = self.zhengV.userInteractionEnabled = self.fanV.userInteractionEnabled = YES;
        if ([responseObject[@"code"] intValue] == 200) {
            if (self.imgSelect == 0) {
                self.imgStr1 = responseObject[@"data"];
                [self.zhengV.leftBt sd_setBackgroundImageWithURL:[self.imgStr1 getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            }else if (self.imgSelect == 1){
                self.imgStr2 = responseObject[@"data"];
                [self.fanV.leftBt sd_setBackgroundImageWithURL:[self.imgStr2 getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            }else if (self.imgSelect == 2) {
                self.imgStr3 = responseObject[@"data"];
                [self.shouChiV.leftBt sd_setBackgroundImageWithURL:[self.imgStr3 getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            }
//            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.shouChiV.userInteractionEnabled = self.zhengV.userInteractionEnabled = self.fanV.userInteractionEnabled = YES;
    }];
    
    
}

@end
