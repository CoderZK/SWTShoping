//
//  SWTFanKuiTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/8.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTFanKuiTVC.h"
#import "SWTFanKuiSelectView.h"
@interface SWTFanKuiTVC ()
@property(nonatomic , strong)UIView *whiteViewOne,*whiteViewTwo,*whiteViewThree;
@property(nonatomic , strong)UIButton *tijiaoBt;
@property(nonatomic , strong)UIView *whiteThreeNeiV;
@property(nonatomic , strong)UILabel *numberLB;
@property(nonatomic , strong)UILabel *numberTwoLB;
@property(nonatomic , strong)IQTextView *TV;;
@property(nonatomic , strong)UIView *headV;
@property(nonatomic , strong)NSMutableArray *picArr;
@property(nonatomic , strong)NSArray *picStrArr;
@property(nonatomic , assign)NSInteger  selectIndex;
@end

@implementation SWTFanKuiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picArr = @[].mutableCopy;
    self.navigationItem.title = @"反馈";
    self.view.backgroundColor = BackgroundColor;
    
    UIButton * footBt  = [[UIButton alloc] init];
    [self.view addSubview:footBt];
    footBt.titleLabel.font = kFont(14);
    [footBt setTitle:@"提姣" forState:UIControlStateNormal];
    [footBt setBackgroundImage:[UIImage imageNamed:@"rbg"] forState:UIControlStateNormal];
    footBt.layer.cornerRadius = 20;
    footBt.clipsToBounds = YES;
    [footBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        if (sstatusHeight > 20) {
            make.bottom.equalTo(self.view).offset(-34);
        }else {
            make.bottom.equalTo(self.view);
        }
        
    }];
    @weakify(self);
    [[footBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        [self tijiaoAction];
        
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(footBt.mas_top);
    }];
    
    
    self.headV.backgroundColor = BackgroundColor;
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.tableView.tableHeaderView = self.headV;
    
    self.whiteViewOne = [[UIView alloc] init];
    self.whiteViewOne.backgroundColor = WhiteColor;
    self.whiteViewOne.layer.cornerRadius = 5;
    self.whiteViewOne.clipsToBounds = YES;
    [self.headV addSubview:self.whiteViewOne];
    
    [self.whiteViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.headV).offset(10);
        make.right.equalTo(self.headV).offset(-10);
        make.height.equalTo(@200);
    }];
    
    UILabel * lb = [[UILabel alloc] init];
    lb.text = @"反馈类型 (单选)";
    lb.font = kFont(14);
    [self.whiteViewOne addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteViewOne).offset(5);
        make.left.equalTo(self.whiteViewOne).offset(15);
        make.height.equalTo(@20);
    }];

    NSArray * arr = @[@"性能体验 卡顿, 闪退, 白屏",@"功能异常 功能无法使用等问题",@"产品建议",@"其他问题"];
    for (int i  = 0 ; i < arr.count; i++) {
        SWTFanKuiSelectView * sview  =[[SWTFanKuiSelectView alloc] init];
        sview.leftImgV.image = [UIImage imageNamed:@"goun"];
        sview.tag = 100+i;
        [self.whiteViewOne addSubview:sview];
        sview.titleLB.text = arr[i];
        [sview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lb.mas_bottom).offset(5+i*40);
            make.height.equalTo(@40);
            make.left.equalTo(self.whiteViewOne).offset(5);
            make.right.equalTo(self.whiteViewOne).offset(-5);
          
        }];
        
        [sview.button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }



    self.whiteViewTwo = [[UIView alloc] init];
    self.whiteViewTwo.backgroundColor = WhiteColor;
    self.whiteViewTwo.layer.cornerRadius = 5;
    self.whiteViewTwo.clipsToBounds = YES;
    [self.headV addSubview:self.whiteViewTwo];
    [self.whiteViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headV).offset(10);
        make.right.equalTo(self.headV).offset(-10);
        make.top.equalTo(self.whiteViewOne.mas_bottom).offset(10);
        make.height.equalTo(@200);

    }];

    UILabel * lb2 = [[UILabel alloc] init];
    lb2.text = @"问题和建议";
    lb2.font = kFont(14);
    [self.whiteViewTwo addSubview:lb2];
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteViewTwo).offset(5);
        make.left.equalTo(self.whiteViewTwo).offset(15);
        make.height.equalTo(@20);
    }];

    UIView * gbackV = [[UIView alloc] init];
    gbackV.layer.cornerRadius = 3;
    gbackV.clipsToBounds = YES;
    gbackV.backgroundColor = RGB(250, 250, 250);
    [self.whiteViewTwo addSubview:gbackV];
    [gbackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteViewTwo).offset(10);
        make.right.equalTo(self.whiteViewTwo).offset(-10);
        make.top.equalTo(lb2.mas_bottom).offset(5);
        make.bottom.equalTo(self.whiteViewTwo).offset(-10);
    }];

    self.TV = [[IQTextView alloc] init];
    self.TV.placeholder = @"填写问题描述";
    self.TV.backgroundColor = [UIColor clearColor];
    self.TV.font = kFont(14);
    [[[self.TV rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
       
        return YES;
    }] subscribeNext:^(NSString * x) {
        @strongify(self);
        if (x.length <= 200) {
            self.numberLB.text =  [NSString stringWithFormat:@"%lu/200",(unsigned long)x.length];
        }else {
            self.numberLB.text = @"200/200";
            self.TV.text = [x substringToIndex:200];
        }
       
    }];

    [gbackV addSubview:self.TV];
    [self.TV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(gbackV);
        make.bottom.equalTo(gbackV).offset(-20);
    }];



    self.numberLB  = [[UILabel alloc] init];
    self.numberLB.font = kFont(12);
    self.numberLB.text = @"0/200";
    [gbackV addSubview:self.numberLB];
    [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(gbackV);
        make.right.equalTo(gbackV).offset(-5);
        make.height.equalTo(@20);
    }];


    self.whiteViewThree = [[UIView alloc] init];
    self.whiteViewThree.backgroundColor = WhiteColor;
    self.whiteViewThree.layer.cornerRadius = 5;
    self.whiteViewThree.clipsToBounds = YES;
    [self.headV addSubview:self.whiteViewThree];
    CGFloat hh = 30 + (ScreenW - 30 - 30)/4 + 30;
    [self.whiteViewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headV).offset(10);
        make.right.equalTo(self.headV).offset(-10);
        make.top.equalTo(self.whiteViewTwo.mas_bottom).offset(10);
        make.height.equalTo(@(hh + 20));
        make.bottom.equalTo(self.headV).offset(-15);
    }];

    UILabel * lb3 = [[UILabel alloc] init];
    lb3.text = @"添加图片 (问题图片)";
    lb3.font = kFont(14);
    [self.whiteViewThree addSubview:lb3];
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteViewThree).offset(5);
        make.left.equalTo(self.whiteViewThree).offset(15);
        make.height.equalTo(@20);
    }];

    self.whiteThreeNeiV =[[UIView alloc] init];
    self.whiteThreeNeiV.backgroundColor = WhiteColor;
    [self.whiteViewThree addSubview:self.whiteThreeNeiV];
    [self.whiteThreeNeiV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteViewThree).offset(5);
        make.right.equalTo(self.whiteViewThree).offset(-5);
        make.top.equalTo(lb3.mas_bottom).offset(5);
        make.bottom.equalTo(self.whiteViewThree).offset(-20);
    }];


    self.numberTwoLB  = [[UILabel alloc] init];
    self.numberTwoLB.font = kFont(12);
    [self.whiteViewThree addSubview:self.numberTwoLB];
    self.numberTwoLB.text = @"1/4";
       [self.numberTwoLB mas_makeConstraints:^(MASConstraintMaker *make) {
           make.bottom.equalTo(self.whiteViewThree).offset(-10);
           make.right.equalTo(self.whiteViewThree).offset(-15);
           make.height.equalTo(@20);
       }];

    
    [self setPics];

    
}

- (void)clickAction:(UIButton *)button {
    
    SWTFanKuiSelectView * vv  = (SWTFanKuiSelectView *)button.superview;
    
    for (int i = 0; i < 4 ;i++) {
        
        
        SWTFanKuiSelectView * vvN = [self.whiteViewOne viewWithTag:100+i];

            if (vv.tag == vvN.tag) {
                vvN.leftImgV.image = [UIImage imageNamed:@"gou"];
                self.selectIndex = i+1;
            }else {
                vvN.leftImgV.image = [UIImage imageNamed:@"goun"];
            }

        
        
    }
    
    
    
}

- (void)tijiaoAction {
    if (self.selectIndex <1 ) {
        [SVProgressHUD showErrorWithStatus:@"选择反馈类型"];
        return;
    }
    if (self.TV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入问题和建议"];
        return;
    }
    if (self.picArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择照片"];
        return;
    }

    [self updateImage];
    
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
         
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.picArr addObject:image];
                 self.numberTwoLB.text =  [NSString stringWithFormat:@"%ld/4",self.picArr.count];
                [self setPics];

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
                    self.numberTwoLB.text =  [NSString stringWithFormat:@"%ld/4",self.picArr.count];
                     [self setPics];
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


- (void)setPics {
    
    [self.whiteThreeNeiV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger allNu = self.picArr.count < 4 ? self.picArr.count + 1:4;
    
    CGFloat space = 10;
    CGFloat leftM = 5;
    CGFloat ww = (ScreenW - 30 - 30)/4;
    for (int i = 0 ; i< allNu; i++) {
        
        
        
        
        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake(leftM + (space+ ww) * i, 0, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;
        anNiuBt.backgroundColor = RGB(250, 250, 250);
    
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteThreeNeiV addSubview:anNiuBt];
        
        UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake(ww - 25 , 0, 25, 25)];
        
        deleteBt.tag = 200+i;
        [deleteBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];

        if (i<self.picArr.count) {
            [anNiuBt setBackgroundImage:self.picArr[i] forState:UIControlStateNormal];
                   
            [deleteBt setImage:[UIImage imageNamed:@"48"] forState:UIControlStateNormal];
            [anNiuBt addSubview:deleteBt];
        }else {
            [anNiuBt setBackgroundImage:[UIImage imageNamed:@"feedback_addpic"] forState:UIControlStateNormal];
                   
           
        }
       
        
        
    }
    
}

- (void)hitAction:(UIButton *)anNiuBt {
    
    if (anNiuBt.tag >=200) {
        //删除
        [self.picArr removeObjectAtIndex:anNiuBt.tag - 200];
        [self setPics];
    }else {
        if (anNiuBt.tag - 100  == self.picArr.count) {
            //添加图片
            [self addPict];
            
        }
    }
}


- (void)updateImage {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"comment";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfiles_SWT images:self.picArr name:@"files" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            self.picStrArr = responseObject[@"data"];
            [self tijiaoTwoAction];
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)tijiaoTwoAction {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"content"] = self.TV.text;
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"imgs"] = [self.picStrArr componentsJoinedByString:@","];
    dict[@"state"] = @"0";
    dict[@"type"] = @(self.selectIndex);
    [zkRequestTool networkingPOST:helpCommit_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

       
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"反馈成功!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
     
        
    }];

    
    
}

@end
