//
//  SWTLaoYouDianPuInfoOneTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouDianPuInfoOneTVC.h"
#import "SWTDianPuInfoView.h"
#import "SWTLaoYouDianPuInfoTwoTVC.h"
@interface SWTLaoYouDianPuInfoOneTVC ()
@property(nonatomic , strong)SWTDianPuInfoView *shopNameV,*shopDesV,*shopWinXinV,*shopPhoneV,*shopPicV;
@property(nonatomic , strong)UIView *shopHeadPicV;
@property(nonatomic , strong)UIButton *headPicBt;
@property(nonatomic , strong)UIButton *nextBt;
@property(nonatomic , strong)UIImageView *imgV;
@property(nonatomic , strong)UIView *headView;
@property(nonatomic,assign)BOOL isShopBackImg;

@end

@implementation SWTLaoYouDianPuInfoOneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺信息";
    self.tableView.backgroundColor = BackgroundColor;
    
    [self initSubV];
    
    
}


- (void)initSubV {
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor =[UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
    
    self.shopHeadPicV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    [self.headView addSubview:self.shopHeadPicV];
    
    UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(15, 30, 120, 20)];
    lb.text = @"店铺头像";
    lb.font = kFont(14);
    lb.textColor = CharacterColor50;
    [self.shopHeadPicV addSubview:lb];
    self.headPicBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70, 10, 60, 60)];
    [self.headPicBt setBackgroundImage:[UIImage imageNamed:@"dyx9"] forState:UIControlStateNormal];
//    self.headPicBt.backgroundColor =[UIColor redColor];
    
    
    [self.shopHeadPicV addSubview:self.headPicBt];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 79.5, ScreenW, 0.5)];
    backV.backgroundColor = lineBackColor;
    [self.shopHeadPicV addSubview:backV];
    
    CGFloat hh = 50;
    
    self.shopNameV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopHeadPicV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:15];
    self.shopNameV.leftLB.text = @"店铺名称";
    self.shopNameV.rightTF.placeholder = @"请填写店铺名称(15字以内)";
    [self.headView addSubview:self.shopNameV];
    
    self.shopDesV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopNameV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:40];
    self.shopDesV.leftLB.text = @"店铺介绍";
    self.shopDesV.rightTF.placeholder = @"请填写店铺介绍(40字以内)";
    [self.headView addSubview:self.shopDesV];
    
    self.shopWinXinV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopDesV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:40];
    self.shopWinXinV.leftLB.text = @"店铺微信号";
    self.shopWinXinV.rightTF.placeholder = @"请填写微信号";
    [self.headView addSubview:self.shopWinXinV];
    
    self.shopPhoneV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopWinXinV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:40];
    self.shopPhoneV.leftLB.text = @"联系手机号";
    self.shopPhoneV.rightTF.placeholder = @"请输入手机号";
    [self.headView addSubview:self.shopPhoneV];
    
    
    self.shopPicV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopPhoneV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:40];
    self.shopPicV.leftLB.text = @"店铺背景图";
    self.shopPicV.rightTF.placeholder = @"点击上传店铺背景图";
    self.shopPicV.lineV.hidden = YES;
    [self.headView addSubview:self.shopPicV];
    
    
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.shopPicV.frame), ScreenW - 20, 150)];
    self.imgV.backgroundColor = WhiteColor;
    self.imgV.layer.cornerRadius = 5;
    self.imgV.clipsToBounds = YES;
    [self.headView addSubview:self.imgV];
    
    
    
    
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.imgV.frame) + 40, ScreenW - 80, 40)];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 20;
    button.clipsToBounds = YES;
    [self.headView addSubview:button];
    
    @weakify(self);
    [[self.headPicBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.isShopBackImg = NO;
        [self addPict];
    }];
    
    [[self.shopPicV.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.isShopBackImg = YES;
        [self addPict];
    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        SWTLaoYouDianPuInfoTwoTVC * vc =[[SWTLaoYouDianPuInfoTwoTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    self.nextBt = button;
    
    self.headView.mj_h = CGRectGetMaxY(self.nextBt.frame) + 40;
    
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
            
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                if (self.isShopBackImg) {
                    self.imgV.image = image;
                }else {
                    [self.headPicBt setBackgroundImage:image forState:UIControlStateNormal];
                }
                
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
                    if (self.isShopBackImg) {
                        self.imgV.image = image;
                    }else {
                        [self.headPicBt setBackgroundImage:image forState:UIControlStateNormal];
                    }
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



@end
