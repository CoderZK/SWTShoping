//
//  MJHeMaiDetailTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiDetailTVC.h"
#import "MJHeadView.h"
#import "MJHeMaiOrderCell.h"
#import "MJHeMaiQianHaoCell.h"
#import "MJHeMaiPicCell.h"
@interface MJHeMaiDetailTVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MJHeadView *headV;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *picArr;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)UIImage *image;
@end

@implementation MJHeMaiDetailTVC

- (void)viewDidLoad {
    self.navigationItem.title = @"合买详情";
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.headV = [[MJHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    self.tableView.tableHeaderView = self.headV;
    [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiOrderCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MJHeMaiQianHaoCell" bundle:nil] forCellReuseIdentifier:@"MJHeMaiQianHaoCell"];
    [self.tableView registerClass:[MJHeMaiPicCell class] forCellReuseIdentifier:@"MJHeMaiPicCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView reloadData];
    
//    self.view.backgroundColor = UIColor.greenColor;
    self.tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    
    self.picArr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 165;
    }else if (indexPath.section == 1) {
        return 40;
    }
    return (ScreenW - 60)/4 * 3 + 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MJHeMaiOrderCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
        return cell;
    }else if (indexPath.section == 1) {
        MJHeMaiQianHaoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"MJHeMaiQianHaoCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.LB1.font = cell.LB2.font =cell.LB3.font =cell.LB4.font = kFont(14);
            cell.LB1.textColor = cell.LB2.textColor =cell.LB3.textColor = CharacterColor50;
            [cell.leftBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
            [cell.rigthBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        }else {
            cell.LB1.font = cell.LB2.font =cell.LB3.font = kFont(13);
            cell.leftBt.titleLabel.font = cell.rigthBt.titleLabel.font = kFont(13);
            cell.LB1.textColor = cell.LB2.textColor =cell.LB3.textColor = CharacterColor50;
      
        }
        cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
        return cell;
    }
    MJHeMaiPicCell * cell =[tableView dequeueReusableCellWithIdentifier:@"MJHeMaiPicCell" forIndexPath:indexPath];
    cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
    Weak(weakSelf);
    cell.delectBlock = ^(NSInteger index) {
        weakSelf.picArr[index] = @"";
    };
    cell.addPicBlock = ^(NSInteger index) {
        if (index == 0) {
            [weakSelf addVideo];
        }else {
            [weakSelf addPicWithIndex:index];
        }
    };
    cell.picArr = self.picArr;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

//天机图片或者视频
- (void)addPicWithIndex:(NSInteger)index {
    
    self.selectIndex = index;
    
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
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"head";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:@[self.image] name:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            
            [self.tableView reloadData];
            self.picArr[self.selectIndex] = responseObject[@"data"];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


- (void)addVideo {
    
    [self showAlertV];
    
    
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
            self.picArr[0] =  [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            [self.tableView reloadData];
        }else {
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}


@end
