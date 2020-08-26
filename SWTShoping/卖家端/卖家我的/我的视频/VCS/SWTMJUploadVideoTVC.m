//
//  SWTMJUploadVideoTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJUploadVideoTVC.h"
#import "SWTDianPuInfoView.h"
#import "SWTMJAddVideoTypeShowView.h"
@interface SWTMJUploadVideoTVC ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,AVAudioPlayerDelegate>
@property(nonatomic , strong)SWTDianPuInfoView *videoNameV,*videoChooseV,*videoDesV,*videoLableV,*videoTypeV,*videoGoodV;
@property(nonatomic , strong)UIView *shopHeadPicV;
@property(nonatomic , strong)UIView *headView;
@property(nonatomic , strong)UIButton *nextBt;
@property(nonatomic , strong)UIButton *headPicBt;
//@property(nonatomic , strong)UIView *lableChooseV;
//@property(nonatomic , strong)UIScrollView *scrollview;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArray,*goodListArr;
@property(nonatomic , strong)NSString *fenLeiName,*fenLieID,*goodId,*goodName;
@property(nonatomic , strong)NSString *videoStr,*headImgStr;
@property(nonatomic , strong)UIImage *image;
@end

@implementation SWTMJUploadVideoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"上传视频";
    
    self.tableView.backgroundColor = WhiteColor;
    [self initSubV];
    
    if (self.isEdit) {
        self.navigationItem.title = @"修改视频";
        UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        button.titleLabel.font = kFont(13);
        [button setTitle:@"删除" forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        @weakify(self);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            
            
            SWTMJUploadVideoTVC * vc =[[SWTMJUploadVideoTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        self.videoStr = self.dataModel.video;
        self.videoChooseV.rightTF.text = @"已有视频";
        self.headImgStr = self.dataModel.img;
        self.videoNameV.rightTF.text = self.dataModel.name;
        self.videoDesV.rightTF.text = self.dataModel.content;
        [self.headPicBt sd_setBackgroundImageWithURL:self.headImgStr.getPicURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        
    }
    
    
    
    self.dataArray = @[].mutableCopy;
    [self getData];
    self.goodListArr = @[].mutableCopy;
    [self getGoodListData];
}


//获取产品
- (void)getGoodListData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageindex"] = @(1);
    dict[@"pagesize"] = @(1000);
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchgoodsGet_goods_list_merch_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            self.goodListArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}


//获取去视屏分类
- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchvideoGet_video_cate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataArray = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
}

- (void)initSubV {
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor =[UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
    
    self.shopHeadPicV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    [self.headView addSubview:self.shopHeadPicV];
    
    UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 120, 20)];
    lb.text = @"预览图";
    lb.font = kFont(14);
    lb.textColor = CharacterColor50;
    [self.shopHeadPicV addSubview:lb];
    self.headPicBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70, 10, 60, 60)];
    [self.headPicBt setBackgroundImage:[UIImage imageNamed:@"dyx9"] forState:UIControlStateNormal];
    //    self.headPicBt.backgroundColor =[UIColor redColor];
    [self.headPicBt addTarget:self action:@selector(addPict) forControlEvents:UIControlEventTouchUpInside];
    
    [self.shopHeadPicV addSubview:self.headPicBt];
    
    //    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 79.5, ScreenW, 0.5)];
    //    backV.backgroundColor = lineBackColor;
    //    [self.shopHeadPicV addSubview:backV];
    
    CGFloat hh = 50;
    
    self.videoChooseV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopHeadPicV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:40];
    self.videoChooseV.leftLB.text = @"上传视频";
    self.videoChooseV.rightTF.placeholder = @"点击选择";
    self.videoChooseV.rightBt.tag = 101;
    [self.videoChooseV.rightBt  addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.videoChooseV];
    
    
    
    self.videoNameV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoChooseV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:15];
    self.videoNameV.leftLB.text = @"视频名称";
    self.videoNameV.rightTF.placeholder = @"请填写视频名称";
    self.videoNameV.rightTF.textAlignment = NSTextAlignmentRight;
    [self.headView addSubview:self.videoNameV];
    
    self.videoDesV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoNameV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:40];
    self.videoDesV.leftLB.text = @"视频介绍";
    self.videoDesV.rightTF.placeholder = @"请填写视频介绍";
    self.videoDesV.rightTF.textAlignment = NSTextAlignmentRight;
    [self.headView addSubview:self.videoDesV];
    
    //    self.videoLableV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoDesV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:40];
    //    self.videoLableV.leftLB.text = @"视频标签";
    //    self.videoLableV.rightTF.placeholder = @"请填写";
    //    self.videoLableV.lineV.hidden = YES;
    //    [self.headView addSubview:self.videoLableV];
    
    //    self.lableChooseV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoLableV.frame), ScreenW, 40)];
    //    [self.headView addSubview:self.lableChooseV];
    //    UILabel * ccLB = [[UILabel alloc] init];
    //    ccLB =[[UILabel alloc] init];
    //    ccLB.font = kFont(14);
    //    ccLB.textColor = CharacterColor50;
    //    ccLB.text = @"可选标签";
    //    [self.lableChooseV addSubview:ccLB];
    //
    //
    //    [ccLB mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self.lableChooseV).offset(10);
    //        make.centerY.equalTo(self.lableChooseV);
    //    }];
    //
    //    UIView * backVTwo =[[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenW, 0.5)];
    //    backVTwo.backgroundColor = lineBackColor;
    //    [self.lableChooseV addSubview:backVTwo];
    //
    //    self.scrollview = [[UIScrollView alloc] init];
    //    [self.lableChooseV addSubview:self.scrollview];
    //    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(ccLB.mas_right).offset(10);
    //        make.right.equalTo(self.lableChooseV).offset(-5);
    //        make.top.equalTo(self.lableChooseV).offset(0.5);
    //        make.height.equalTo(@29);
    //    }];
    //
    
    self.videoTypeV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoDesV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:40];
    self.videoTypeV.leftLB.text = @"视频分类";
    self.videoTypeV.rightTF.placeholder = @"点击选择";
    self.videoTypeV.rightBt.tag = 102;
    [self.videoTypeV.rightBt  addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.videoTypeV];
    
    
    
    
    self.videoGoodV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoTypeV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:40];
    self.videoGoodV.leftLB.text = @"关联商品";
    self.videoGoodV.rightTF.placeholder = @"点击选择";
    self.videoGoodV.lineV.hidden = YES;
    self.videoGoodV.rightBt.tag = 103;
    [self.videoGoodV.rightBt  addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.videoGoodV];
    
    //
    //    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.videoGoodV.frame), ScreenW - 20, 150)];
    //    self.imgV.backgroundColor = WhiteColor;
    //    self.imgV.layer.cornerRadius = 5;
    //    self.imgV.clipsToBounds = YES;
    //    [self.headView addSubview:self.imgV];
    
    
    
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.videoGoodV.frame) + 40, ScreenW - 80, 40)];
    [button setTitle:@"确认提交" forState:UIControlStateNormal];
    if (self.isEdit) {
        [button setTitle:@"确认修改" forState:UIControlStateNormal];
    }
    button.titleLabel.font = kFont(14);
    [button setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 20;
    button.clipsToBounds = YES;
    [self.headView addSubview:button];
    
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self panDuan];
    }];
    
    
    self.nextBt = button;
    
    self.headView.mj_h = CGRectGetMaxY(self.nextBt.frame) + 40;
    
}
//判断字段
- (void)panDuan {
    if (self.headImgStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择视频预览图"];
        return;
    }
    if (self.videoStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择视频"];
        return;
    }
    if (self.videoNameV.rightTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入视频名字"];
        return;
    }
    if (self.videoDesV.rightTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入视频描述"];
        return;
    }
    if (self.fenLieID.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择视频分类"];
        return;
    }
    if (self.goodId.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择添加关联商品"];
        return;
    }
    
    [self tiJiaoAction];
    
}
//添加
- (void)tiJiaoAction {
    [SVProgressHUD show];
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    NSString * url = merchvideoAdd_video_SWT;
    if (self.isEdit) {
        url = merchvideoUpd_video_SWT;
        dict[@"id"] = self.dataModel.ID;
    }
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    dict[@"img"] = self.headImgStr;
    dict[@"video"] = self.videoStr;
    dict[@"name"] = self.videoNameV.rightTF.text;
    dict[@"content"] = self.videoDesV.rightTF.text;
    dict[@"good_id"] = self.goodId;
    dict[@"category"] = self.fenLieID;
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (self.isEdit) {
                [SVProgressHUD showSuccessWithStatus:@"视频修改成功"];
                self.dataModel.img = self.headImgStr;
                self.dataModel.video = self.videoStr;
                self.dataModel.name = self.videoNameV.rightTF.text;
                self.dataModel.content = self.videoDesV.rightTF.text;
                if (self.sendVideoBlock != nil) {
                    self.sendVideoBlock(self.dataModel);
                }
            }else {
                [SVProgressHUD showSuccessWithStatus:@"添加视频成功"];
                [LTSCEventBus sendEvent:@"addvideo" data:nil];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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

- (void)viewClick:(UIButton *)button {
    if (button.tag == 101) {
        //选择视频
        [self showAlertV];
        
        
    }else if (button.tag == 102) {
        //视频分类
        
        SWTMJAddVideoTypeShowView * showV  =[[SWTMJAddVideoTypeShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        showV.dataArray = self.dataArray;
        showV.type = 0;
        showV.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [showV.delegateSignal subscribeNext:^(NSNumber * x) {
            @strongify(self);
            
            self.fenLieID = self.dataArray[x.intValue].ID;
            self.fenLeiName = self.dataArray[x.intValue].name;
            self.videoTypeV.rightTF.text = self.fenLeiName;
            [showV dismiss];
            
        }];
        [showV show];
        
    }else if (button.tag == 103) {
        //关联商品
        SWTMJAddVideoTypeShowView * showV  =[[SWTMJAddVideoTypeShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        showV.dataArray = self.goodListArr;
        showV.type = 1;
        @weakify(self);
        showV.delegateSignal = [[RACSubject alloc] init];
        [showV.delegateSignal subscribeNext:^(NSString * x) {
            @strongify(self);
            
            for (SWTModel * model  in self.goodListArr) {
                if ([model.ID isEqualToString:x]) {
                    self.goodId = x;
                    self.goodName = model.title;
                    self.videoGoodV.rightTF.text = model.title;
                    [showV dismiss];
                    return;
                }
            }
        }];
        [showV show];
    }
    
    
}
- (void)showAlertV {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"相机录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            
            [self captureVideoButtonClick];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"相册视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
            [self choosePicOrVideo];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action4];
    [ac addAction:action5];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}



//相册选视频
- (void)choosePicOrVideo {
    
    if ([self isCanUsePicture]) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAXFLOAT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        
        imagePickerVc.allowTakeVideo = YES;
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = NO;
        imagePickerVc.allowTakePicture = NO;
        
        
        imagePickerVc.showSelectBtn = NO;
        imagePickerVc.allowCrop = YES;
        imagePickerVc.needCircleCrop = NO;
        imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
        imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
        imagePickerVc.circleCropRadius = ScreenW/2;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)captureVideoButtonClick{
    [PublicFuntionTool showCameraVideoWithViewController:self];
    Weak(weakSelf);
    [PublicFuntionTool shareTool].videoBlock = ^(NSData *data) {
        [weakSelf updateImgsToQiNiuYunWithImageArr:nil andData:data withType:2];
    };
    
}



#pragma mark ------ 如下是图片和视频的处理上传过程 ------
//视频选择结束
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
    [SVProgressHUD show];
    
    [PublicFuntionTool getImageFromPHAsset:asset Complete:^(NSData * _Nonnull data, NSString * _Nonnull str) {
        [self updateImgsToQiNiuYunWithImageArr:nil andData:data withType:2];
    }];
}

- (void)updateImgsToQiNiuYunWithImageArr:(NSArray *)imageArr andData:(NSData *)data withType:(NSInteger)type{
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    [SVProgressHUD show];
    dict[@"type"] = @"video";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:nil imgName:nil fileData:data andFileName:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"视频上传服务器成功"];
            self.videoStr =  [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            self.videoChooseV.rightTF.text = @"已上传";
        }else {
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
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
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"head";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:@[self.image] name:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            
            self.headImgStr = responseObject[@"data"];
            [self.headPicBt setBackgroundImage:self.image forState:UIControlStateNormal];
            [SVProgressHUD dismiss];
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

@end
