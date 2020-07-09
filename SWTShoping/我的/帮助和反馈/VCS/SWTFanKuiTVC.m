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
@end

@implementation SWTFanKuiTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picArr = @[].mutableCopy;
    self.navigationItem.title = @"反馈";
    
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
        make.height.equalTo(@160);
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

    NSArray * arr = @[@"阿共建全偶偶",@"我佛教群殴王嘉尔",@"且闻鸡起舞i"];
    for (int i  = 0 ; i < arr.count; i++) {
        SWTFanKuiSelectView * sview  =[[SWTFanKuiSelectView alloc] init];
        sview.tag = 100+i;
        [self.whiteViewOne addSubview:sview];
        sview.titleLB.text = arr[i];
        [sview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lb.mas_bottom).offset(5+i*40);
            make.height.equalTo(@40);
            make.left.equalTo(self.whiteViewOne).offset(5);
            make.right.equalTo(self.whiteViewOne).offset(-5);
          
        }];
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
    @weakify(self);
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


    UIButton * button  =[[UIButton alloc] init];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];

    [button setBackgroundImage:[UIImage imageNamed:@"feedback_addpic"] forState:UIControlStateNormal];
    [self.whiteThreeNeiV addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.whiteThreeNeiV);
        make.width.equalTo(@((ScreenW - 30 - 30)/4));
    }];

    
}



- (void)clickAction:(UIButton *)button {
    
    [self addPict];
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
         
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.picArr addObject:image];

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
    
    
}

@end
